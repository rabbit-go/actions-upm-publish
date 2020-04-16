FROM alpine:3.9

RUN apk update && apk add bash git npm jq nodejs curl

RUN touch ~/.bashrc \
      && curl -o- -L https://yarnpkg.com/install.sh | bash \
      && ln -s "$HOME/.yarn/bin/yarn" /usr/local/bin/yarn

RUN yarn && yarn add npm-cli-adduser

COPY main.sh /main.sh

RUN chmod +x /main.sh

ENTRYPOINT ["/main.sh"]
