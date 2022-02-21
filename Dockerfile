FROM alpine:3

ARG CODECOV_VERSION=0.1.17

RUN apk add --no-cache curl git; \
  curl -Os https://uploader.codecov.io/v${CODECOV_VERSION}/alpine/codecov; \
  mv codecov /bin; \
  chmod +x /bin/codecov; \
  apk del curl

ENV CODECOV_TOKEN=''

ENTRYPOINT [ "codecov", "-t", "$CODECOV_TOKEN" ]
