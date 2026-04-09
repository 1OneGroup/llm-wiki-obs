# obs+llmwiki — LLM Wiki Vault

This is an Obsidian vault powered by LLM Wiki (Claude writes wiki pages via MCP) with an Archon-style agent harness.

## Vault Structure

- `_vault/` — Cross-department Obsidian dashboard pages
- `_attachments/` — Shared media assets
- `harness/` — Shared agent infrastructure (MCP server, services, nodes, workflows)
- `Marketing Department/` — Marketing wiki, agents, skills, workflows

## How It Works

1. Drop source documents into `[Department]/sources/`
2. Run `harness/workflows/wiki-ingest.yaml` to process them
3. Claude (via MCP) writes wiki pages into `[Department]/wiki/`
4. Obsidian reads the pages natively — no export needed

## Departments

- [[Marketing Department/CLAUDE]] — One Group Developers marketing operations

## For Claude

- Always read `[Department]/CLAUDE.md` before starting any department work
- Read `[Department]/_context/INDEX.md` to find relevant context files
- Wiki pages live in `[Department]/wiki/` — write here via MCP tools
- Never modify files in `[Department]/sources/` — those are read-only
- Working drafts go in `[Department]/working/` — gitignored
