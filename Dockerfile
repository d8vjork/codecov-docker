FROM node:lts-alpine as nodebuild

RUN apk add --no-cache git; \
  git clone https://github.com/codecov/uploader.git /tmp/codecov-master; \
  yarn global add pkg; \
  cd /tmp/codecov-master; \
  yarn install; \
  yarn build; \
  pkg . --targets node14-alpine --output out/codecov

FROM alpine:3.14

COPY --from=nodebuild /tmp/codecov-master/out/codecov /bin

RUN apk add --no-cache git; \
  mv /bin/uploader /bin/codecov; \
  chmod +x /bin/codecov

ENTRYPOINT [ "codecov", "-t", "$CODECOV_TOKEN" ]
