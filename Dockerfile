FROM node:12-alpine

RUN mkdir -p /app
WORKDIR /app
COPY package.json package.json

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps git curl && \
    curl -k -o ~/.npmrc https://cdn.jsdelivr.net/gh/stevieyu/stevieyu.github.io/.npmrc && \
    npm install && \
    npm prune --production && \
    npm cache clean -f && \
    apk del .build-deps

COPY . /app

ENV NUXT_PORT=5000

RUN npm run build

CMD ["npm", "start"]
