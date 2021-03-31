FROM alpine
LABEL "maintainer"="Tahmid Khan"

COPY entrypoint entrypoint

RUN apk update && apk add bash git curl jq
RUN chomod +x entrypoint

ENTRYPOINT ["./entrypoint"]
