# Node Type Templates

Nodes are atomic steps in a workflow. Three types follow Archon's pattern.

## Node Types

### `ai`
Claude executes a prompt. Can read context files, use MCP tools, write wiki pages.

```yaml
- id: my-ai-node
  type: ai
  description: "What this node does"
  prompt: |
    Your prompt here. Use {{variable}} for inputs.
  inputs: [variable_name]
  outputs: [output_name]
```

### `deterministic`
A shell command or script runs. No AI involved — predictable, testable.

```yaml
- id: my-deterministic-node
  type: deterministic
  description: "What this node does"
  command: "python script.py --input {{input_file}}"
  inputs: [input_file]
  outputs: [output_file]
```

### `human_approval`
Pauses the workflow. A human reviews and either approves (continues) or rejects (stops/revises).

```yaml
- id: my-approval-node
  type: human_approval
  description: "What the human reviews"
  message: "Please review {{item}} and approve or request changes."
  inputs: [item]
```

## Writing a Workflow

1. Copy the appropriate template from `ai/`, `deterministic/`, or `human/`
2. Chain nodes with `inputs`/`outputs` — outputs from node N become inputs for node N+1
3. Save to `[Department]/workflows/` or `harness/workflows/` for global workflows
4. Run with the workflow executor (TBD)
