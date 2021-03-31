FROM alpine
LABEL "maintainer"="Tahmid Khan"

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add bash git curl jq
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
