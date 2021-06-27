FROM tdewolff/minify:latest as builder
COPY ./src/html /src/html
RUN cd / && minify --recursive --output . src/

FROM nginx:latest
COPY ./src/nginx.conf /etc/nginx
COPY --from=builder /src/html /srv/html
