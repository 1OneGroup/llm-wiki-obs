# Skill: Post to Postiz

> Publish approved social media content immediately via the Postiz platform.

| Field | Value |
|-------|-------|
| Trigger | User-initiated — content has already been approved before this step. |
| SOP | `_workflows/social-post-sop.md` (steps 5-6) |
| Owner | social-media-manager |

## Context Files

Read these before starting:

- `_context/company_marketing/brand-voice.md` — hashtags: brand + project + industry

## Steps

1. Get platform configuration and current UTC time
2. Verify target social accounts are connected
3. Publish with copy, image, platform IDs — publish immediately (content is already user-approved)
4. Report: platforms targeted, publish status

## Rules

- **Publish immediately** — content is already user-approved before reaching this step
- **Verify accounts first** — always confirm social accounts are connected before publishing
- **Rate limit:** 30 requests/hour
- **Hashtags:** use brand + project + industry from `_context/company_marketing/brand-voice.md`

## Tool Integrations

| Tool | Type | Details |
|------|------|---------|
| Postiz | MCP (social publishing) | **Functions:** `POSTIZ_GET_CONFIG_ID` (get config + UTC time), `POSTIZ_PROVIDERS_LIST` (verify connected accounts), `POSTIZ_SCHEDULE_POST` (publish with `type: "now"`) |
