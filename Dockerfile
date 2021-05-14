FROM nginx:latest
COPY ./src/nginx.conf /etc/nginx
COPY ./src/html /srv/html
HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD curl --fail http://127.0.0.1:80 || exit 1