FROM node:12-alpine

RUN mkdir -p /app
WORKDIR /app
COPY package.json package.json

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps git && \
    npm config set registry https://registry.npm.taobao.org && \
    npm config set sass-binary-site https://npm.taobao.org/mirrors/node-sass && \
    npm config set loglevel=http && \
    npm install && \
    npm prune --production && \
    npm cache clean -f && \
    apk del .build-deps

COPY . /app

ENV NUXT_PORT=5000

RUN npm run build

CMD ["npm", "start"]
