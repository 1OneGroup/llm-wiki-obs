---
description: Publish an approved post to social media via Postiz MCP
---

Publish the approved post to social media using Postiz.

## Pre-Flight Checks
Before publishing, verify:
- [ ] Caption has been reviewed — no banned words
- [ ] Image file exists at the specified path
- [ ] No active no-go period (Adhik Maas, Pitru Paksha, Monsoon — check content-strategy wiki)
- [ ] Post has human approval

## Postiz MCP Sequence

Always run in this order:

1. `POSTIZ_GET_CONFIG_ID` — gets config + current UTC time
2. `POSTIZ_PROVIDERS_LIST` — verifies connected accounts (Instagram, Facebook, LinkedIn)
3. `POSTIZ_SCHEDULE_POST` with `type: "now"` — publishes immediately

## Rate Limiting
Max 30 requests/hour. If approaching limit, pause and notify user.

## After Publishing
- Record post IDs and URLs
- Append entry to `Marketing Department/wiki/_log.md`:
  ```
  | [date] | Published | [platform] | [content angle] | [post URL] |
  ```

## If given a post_package JSON
Extract caption, hashtags, image path, and platforms from the JSON.
Map captions to correct platforms.
Run the 3-step Postiz sequence.
