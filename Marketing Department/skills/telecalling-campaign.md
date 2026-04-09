# Skill: Telecalling Campaign

> Create and manage AI telecalling campaigns on the Gemini Live platform.

| Field | Value |
|-------|-------|
| Trigger | User-initiated — user requests a new telecalling campaign or asks to manage an existing one. |
| SOP | `_workflows/telecalling-sop.md` |
| Owner | telecalling-manager |

## Context Files

Read these before starting:

- `_context/company_marketing/brand-voice.md` — tone for call scripts must match brand voice
- `_context/telecaller_manager/telecalling-prompts.md` — sample prompts + best practices (follow this pattern)
- Per task: project files (`the-clermont.md`, `the-saavira.md`) for call script facts

## Steps — Creating a Campaign

1. Read project context from `_context/` for call script details
2. Read `_context/telecaller_manager/telecalling-prompts.md` — follow best practices and sample prompt structure
3. Create brand-compliant AI call script via prompts API
4. Configure WhatsApp messages via brochures API (optional)
5. Create campaign with name, batch size, call limits
6. Upload contacts CSV

## Steps — Running a Campaign

7. Start the campaign
8. Monitor analytics: connection rate, interest rate, costs
9. Review batch analysis — approve or adjust prompt
10. Trigger due callbacks

## Rules

- **Brand voice in ALL prompts** — confident, warm, no pressure, no urgency
- **Never fabricate** project details — use only verified data from `_context/`
- **Save working prompts** to `_context/telecaller_manager/telecalling-prompts.md`
- **Human-in-the-loop** — campaigns pause after each batch for review
- **Cost awareness** — Plivo Rs 0.74/min + Gemini tokens. Track cost per interested lead.

## Tool Integrations

| Tool | Type | Details |
|------|------|---------|
| Gemini Live | REST API | Base URL: `https://gemini-live.tech.onegroup.co.in` |
| | | `POST /api/prompts` — create AI call script |
| | | `POST /api/brochures` — configure WhatsApp messages |
| | | `POST /api/campaigns` — create campaign |
| | | `POST /api/campaigns/{id}/start` — start campaign |
| | | `GET /api/analytics` — monitor metrics |
| | | `POST /api/campaigns/{id}/trigger-callbacks` — trigger callbacks |
