# Database

Supabase/Postgres schema for storing document chunks, wiki metadata, and workflow state.

## Extensions Required
- `pgvector` — vector embeddings (optional, for semantic search)
- `pgroonga` — full-text search

## Migrations

Run migrations in order: `001_initial_schema.sql`, then any subsequent files.

## Schema Overview

| Table | Purpose |
|---|---|
| `knowledge_bases` | One per department |
| `documents` | Source files (PDFs, articles) |
| `document_chunks` | Semantic chunks with PGroonga index |
| `wiki_pages` | Generated wiki page metadata |
| `workflow_runs` | Workflow execution history |

## Implementation
TBD — migrations will be added when the database is set up.
