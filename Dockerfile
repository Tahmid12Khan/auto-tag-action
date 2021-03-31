FROM alpine
LABEL "maintainer"="Tahmid Khan"

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add bash git curl jq

ENTRYPOINT ["/entrypoint.sh"]
