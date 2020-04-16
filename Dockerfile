FROM alpine:3.9

RUN apk update && apk add bash git npm jq

RUN yarn && yarn add npm-cli-adduser

COPY main.sh /main.sh

RUN chmod +x /main.sh

ENTRYPOINT ["/main.sh"]
