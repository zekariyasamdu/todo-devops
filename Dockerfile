FROM node:22-alpine AS base
RUN apk update && apk upgrade && \
    apk add --no-cache dumb-init && \
    rm -rf /var/cache/apk/* && \
    corepack enable && \
    corepack prepare yarn@4.5.0 --activate && \
    addgroup -g 1001 -S nodejs && adduser -S appuser -u 1001 -G nodejs

FROM base AS deps
WORKDIR /app
COPY .yarnrc.yml package.json yarn.lock ./
COPY apps ./apps
RUN yarn install

FROM base AS builder
ARG APP_NAME
WORKDIR /app
COPY --from=deps /app ./
RUN yarn workspace ${APP_NAME} run build 

FROM base AS api-runner
ARG APP_NAME=api
WORKDIR /app
COPY --from=builder --chown=appuser:nodejs /app/package.json /app/yarn.lock /app/.yarnrc.yml ./
COPY --from=builder --chown=appuser:nodejs /app/apps/api ./apps/api
RUN yarn workspaces focus api --production
USER appuser
EXPOSE 3000
ENTRYPOINT ["dumb-init", "--"]
CMD ["sh", "-c", "node apps/api/bin/www"]

FROM nginx:1.27-alpine AS web-runner
COPY --from=builder /app/apps/web/dist /usr/share/nginx/html
COPY apps/web/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

FROM deps AS dev
ARG APP_NAME
ENV APP_NAME=$APP_NAME
WORKDIR /app/apps/${APP_NAME}
CMD ["sh", "-c", "cd /app && yarn workspace $APP_NAME dev"]
