FROM        node:lts-alpine as builder

COPY        package.json /srv/CHOWFAST-BE/
WORKDIR     /srv/CHOWFAST-BE/

RUN         yarn install --production

COPY        .babelrc /srv/CHOWFAST-BE/
COPY        .eslintrc.json /srv/CHOWFAST-BE/
COPY        app.js /srv/CHOWFAST-BE/
COPY        adapters /srv/CHOWFAST-BE/adapters/
COPY        application /srv/CHOWFAST-BE/application/
COPY        config /srv/CHOWFAST-BE/config/
COPY        frameworks /srv/CHOWFAST-BE/frameworks/
COPY        src /srv/CHOWFAST-BE/src/
COPY        tests /srv/CHOWFAST-BE/tests/

RUN         yarn run build

FROM        node:lts-alpine


ENV         HTTP_MODE http
ARG         NODE_PROCESSES=2
ENV         NODE_PROCESSES=$NODE_PROCESSES

# Install pm2
RUN         npm install -g pm2

# Copy over code
WORKDIR     /srv/api/
COPY        --from=builder /srv/CHOWFAST-BE/build /srv/api/build
COPY        --from=builder /srv/CHOWFAST-BE/package.json /srv/api/package.json

RUN         deluser --remove-home node \
            && addgroup -S node -g 9999 \
            && adduser -S -G node -u 9999 node

CMD         ["npm", "start"]

USER        node