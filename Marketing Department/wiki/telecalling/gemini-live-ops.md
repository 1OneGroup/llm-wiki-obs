---
title: Gemini Live Bridge — Deployment & Operations
tags: [marketing, telecalling]
date_created: 2026-04-09
sources: [gemini-live-ops.md]
---

# Gemini Live Bridge — Deployment & Operations

> **Part 3 of 3** — Deployment, configuration, environment variables, technical learnings, troubleshooting, and the AI agent (Ritu) prompt system.
>
> Companion pages:
> - [[telecalling/gemini-live-api]] — API endpoints, call lifecycle, campaign engine, WhatsApp integration, cost tracking
> - [[telecalling/telecalling-prompts]] — Ritu AI agent scripts and prompt best practices

**Version:** 1.0 | **Last Updated:** 2026-04-04
**Public URL:** `https://gemini-live.tech.onegroup.co.in`

---

## 11. AI Agent (Ritu) — Prompt System

### Agent Persona
- **Name:** Ritu
- **Role:** Warm, professional female sales caller
- **Company:** ONE Group Developers
- **Language:** Professional Hinglish (predominantly English with natural Hindi phrases)
- **Voice:** Kore (Google prebuilt, Hindi-capable)

### Call Flow Script
1. **Opening:** Time-appropriate greeting → introduce The Clermont → ask buying intent → STOP (wait for response)
2. **Interested:** Acknowledge (varied words) → pitch key details → ask for site visit
3. **Busy:** Ask for callback time
4. **Not interested:** Thank warmly → end call
5. **Questions:** Answer from Project Facts (up to 4-5 sentences) → redirect to site visit
6. **Concerns:** Acknowledge → clear answer → redirect to site visit
7. **Decline visit:** Offer WhatsApp brochure
8. **Closing:** Thank → silently end call (no verbal "end call")

### Guardrails

> [!warning] Ritu AI Guardrails
> These rules are non-negotiable for all Ritu prompt variants.

- Max 2 sentences per turn (initiated), 4-5 when answering questions
- One question per turn
- Never repeat back what user said
- Never make up pricing/dates
- Never argue; if "no" twice, end warmly
- Don't discuss competitors by name
- Keep call under 180 seconds
- Varied acknowledgments (Fantastic/Excellent/Great/Wonderful/Perfect)
- May improvise naturally; English sentences in Hindi conversation OK

### Gemini Function Tools
| Tool | Description |
|------|-------------|
| `end_call` | End the phone call after final goodbye |
| `send_brochure(project_name)` | Send property brochure via WhatsApp |

### Prompt Priority System
1. **Active named prompt** (from `prompts` DB table) — highest
2. **File override** (`/data/prompt-override.txt`)
3. **Default hardcoded** (Clermont v5 in `prompts.js`)

> See [[telecalling/gemini-live-api]] Section 6.4 for prompt management API endpoints.

---

## 14. Deployment

### Docker Setup

**Dockerfile:**
```dockerfile
FROM node:22-alpine
RUN apk add --no-cache python3 make g++
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
RUN mkdir -p /data/calls
EXPOSE 8100
CMD ["node", "server.js"]
```

**docker-compose.yml:**
```yaml
services:
  gemini-live-bridge:
    build: .
    container_name: gemini-live-bridge
    restart: unless-stopped
    ports:
      - "8100:8100"
    volumes:
      - call-data:/data/calls
      - prompt-data:/data
    environment:
      - PORT=8100
      - GEMINI_API_KEY=${GEMINI_API_KEY}
      - GEMINI_MODEL=${GEMINI_MODEL:-models/gemini-3.1-flash-live-preview}
      - PLIVO_AUTH_ID=${PLIVO_AUTH_ID}
      - PLIVO_AUTH_TOKEN=${PLIVO_AUTH_TOKEN}
      - PLIVO_FROM_NUMBER=${PLIVO_FROM_NUMBER}
      - PUBLIC_URL=${PUBLIC_URL}
      - EVOLUTION_API_URL=${EVOLUTION_API_URL:-http://evolution-api-fgxi-api-1:8080}
      - EVOLUTION_API_KEY=${EVOLUTION_API_KEY}
      - EVOLUTION_INSTANCE=${EVOLUTION_INSTANCE:-main-whatsapp}
    networks:
      - paperclip-services
      - shared-proxy

volumes:
  call-data:    # /data/calls — call JSON files
  prompt-data:  # /data — DB, prompts, brochures, model override

networks:
  paperclip-services:
    external: true
  shared-proxy:
    external: true
```

### Network Topology
- **paperclip-services** — Internal network for Evolution API and other Paperclip services
- **shared-proxy** — Shared network for Caddy reverse proxy (TLS termination)

### Persistent Data
| Volume | Mount | Contents |
|--------|-------|----------|
| `call-data` | `/data/calls` | Per-call JSON files (metadata, transcripts) |
| `prompt-data` | `/data` | `campaigns.db`, `prompt-override.txt`, `model-override.txt`, `brochures.json` |

### Related Services on This VPS
- **Caddy** — TLS reverse proxy (ports 80/443)
- **Evolution API** — WhatsApp Business gateway (port 32804 externally, 8080 internally)
- **Paperclip** — Project management workspace (port 32770)

---

## 15. Configuration Reference

### Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `PORT` | No | `8100` | HTTP server port |
| `GEMINI_API_KEY` | **Yes** | — | Google AI API key |
| `GEMINI_MODEL` | No | `models/gemini-3.1-flash-live-preview` | Default Gemini Live model |
| `PLIVO_AUTH_ID` | **Yes** | — | Plivo account auth ID |
| `PLIVO_AUTH_TOKEN` | **Yes** | — | Plivo account auth token |
| `PLIVO_FROM_NUMBER` | **Yes** | — | Outbound caller ID (e.g. `+918031136555`) |
| `PUBLIC_URL` | **Yes** | — | Public HTTPS URL for webhooks |
| `EVOLUTION_API_URL` | No | `http://evolution-api-fgxi-api-1:8080` | Evolution API base URL |
| `EVOLUTION_API_KEY` | No | — | Evolution API key |
| `EVOLUTION_INSTANCE` | No | `main-whatsapp` | Default WhatsApp instance name |
| `DATA_DIR` | No | `/data` | Base directory for persistent data |

### Timing Constants

| Constant | Value | Location | Description |
|----------|-------|----------|-------------|
| `PING_INTERVAL_MS` | 15,000ms | server.js | WebSocket keepalive ping interval |
| `GEMINI_SESSION_MAX_MS` | 9 min | server.js | Warning before Gemini's 10-min limit |
| `STALE_SESSION_CHECK_MS` | 30,000ms | server.js | Stale session cleanup interval |
| `CALL_COOLDOWN_MS` | 5,000ms | batch-engine.js | Delay between batch calls |
| `MAX_CONSECUTIVE_FAILURES` | 3 | batch-engine.js | Auto-pause threshold |

---

## 16. Key Technical Learnings

> [!note] Critical Implementation Details
> These are hard-won learnings discovered during development. Review before modifying the platform.

### Gemini Live API Specifics

1. **Transcription config must use camelCase at ROOT level** — `inputAudioTranscription: {}` and `outputAudioTranscription: {}` go in the setup object root, NOT inside `generationConfig`.

2. **Use `realtimeInput.text` for text messages** — NOT `clientContent`. The `clientContent` format causes WebSocket 1007 errors with Gemini Live.

3. **Response modalities must be AUDIO only** — Setting `responseModalities: ['AUDIO', 'TEXT']` causes failures. Use `['AUDIO']` only, and rely on transcription config for text output.

4. **Race condition: Plivo connects before Gemini ready** — Handled with `_needsOpeningTrigger` flag. When Plivo's `start` event fires but Gemini hasn't sent `setupComplete`, the opening greeting is deferred.

5. **Session limit: ~10 minutes** — Gemini sends a `goAway` message before disconnecting. The server warns at 9 minutes.

6. **One reconnection attempt only** — If Gemini disconnects mid-call, one reconnection is attempted. If that also fails, the call is hung up.

### Audio Engineering

7. **Sample rate mismatch** — Plivo uses mulaw 8kHz; Gemini expects PCM 16kHz input and outputs PCM 24kHz. Upsampling (2x) and downsampling (3x) are handled in `audio-utils.js`.

8. **Audio buffering during reconnection** — Capped at 250 frames (~5 seconds) to prevent memory bloat.

9. **Interruption handling** — When Gemini signals `interrupted`, the server sends `clearAudio` to Plivo to stop buffered playback immediately.

### Call Quality

10. **Pre-warm strategy eliminates delay** — Gemini session is established (~355ms) before Plivo even dials. When the callee answers, audio bridging starts instantly.

11. **Kore voice** — Selected for Hindi/Hinglish capability with a female, professional tone.

12. **VAD sensitivity tuned low** — `START_SENSITIVITY_LOW` and `END_SENSITIVITY_LOW` with 300ms silence duration prevents false triggers in noisy phone environments.

13. **Auto-hangup on closing phrases** — Detects phrases like "have a wonderful day" and schedules hangup after 3 seconds, preventing awkward silence.

### Answering Machine Detection

14. **Plivo AMD** — Enabled with 5-second detection window. When voicemail is detected, Gemini session is immediately closed (saves tokens) and call is hung up.

---

## Related Pages

- [[telecalling/gemini-live-api]] — Full API reference, call lifecycle, campaign engine
- [[telecalling/telecalling-prompts]] — Ritu AI agent scripts and prompt design guide
