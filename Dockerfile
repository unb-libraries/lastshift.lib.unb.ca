FROM jekyll/jekyll:3.8 AS jekyll

COPY ./build /build
WORKDIR /build/src

RUN chown jekyll:jekyll / && \
  chown -R jekyll:jekyll /build && \
  jekyll build --destination /dist


FROM ghcr.io/unb-libraries/nginx:3.18.x

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

COPY ./build /build
RUN cp -r /build/scripts/container/* /scripts/ && \
  mv /build/nginx/app.conf "$NGINX_APP_CONF_FILE" && \
  rm -rf /build && \
  rm -rf /app/html
COPY --from=jekyll /dist /app/html

LABEL ca.unb.lib.generator="jekyll" \
  org.opencontainers.image.authors="UNB Libraries <libsupport@unb.ca>" \
  org.opencontainers.image.created="$BUILD_DATE" \
  org.opencontainers.image.description="lastshift.lib.unb.ca outlines the poignant history of one town's way of life, and of how that town's horizons were shaped and altered by the pulsing industry at its heart." \
  org.opencontainers.image.revision="$VCS_REF" \
  org.opencontainers.image.source="https://github.com/unb-libraries/lastshift.lib.unb.ca" \
  org.opencontainers.image.title="lastshift.lib.unb.ca" \
  org.opencontainers.image.vendor="University of New Brunswick Libraries" \
  org.opencontainers.image.version="$VERSION"
