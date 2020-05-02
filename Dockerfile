FROM alpine:3.9

RUN apk update && apk add bash git npm jq nodejs

RUN npm config set unsafe-perm true

RUN npm i && npm install -g  npm-cli-adduser

COPY main.sh /main.sh

RUN chmod +x /main.sh

ENTRYPOINT ["/main.sh"]
