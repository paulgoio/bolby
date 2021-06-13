FROM nginx:latest
COPY ./src/nginx.conf /etc/nginx
COPY ./src/html /srv/html
