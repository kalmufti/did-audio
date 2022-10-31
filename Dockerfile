FROM kalmufti/did-base as base

LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.authors="Khalid Almufti - https://github.com/kalmufti"
LABEL org.opencontainers.image.source="https://github.com/kalmufti/did-audio"
LABEL org.opencontainers.image.description="Desktop in Docker - Audio and Firefox"
LABEL org.opencontainers.image.licenses="Apache-2.0"

FROM alpine:3.16.2 AS mirror

RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
# Copy did-base file system
COPY --from=base / /out
RUN apk add --update --no-cache --initdb -p /out \
    pulseaudio \
    firefox

# Remove apk residuals
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache

FROM scratch

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    HOST_ADDR=localhost \
    PULSE_SERVER=host.docker.internal

COPY --from=mirror /out/ /
COPY usr/ usr/
RUN  mkdir /etc/pulse/system.pa.d

WORKDIR /root

ENTRYPOINT []
CMD ["/usr/bin/app"]
