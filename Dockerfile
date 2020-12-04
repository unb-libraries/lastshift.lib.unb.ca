FROM jekyll/jekyll:3.8 as jekyll

COPY ./build /build
WORKDIR /build/src

RUN jekyll build


FROM unblibraries/nginx:alpine
MAINTAINER UNB Libraries <libsupport@unb.ca>

COPY ./build /build

RUN cp -r /build/scripts/container/* /scripts/ && \
  mv /build/nginx/app.conf /etc/nginx/conf.d/app.conf && \
  rm -rf /build && \
  rm -rf /app/html

COPY --from=jekyll /build/src/_site /app/html
