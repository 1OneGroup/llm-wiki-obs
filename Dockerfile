# Serves the obs+llmwiki vault as a browsable static site via nginx.
# The vault is mounted at /vault via docker-compose volume.
# MCP server implementation (harness/mcp/) is TBD — tracked in harness/mcp/README.md.

FROM nginx:alpine

# Custom nginx config — serve /vault with directory browsing
RUN printf 'server {\n\
    listen 80;\n\
    root /vault;\n\
    autoindex on;\n\
    autoindex_exact_size off;\n\
    autoindex_localtime on;\n\
    charset utf-8;\n\
    location / {\n\
        try_files $uri $uri/ =404;\n\
    }\n\
    # Serve .md files as plain text so browser displays them\n\
    location ~* \\.md$ {\n\
        add_header Content-Type "text/plain; charset=utf-8";\n\
    }\n\
    # Serve images/videos inline\n\
    location ~* \\.(jpg|jpeg|png|gif|mp4|webp|svg)$ {\n\
        expires 7d;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 80
