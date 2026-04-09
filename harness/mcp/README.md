# MCP Server

The MCP server exposes wiki tools to Claude.

## Tools

### `guide`
Returns an explanation of the wiki workflow and available knowledge bases.

### `search(query, kb_id?)`
Full-text search across document chunks. Returns ranked results with source references.

### `read(path, page_start?, page_end?)`
Read a source document. Supports page ranges for large PDFs.

### `write(path, content)`
Create or update a wiki page. Path is relative to vault root (e.g., `Marketing Department/wiki/brand/brand-voice.md`).

### `delete(path_or_glob)`
Archive documents matching the path or glob pattern.

## Authentication
Supabase JWT — see `config.json`.

## Running the Server
Implementation TBD — user will provide node definitions.
