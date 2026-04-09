# Skill: Graphic Design

> Generate a branded visual for One Group Developers using an image generation tool.

| Field | Value |
|-------|-------|
| Trigger | User-initiated — user or social-media-manager provides an image brief (concept, platform, aspect ratio, project). |
| SOP | `_workflows/graphic-design-sop.md` |
| Owner | graphic-designer |

## Context Files

Read these before starting:

- `_context/company_marketing/brand-voice.md` — colors, fonts, aesthetic, do's/don'ts
- `_context/graphic_design_manager/post-templates.md` — match the brief to one of the 10 post-template categories and pull layout, typography, color/mood, and copy formula
- `_templates/designs/` — reference existing designs for style consistency
- If project-specific: read the relevant project file in `_context/`

## Logos

| Variant | File | When to Use |
|---------|------|-------------|
| Standard | `_templates/logos/one-group-logo.png` | Dark or maroon backgrounds |
| Reverse | `_templates/logos/one-group-logo-reverse.png` | Light or ivory backgrounds |

## Brand Assets

| Asset | Details |
|-------|---------|
| Primary colors | `#6B1C23` (maroon), `#F9F6F1` (ivory), `#C9A962` (gold) |
| Aesthetic | Quiet luxury, professional, clean composition |

## Steps

1. Read all context files listed above
2. Match the brief to one of the 10 post-template categories from `post-templates.md` — pull layout, typography, color/mood, and copy formula
3. Check `_templates/designs/` for style consistency with existing work
4. If project-specific: read the relevant project file in `_context/`
5. **Source project images** — see Image Sourcing Rule below
6. Generate image including:
   - Brand colors listed above
   - Logo: select correct variant (standard for dark bg, reverse for light bg)
   - Aesthetic: "quiet luxury, professional, clean composition"
   - Aspect ratio per category template, or fallback: 1:1 (IG feed), 16:9 (LinkedIn/FB), 9:16 (Stories)
7. Save to `working/social-media/`
8. Present for approval

## Image Sourcing Rule — CRITICAL

For any post involving a project (Clermont or Saavira), use ONLY provided assets:

| Project | Folder | Assets |
|---------|--------|--------|
| The Clermont | `_templates/designs/clermont/` | 30 images — exteriors, interiors, amenities |
| The Saavira | `_templates/designs/saavira/` | 32 images + 13 videos — exteriors, interiors, amenities, aerials |

- Read `_index.md` in each folder to find the right image by description

**NEVER generate:**
- Building facades or renders
- Site photos or aerials
- Interior room shots
- Amenity renders
- Any visual representing the actual property

**AI generation allowed ONLY for:**
- Decorative/abstract elements
- Text overlays
- Backgrounds and borders
- Compositional framing around real project images

> If the post is **not** project-specific (e.g., generic festival greeting, educational carousel), this rule does not apply — generate imagery freely following the category template.

## Don'ts

No flashy sale banners, no stock photo feel, no clutter, no banned words in text overlays.

## Review Checklist

- [ ] Prompt uses the correct post-template category from `post-templates.md`?
- [ ] Project building/interior images sourced from `_templates/designs/`, not AI-generated?
- [ ] Text overlay follows the copy formula from the matched category?
- [ ] Brand colors dominant? Logo visible and correctly placed?
- [ ] Premium but not flashy? No banned words in text overlay?
- [ ] Correct aspect ratio for the platform and category?

## Tool Integrations

| Tool | Type | Details |
|------|------|---------|
| Nano Banana | MCP (image generation) | Text-to-image generation. Include brand colors, logo, and aesthetic in the prompt. |
