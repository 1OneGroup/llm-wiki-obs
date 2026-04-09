# MCP Server — implementation placeholder
# Replace this with actual server code when harness/mcp/ is implemented.
# Currently the MCP server tools (guide, search, read, write, delete) are
# defined in harness/mcp/README.md — implementation is TBD.

FROM node:20-alpine

WORKDIR /app

# Copy harness config
COPY harness/mcp/config.json ./config.json

# Placeholder: start a basic HTTP server on port 8080
# Replace this CMD with your actual MCP server entrypoint
RUN echo '{"name":"llmwiki-mcp","version":"0.1.0"}' > package.json

EXPOSE 8080

CMD ["node", "-e", "\
  const http = require('http');\
  const cfg = require('./config.json');\
  http.createServer((req, res) => {\
    res.writeHead(200, {'Content-Type':'application/json'});\
    res.end(JSON.stringify({status:'ok', tools: cfg.tools, message:'MCP server scaffold — implement harness/mcp/'}));\
  }).listen(8080, () => console.log('MCP scaffold running on :8080'));\
"]
