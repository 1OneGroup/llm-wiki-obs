# Marketing Department — One Group Developers

## Purpose
Marketing operations for One Group Developers: social media content, graphic design, and telecalling campaigns.

## Company Quick Facts
- **Company:** ONE Group Developers
- **Tagline:** "The One You Can Trust"
- **Colors:** Deep Maroon #6B1C23 · Warm Ivory #F9F6F1 · Aged Gold #C9A962
- **Values:** O-N-E (Ownership, No Compromise, Excellence)

## Active Projects
- **The Clermont** — Sector 98, Mohali · 3BHK independent floors · Rs 1.60 Cr+ · RERA: PBRERA-SAS81-PR1246
- **The Saavira** — Sector 48, Gurugram · Ultra-luxury G+25 tower · Rs 4.38-5.92 Cr · RERA: GGM/904/636/2025/07

## Agents

| Agent | File | Role |
|---|---|---|
| Social Media Manager | `agents/social-media-manager.md` | Content planning, copywriting, Postiz publishing |
| Graphic Designer | `agents/graphic-designer.md` | Branded image generation via Nano Banana |
| Telecalling Manager | `agents/telecalling-manager.md` | Gemini Live AI voice campaigns |

## Skills

| Skill | File | Trigger |
|---|---|---|
| Content Calendar | `skills/content-calendar.md` | `/content-calendar` |
| Graphic Design | `skills/graphic-design.md` | `/graphic-design` |
| Post to Postiz | `skills/post-to-postiz.md` | `/post-to-postiz` |
| Telecalling Campaign | `skills/telecalling-campaign.md` | `/telecalling-campaign` |

## Wiki Structure
- `wiki/brand/` — Brand voice, story, company overview
- `wiki/projects/` — Clermont, Saavira, active projects
- `wiki/audience/` — Buyer personas
- `wiki/social-media/` — Content strategy, platform rules, caption templates
- `wiki/telecalling/` — Prompts, Gemini Live API reference, ops guide
- `wiki/design/` — Post templates and visual specifications

## For Claude
1. Read `_context/INDEX.md` first — it maps all context files
2. Load only what you need for the task (3-5 files max, avoid context rot)
3. Wiki pages live in `wiki/` — browse them in Obsidian
4. NEVER use AI-generated building photos — only real images from `_templates/designs/` in SupaSmart
5. Banned words: dream home, world-class, bespoke, ultra-luxury, exclusive offer, limited time, hurry

## Technology Stack
- Social scheduling: Postiz
- Image generation: Nano Banana MCP (Gemini-powered)
- Telecalling: Gemini Live API (AI agent "Ritu")
- Voice: Plivo (Rs 0.74/min)
- WhatsApp: Evolution API
