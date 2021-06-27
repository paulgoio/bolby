FROM tdewolff/minify:latest as builder
COPY ./src/html /src/html
RUN cd / && minify -r -b -o src/html/js/custom.js src/html/js --match=(easing|waypoints|counterup|popper|isotope|infinite|imagesloaded|slick|validator|wow|morphext|parallax|magnific); \
sed -i -e "/js\/jquery.easing.min.js/d" \
-e "/js\/jquery.waypoints.min.js/d" \
-e "/js\/jquery.counterup.min.js/d" \
-e "/js\/popper.min.js/d" \
-e "/js\/isotope.pkgd.min.js/d" \
-e "/js\/infinite-scroll.min.js/d" \
-e "/js\/imagesloaded.pkgd.min.js/d" \
-e "/js\/slick.min.js/d" \
-e "/js\/validator.js/d" \
-e "/js\/wow.min.js/d" \
-e "/js\/morphext.min.js/d" \
-e "/js\/parallax.min.js/d" \
-e "/js\/jquery.magnific-popup.min.js/d" \
src/html/index.html; \
minify --html-keep-conditional-comments --recursive --output . src/; \
sed -i -e "s/{date}/$(date -Iseconds)/g" /src/html/sitemap.xml

FROM nginx:latest
COPY ./src/nginx.conf /etc/nginx
COPY --from=builder /src/html /srv/html
