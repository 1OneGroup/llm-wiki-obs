# Agent Harness

Shared infrastructure for all departments.

## Components

- `mcp/` — MCP server: tools Claude uses to write/read/search wiki pages
- `services/` — Processing services: document processor, Obsidian formatter, search
- `nodes/` — Archon-style node type templates (user fills in implementations)
- `workflows/` — Global reusable workflow YAML definitions
- `database/` — Supabase/Postgres schema migrations

## Node Types

Three node types following Archon's pattern:
- **ai** — Claude executes a prompt with context
- **deterministic** — Shell command or script runs
- **human_approval** — Human reviews and approves before continuing

See `nodes/README.md` for authoring guide.

## MCP Tools Available to Claude

| Tool | Purpose |
|---|---|
| `guide` | Explain wiki workflow and available knowledge bases |
| `search` | Full-text search across documents and chunks |
| `read` | Read source documents with page ranges |
| `write` | Create or edit wiki pages |
| `delete` | Archive documents by path or glob pattern |

## Services

| Service | Purpose |
|---|---|
| `document-processor` | OCR, chunking, PDF/HTML ingestion |
| `obsidian-formatter` | Convert raw text to Obsidian markdown with frontmatter and wikilinks |
| `search` | PGroonga full-text search index |
