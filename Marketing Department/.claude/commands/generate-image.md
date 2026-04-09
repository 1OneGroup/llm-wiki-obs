---
description: Generate a social post image using Nano Banana 2 MCP based on a content brief
---

Generate a social media image for One Group Developers using Nano Banana 2 MCP.

## Context to Load First
- Read `Marketing Department/wiki/brand/brand-voice.md` — brand colors, aesthetic
- Read `Marketing Department/wiki/design/post-templates.md` — template specifications

## Image Rules (CRITICAL)
- **NEVER** AI-generate: building facades, site photos, aerial views, interior rooms, amenity renders of The Clermont or The Saavira
- **DO** AI-generate: decorative backgrounds, text overlays, abstract patterns, lifestyle scenes (no identifiable project buildings)
- **Real project photos** → use files from `_attachments/designs/` (clermont/ or saavira/)

## Brand Specifications
- Colors: #6B1C23 (Deep Maroon) · #F9F6F1 (Warm Ivory) · #C9A962 (Aged Gold)
- Fonts: Georgia (serif headers) · Arial (sans-serif body)
- Aesthetic: Quiet luxury — premium, clean, not flashy
- Logo: bottom-right corner, small, non-intrusive

## Nano Banana 2 Prompt Structure
When calling Nano Banana MCP, structure the prompt as:
```
[Subject/scene description], [style: photorealistic/graphic design], [color palette: #6B1C23/#F9F6F1/#C9A962], [mood: quiet luxury, premium, professional], [composition: clean, balanced], [dimensions: WxH]
```

## If given a content brief JSON
Parse the brief and:
1. Check `visual_direction.ai_generation_allowed`
2. If true: build Nano Banana prompt from `nano_banana_prompt` field + brand specs
3. If false: confirm `real_photo_path` exists in `_templates/designs/`
4. Call Nano Banana MCP (or return the real photo path)
5. Save generated image to `Marketing Department/working/images/`
