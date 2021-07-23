FROM jekyll/jekyll:3.8 as jekyll

COPY ./build /build
WORKDIR /build/src

RUN chown jekyll:jekyll / && \
  chown -R jekyll:jekyll /build && \
  jekyll build --destination /dist


FROM ghcr.io/unb-libraries/nginx:1.x
MAINTAINER UNB Libraries <libsupport@unb.ca>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

COPY ./build /build
RUN cp -r /build/scripts/container/* /scripts/ && \
  mv /build/nginx/app.conf /etc/nginx/conf.d/app.conf && \
  rm -rf /build && \
  rm -rf /app/html
COPY --from=jekyll /dist /app/html

LABEL ca.unb.lib.generator="jekyll" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="MIT" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="lastshift.lib.unb.ca outlines the poignant history of one town's way of life, and of how that town's horizons were shaped and altered by the pulsing industry at its heart." \
  org.label-schema.name="lastshift.lib.unb.ca" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/unb-libraries/lastshift.lib.unb.ca" \
  org.label-schema.vendor="University of New Brunswick Libraries" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.source="https://github.com/unb-libraries/lastshift.lib.unb.ca"
