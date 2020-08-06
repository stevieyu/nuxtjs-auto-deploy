FROM node:12-alpine

RUN mkdir -p /app
WORKDIR /app
COPY . /app

ENV NUXT_PORT=5000

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps git curl && \
    curl -k -o ~/.npmrc https://cdn.jsdelivr.net/gh/stevieyu/stevieyu.github.io/.npmrc && \
    npm install && \
    npm run build && \
    npm prune --production && \
    npm cache clean -f && \
    apk del .build-deps

CMD ["npm", "start"]
