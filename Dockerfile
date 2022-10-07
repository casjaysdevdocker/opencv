FROM casjaysdevdocker/alpine:latest as build

ARG LICENSE=WTFPL \
  IMAGE_NAME=opencv \
  TIMEZONE=America/New_York \
  PORT=

ENV SHELL=/bin/bash \
  TERM=xterm-256color \
  HOSTNAME=${HOSTNAME:-casjaysdev-$IMAGE_NAME} \
  TZ=$TIMEZONE

RUN mkdir -p /bin/ /config/ /data/ && \
  rm -Rf /bin/.gitkeep /config/.gitkeep /data/.gitkeep && \
  echo "http://dl-cdn.alpinelinux.org/alpine/$alpine_version/main" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/$alpine_version/community" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/$alpine_version/testing" >> /etc/apk/repositories && \
  apk update -U --no-cache && \
  apk add --no-cache \
  py3-opencv \
  opencv \
  opencv-dev \
  python3 \
  py3-pip && \
  ln -sf "/usr/bin/python3" "/usr/bin/python"

COPY ./bin/. /usr/local/bin/
COPY ./config/. /config/
COPY ./data/. /data/

FROM scratch
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')"

LABEL org.label-schema.name="opencv" \
  org.label-schema.description="Containerized version of opencv" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/opencv" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/opencv" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="$LICENSE" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-opencv" \
  TZ="${TZ:-America/New_York}"

WORKDIR /root

VOLUME ["/root","/config","/data"]

EXPOSE $PORT

COPY --from=build /. /

ENTRYPOINT [ "tini", "--" ]
HEALTHCHECK --interval=15s --timeout=3s CMD [ "/usr/local/bin/entrypoint-opencv.sh", "healthcheck" ]
CMD [ "/usr/local/bin/entrypoint-opencv.sh" ]

