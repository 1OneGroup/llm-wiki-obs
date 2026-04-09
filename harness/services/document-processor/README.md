# Document Processor

Ingests source documents: extracts text, runs OCR if needed, splits into semantic chunks.

## Supported Formats
- PDF (with optional Mistral OCR for scanned docs)
- HTML / web pages
- Plain text, Markdown
- Excel (openpyxl)

## Output
Chunks stored in Supabase with PGroonga full-text search index.

## Configuration
See `config.yaml` — set OCR provider, chunk size, overlap.

## Implementation
TBD — user will provide implementation details.
