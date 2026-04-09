# Sources

Raw source documents for the Marketing Department wiki.

## How to Add Sources

1. Drop your document here (PDF, HTML, Markdown, text)
2. Add an entry to `_intake-log.md`
3. Run `harness/workflows/wiki-ingest.yaml` with:
   - `source_path`: path to this file
   - `department`: `Marketing Department`
   - `page_name`: desired wiki page filename

## File Naming
Use lowercase kebab-case: `clermont-floor-plans.pdf`, `q1-campaign-report.md`

## Supported Formats
PDF, HTML, Markdown, plain text, Excel (.xlsx)

> [!warning] Read-Only Zone
> Files in `sources/` are read-only for agents. Never modify source documents.
> If a document needs updating, add a new version with a date suffix: `brief-v2-2026-04.pdf`
