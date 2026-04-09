# Global Workflows

Reusable workflow definitions available to all departments.

## Workflows

| File | Purpose |
|---|---|
| `wiki-ingest.yaml` | Ingest a source document → chunk → generate wiki page → human approval |
| `wiki-review.yaml` | Human reviews and approves a generated wiki page |

## Department Workflows

Each department has its own `workflows/` folder with department-specific pipelines
that compose these global workflows with department context.

## Running Workflows

Implementation TBD — user will provide the workflow executor.
