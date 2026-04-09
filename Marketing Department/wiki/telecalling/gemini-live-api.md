---
title: Gemini Live Bridge — API & Operational Reference
tags: [marketing, telecalling]
date_created: 2026-04-09
sources: [gemini-live-api.md]
---

# Gemini Live Bridge — API & Operational Reference

> **Part 2 of 3** — API endpoints, call lifecycle, campaign engine, WhatsApp integration, cost tracking, and analytics.
>
> Companion pages:
> - [[telecalling/gemini-live-ops]] — Deployment, configuration, environment variables, technical learnings, AI agent prompt system
> - [[telecalling/telecalling-prompts]] — Ritu AI agent scripts and prompt best practices

**Version:** 1.0 | **Last Updated:** 2026-04-04
**Public URL:** `https://gemini-live.tech.onegroup.co.in`

---

## 6. API Reference

### 6.1 Health & Status

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/health` | Server health, active session count, session details |

**Response:**
```json
{
  "status": "ok",
  "sessions": 0,
  "pending": 0,
  "activeSessions": [{
    "streamId": "...",
    "callUuid": "...",
    "geminiReady": true,
    "geminiWsState": 1,
    "plivoWsState": 1,
    "ageMs": 45000,
    "lastPong": 2000,
    "reconnecting": false
  }]
}
```

### 6.2 Call Management

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/call` | Initiate a single outbound call |
| `GET` | `/api/calls` | List all calls (sorted by most recent) |
| `GET` | `/api/calls/:callUuid` | Get detailed call info including transcript, cost breakdown |

**POST /call Request:**
```json
{
  "to": "+919876543210",
  "customer_name": "Rahul"
}
```

**GET /api/calls/:callUuid Response** includes computed `costINR`:
```json
{
  "costINR": {
    "plivo": 0.55,
    "gemini": 1.23,
    "total": 1.78,
    "model": "models/gemini-3.1-flash-live-preview",
    "modelName": "Gemini 3.1 Flash Live"
  }
}
```

### 6.3 Plivo Webhooks

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/answer` | Plivo answer URL — returns Stream XML for bidirectional audio |
| `WS` | `/media-stream` | WebSocket endpoint for Plivo bidirectional audio |
| `POST` | `/hangup` | Plivo hangup callback — records duration, hangup cause, classifies outcome |
| `POST` | `/recording-callback` | Plivo recording URL callback |
| `POST` | `/recording-status` | Plivo recording status callback |
| `POST` | `/stream-status` | Plivo stream status callback |
| `POST` | `/machine-detection` | Plivo AMD callback — detects voicemail, hangs up immediately |

**Answer URL XML Response:**
```xml
<Response>
  <Record recordSession="true" action="{PUBLIC_URL}/recording-callback"
          startRecordingAudio="{PUBLIC_URL}/recording-status" maxLength="3600" redirect="false" />
  <Stream bidirectional="true" keepCallAlive="true" contentType="audio/x-mulaw;rate=8000"
          statusCallbackUrl="{PUBLIC_URL}/stream-status">
    wss://gemini-live.tech.onegroup.co.in/media-stream
  </Stream>
</Response>
```

### 6.4 Prompt Management

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/prompt` | Get current active prompt (with override status and default) |
| `POST` | `/api/prompt` | Save file-based prompt override |
| `DELETE` | `/api/prompt` | Reset to default prompt |
| `GET` | `/api/prompts` | List all named prompts |
| `POST` | `/api/prompts` | Create a named prompt (`{ name, body, is_active }`) |
| `GET` | `/api/prompts/:id` | Get specific prompt |
| `PATCH` | `/api/prompts/:id` | Update prompt name/body |
| `DELETE` | `/api/prompts/:id` | Delete a named prompt |
| `POST` | `/api/prompts/:id/activate` | Set prompt as active (deactivates others) |
| `DELETE` | `/api/prompts/active` | Deactivate all prompts (fall back to file/default) |

### 6.5 Campaign Management

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/campaigns` | List all campaigns with stats and running status |
| `POST` | `/api/campaigns` | Create campaign (`{ name, prompt_override, batch_size, max_concurrent, whatsapp_message_key }`) |
| `GET` | `/api/campaigns/:id` | Campaign detail with stats, analyses, batch count, runner status |
| `PATCH` | `/api/campaigns/:id` | Update campaign settings |
| `DELETE` | `/api/campaigns/:id` | Delete campaign (cascades to contacts and analyses) |
| `POST` | `/api/campaigns/:id/upload` | Upload contacts (CSV or JSON array) |
| `POST` | `/api/campaigns/:id/start` | Start batch execution |
| `POST` | `/api/campaigns/:id/pause` | Pause running campaign |
| `POST` | `/api/campaigns/:id/cancel` | Cancel campaign |
| `GET` | `/api/campaigns/:id/contacts` | List contacts (query: `?batch=&status=&outcome=&limit=&offset=`) |
| `GET` | `/api/campaigns/:id/batches` | List all batches with stats and analyses |
| `POST` | `/api/campaigns/:id/batches/:num/approve` | Approve batch analysis, optionally update prompt/batch_size, resume |
| `GET` | `/api/campaigns/:id/batches/:num/analysis` | Get AI batch analysis |
| `GET` | `/api/campaigns/:id/callbacks` | List contacts with callback outcome |
| `POST` | `/api/campaigns/:id/trigger-callbacks` | Trigger due callbacks (calls contacts whose callback_date has passed) |
| `POST` | `/api/campaigns/:id/auto-callback` | Toggle auto-callback (`{ enabled: true/false }`) |

**CSV Upload Format:**
```csv
phone,name,employee_name
9876543210,Rahul Sharma,Priya
8765432109,Amit Kumar,Neha
```
- Accepted phone column names: `phone`, `mobile`, `number`, `phone_number`
- Accepted name column names: `name`, `fullname`, `customer_name`, `contact_name`
- Accepted employee column names: `employeename`, `employee_name`, `employee`, `agent`
- Phone normalization: 10-digit → prepend `+91`; leading `0` → replace with `+91`
- Max 10,000 contacts per campaign
- Auto-batched according to campaign's `batch_size` setting

### 6.6 Model Selection

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/model` | Get active model and available models with pricing |
| `POST` | `/api/model` | Switch active model (`{ model: "models/gemini-3.1-flash-live-preview" }`) |

**Available Models:**
| Model ID | Name | Audio In (per 1M tokens) | Audio Out (per 1M tokens) |
|----------|------|--------------------------|---------------------------|
| `models/gemini-3.1-flash-live-preview` | Gemini 3.1 Flash Live | $3.00 | $12.00 |
| `models/gemini-2.5-flash-live-preview` | Gemini 2.5 Flash Live | $3.00 | $12.00 |

### 6.7 Analytics

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/analytics` | Comprehensive analytics dashboard data |

**Response Structure:**
```json
{
  "summary": {
    "totalCampaigns": 3,
    "totalContacts": 500,
    "totalCompleted": 350,
    "totalInterested": 45,
    "totalBrochures": 30,
    "totalCalls": 400,
    "completedCalls": 350,
    "avgDuration": 42,
    "totalMinutes": 245.3,
    "overallConnRate": 70,
    "overallIntRate": 13
  },
  "cost": {
    "plivo": 181.52,
    "gemini": 94.20,
    "total": 275.72,
    "geminiMethod": "tokens",
    "perCall": 0.79,
    "perInterested": 6.13,
    "tokens": { "input": 12500000, "output": 8300000, "total": 20800000 },
    "activeModel": "models/gemini-3.1-flash-live-preview",
    "rates": {
      "plivo": 0.74,
      "geminiPerMin": 1.93,
      "totalPerMin": 2.67,
      "usdToInr": 84,
      "currency": "INR"
    }
  },
  "outcomes": {
    "interested": 45, "not_interested": 120, "callback": 35,
    "no_answer": 100, "busy": 30, "brochure_sent": 30, "voicemail": 15
  },
  "campaignPerformance": [...],
  "callsByDay": { "2026-04-03": 50, "2026-04-02": 65 },
  "costByDay": { "2026-04-03": 45.50, "2026-04-02": 58.20 }
}
```

### 6.8 WhatsApp Brochures

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/brochures` | List configured brochures |
| `POST` | `/api/brochures` | Add/update brochure (`{ key, name, url, caption }`) |
| `DELETE` | `/api/brochures/:key` | Remove brochure config |

### 6.9 Employee WhatsApp Instances

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/employee-instances` | List all employee-to-instance mappings |
| `POST` | `/api/employee-instances` | Create mapping (`{ employee_name, instance_name, phone, status }`) |
| `PATCH` | `/api/employee-instances/:id` | Update mapping |
| `DELETE` | `/api/employee-instances/:id` | Delete mapping |
| `GET` | `/api/employee-instances/auto-detect` | Auto-detect employees from campaign contacts and show mapping status |
| `GET` | `/api/evolution/instances` | List all Evolution API WhatsApp instances |
| `POST` | `/api/evolution/create-instance` | Create new Evolution API instance (`{ instance_name }`) |
| `GET` | `/api/evolution/*` | Proxy GET requests to Evolution API |

### 6.10 Dashboard

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/` or `/dashboard` | Serves the single-page web dashboard |

---

## 9. Call Lifecycle

### Phase 1: Pre-Warm (Before Dial)
1. `makeCall()` generates temporary UUID
2. Opens WebSocket to `wss://generativelanguage.googleapis.com/ws/...`
3. Sends setup message with model config, system instruction, voice, VAD, tools
4. Waits for `setupComplete` (timeout: 10 seconds)
5. Typical setup time: ~355ms

### Phase 2: Dial
6. Once Gemini is ready, places Plivo outbound call
7. Remaps session from temp UUID to Plivo's `request_uuid`
8. Creates call store entry with metadata
9. Plivo's `machine_detection` enabled (5 second window)

### Phase 3: Connection
10. Callee answers → Plivo hits `/answer` URL
11. Answer returns Stream XML → Plivo opens WebSocket to `/media-stream`
12. `start` event received → Plivo WS attached to pre-warmed Gemini session
13. Opening greeting triggered via `realtimeInput.text`

### Phase 4: Conversation
14. Bidirectional audio flows with codec conversion
15. Gemini handles VAD (voice activity detection) with configured sensitivity
16. Transcriptions buffered and flushed on `turnComplete`
17. Token usage tracked from `usageMetadata`
18. Tool calls handled: `end_call` → hangup after 2s; `send_brochure` → WhatsApp delivery

### Phase 5: Termination
19. **Agent-initiated:** Closing phrase detected → auto-hangup after 3s, OR `end_call` tool called
20. **User-initiated:** Callee hangs up → Plivo `stop` event → cleanup
21. **AMD:** Voicemail detected → immediate Gemini close + Plivo hangup
22. **Gemini disconnect:** One reconnection attempt; if that fails, hangup
23. **Session timeout:** Warning at 9 minutes (Gemini's ~10 min limit)

### Phase 6: Post-Call
24. Plivo `/hangup` callback → records duration, hangup cause
25. After 5 seconds, `classifyCallOutcome()` analyzes transcript
26. Callback timing extracted if applicable
27. Session cleaned up (intervals cleared, WebSockets closed)

---

## 10. Campaign & Batch Engine

### Campaign States

```
draft → running → awaiting_approval → running → ... → completed
  ↕         ↓           ↓
 paused  ← paused     paused
  ↕
cancelled
```

### Batch Execution Flow

```
For each batch (1 to N):
  │
  ├── Check if existing analysis awaiting approval → pause
  │
  ├── For each pending contact in batch:
  │     ├── Mark as 'calling'
  │     ├── makeCall(phone, name, promptOverride, whatsappKey, employeeName)
  │     ├── Wait for completion (poll every 3s, max 5 min)
  │     ├── Classify outcome
  │     ├── Update contact record
  │     ├── Track consecutive failures (3 → auto-pause)
  │     └── Cooldown 5 seconds
  │
  ├── Batch complete → Run AI analysis (Gemini 2.5 Flash)
  │     ├── Collects stats + up to 20 transcripts
  │     ├── Generates: summary, recommendations, prompt_adjustments
  │     └── Saves to batch_analyses table
  │
  └── If not last batch → Pause for human review
      └── Human approves → optionally updates prompt/batch_size → resumes next batch
```

### Campaign Lifecycle (batch-engine.js)

1. `startCampaign(id)` — Validates campaign, starts async batch loop
2. `runBatchLoop(id, runner)` — Iterates through batches sequentially
3. `runBatch(id, batchNumber, runner)` — Calls each pending contact in the batch
4. `waitForCallCompletion(callUuid, timeout)` — Polls call store every 3s for up to 5 minutes
5. `classifyOutcome(call)` — Determines call result (interested, not_interested, callback, no_answer, busy, brochure_sent, voicemail)
6. `runBatchAnalysis(id, batchNumber)` — Sends batch stats + transcripts to Gemini 2.5 Flash for analysis
7. Campaign pauses for human review → `approve` endpoint resumes next batch

### AI Batch Analysis

Between batches, the engine sends a comprehensive prompt to Gemini 2.5 Flash (text model) with:
- Batch statistics (total, completed, failed, outcomes breakdown)
- Up to 20 call transcripts with names, outcomes, durations
- Requests structured JSON analysis: `{ summary, recommendations, prompt_adjustments }`

This creates a feedback loop where prompt engineering can be iteratively improved based on actual call results.

### Auto-Callback Cron

> [!note] Auto-Callback Schedule
> Runs daily at **11:00 AM IST** (5:30 AM UTC). Checks all campaigns with `auto_callback = 1`. Calls contacts whose `callback_date` has passed. 5-second cooldown between calls.

---

## 12. WhatsApp Integration

### Architecture

```
Gemini → send_brochure tool call → server.js
  → whatsapp.js → Evolution API → WhatsApp Business → Customer
```

### Brochure Configuration

Stored in `/data/brochures.json`:
```json
{
  "clermont": {
    "name": "The Clermont",
    "url": "https://onegroup.co.in/brochures/clermont.pdf",
    "caption": "Here is The Clermont brochure — premium 3BHK independent floors in Sector 98, Mohali."
  }
}
```

### Employee-Based Routing

When an employee name is associated with a contact (from CSV upload):
1. System looks up `employee_instances` table
2. Finds the Evolution API instance mapped to that employee
3. Sends the WhatsApp message from that employee's number/instance
4. Falls back to default instance if no mapping found

### Media Type Handling
| Type | Detection | API Endpoint |
|------|-----------|-------------|
| PDF/Documents | `.pdf`, `.doc`, `.xlsx`, etc. | `sendMedia` (mediatype: document) |
| Images | `.png`, `.jpg`, `.gif`, `.webp` | `sendMedia` (mediatype: image) |
| Videos | `.mp4`, `.mov`, `.avi` | `sendMedia` (mediatype: video) |
| Links/YouTube | YouTube URLs or non-file URLs | `sendText` (URL in message body) |

---

## 13. Cost Tracking & Analytics

### Cost Components

| Component | Rate | Unit | Currency |
|-----------|------|------|----------|
| Plivo (telephony) | 0.74 | per minute | INR |
| Gemini audio input | 3.00 | per 1M tokens | USD |
| Gemini audio output | 12.00 | per 1M tokens | USD |
| Gemini time-based (fallback) | ~0.023 | per minute | USD |
| USD to INR conversion | 84 | — | — |

### Cost Calculation Methods

1. **Token-based** (preferred) — Uses actual `usageMetadata` from Gemini:
   - `(inputTokens / 1M * audioInputRate + outputTokens / 1M * audioOutputRate) * USD_TO_INR`
2. **Time-based** (fallback) — When token data unavailable:
   - `duration_minutes * (audioInputPerMin + audioOutputPerMin) * USD_TO_INR`

### Per-Call Cost (GET /api/calls/:uuid)
```json
{
  "costINR": {
    "plivo": 0.55,
    "gemini": 1.23,
    "total": 1.78,
    "model": "models/gemini-3.1-flash-live-preview",
    "modelName": "Gemini 3.1 Flash Live"
  }
}
```

### Analytics Dashboard Metrics
- Total campaigns, contacts, completed calls, interested leads, brochures sent
- Connection rate, interest rate
- Average call duration
- Cost breakdown: Plivo vs Gemini, per call, per interested lead
- Daily call volume and cost trends
- Campaign-level performance comparison
- Outcome distribution

---

## Related Pages

- [[telecalling/gemini-live-ops]] — Deployment, configuration, technical learnings, AI agent setup
- [[telecalling/telecalling-prompts]] — Ritu AI agent scripts and prompt design guide
