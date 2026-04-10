---
title: Harness Nodes
tags: [vault, nodes, harness, reference]
date_updated: 2026-04-09
---

# Harness Nodes

> [!info] Nodes are atomic steps in a workflow. Chain them via `inputs`/`outputs`.
> Source files live in `harness/nodes/`. Three types: **ai**, **deterministic**, **human**.

---

## AI Nodes
> Claude executes a prompt with context. Can read files, call MCP tools, write wiki pages.

| Node | ID | Description | File |
|---|---|---|---|
| Research | `research` | Deep research on a topic using web + wiki context | `harness/nodes/ai/research.yaml` |
| Generate Content | `generate-content` | Write post copy, captions, and carousel scripts | `harness/nodes/ai/generate-content.yaml` |

---

## Deterministic Nodes
> Shell command or MCP tool runs. Predictable, testable, no AI inference.

| Node | ID | Description | Inputs | File |
|---|---|---|---|---|
| Trending | `trending` | Fetch Google Trends RSS for IN / PB / HR, filter for real estate | — | `harness/nodes/deterministic/trending.yaml` |
| Generate Image | `generate-image` | Call Nano Banana MCP to generate image from a post package prompt | `post_package` | `harness/nodes/deterministic/generate-image.yaml` |
| Generate Graphic | `generate-graphic` | **Global reusable.** Lookup assets-wiki → reuse existing asset or generate via Nano Banana | `user_prompt`, `project`, `purpose` | `harness/nodes/deterministic/generate-graphic.yaml` |
| Publish Postiz | `publish-postiz` | Push final content + image to Postiz scheduling queue | `post_package`, `image_path` | `harness/nodes/deterministic/publish-postiz.yaml` |

---

## Human Nodes
> Pause workflow. Human reviews and approves or rejects before continuing.

| Node | ID | Description | File |
|---|---|---|---|
| *(none yet — use template)* | — | — | `harness/nodes/human/_template.yaml` |

---

## Using `/generate-graphic`

The most versatile standalone node — works like `/trending`.

```yaml
# Minimum inputs
user_prompt: "rooftop infinity pool at golden hour, wide angle"
project: "saavira"           # maps to _attachments/designs/saavira/
purpose: "instagram-carousel"

# Optional
style: "photorealistic"      # photorealistic | cinematic | editorial
dimensions: "1080x1080"      # 1080x1080 | 1080x1920 | 1920x1080
output_slug: "pool-sunset"
```

**Decision logic:**
1. Reads `_attachments/designs/{project}/_index.md` (assets-wiki)
2. If a matching asset exists → returns its path (no generation cost)
3. If no match → calls **Nano Banana MCP** to generate, saves to `_attachments/generated/`

---

## Templates

| Template | Path |
|---|---|
| AI node | `harness/nodes/ai/_template.yaml` |
| Deterministic node | `harness/nodes/deterministic/_template.yaml` |
| Human approval node | `harness/nodes/human/_template.yaml` |

> See `harness/nodes/README.md` for authoring guide.
