FROM alpine
LABEL "maintainer"="Tahmid Khan"

COPY entrypoint entrypoint

RUN apk update && apk add bash git curl jq
RUN chmod +x entrypoint

ENTRYPOINT ["./entrypoint"]
