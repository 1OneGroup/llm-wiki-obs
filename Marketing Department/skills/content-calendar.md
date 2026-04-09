# Skill: Content Calendar

> Research trends, check festivals, and plan the week's social media content for One Group Developers.

| Field | Value |
|-------|-------|
| Trigger | User-initiated — user requests a batch of social media content. Scope is flexible: full month, fortnight, single week, or ad-hoc post. |
| SOP | `_workflows/social-post-sop.md` |
| Owner | social-media-manager |

## Context Files

Read these before starting:

- `_context/social_media_manager/content-strategy.md` — volume targets, categories, platform rules
- `_context/social_media_manager/festival-calendar.md` — check dates within 2-week planning horizon
- `_context/company_marketing/active-projects.md` — active project index (then read linked project files)
- `_templates/sample-content-calendar.md` — reference week and what's already planned

## Steps

1. Read all context files listed above
2. Fetch Google Trends RSS for real estate relevance (see Tool Integrations)
3. Plan posts balancing: corporate/festival + viral/trending + project promotion
4. For each post specify: content type, project, platforms, date, brief, regional targeting
5. Present the plan for approval — do NOT create content until approved
6. After approval, update `_templates/sample-content-calendar.md`

## Rules

- Monthly volume: 10-20 unique posts across all categories
- Festival content: plan 2 weeks ahead
- Regional targeting: Punjab festivals → Mohali, Haryana festivals → Gurgaon/Rohtak
- Never fabricate project details
- **Project post briefs must specify:** use real facade/interior images from `_templates/designs/clermont/` or `_templates/designs/saavira/` — NEVER AI-generate building facades, site aerials, interior rooms, or amenity renders

## Tool Integrations

| Tool | Type | Details |
|------|------|---------|
| Google Trends RSS | HTTP feed | `https://trends.google.com/trending/rss?geo=IN` — filter for real estate relevance |
