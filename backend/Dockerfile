FROM node:22-alpine AS builder
WORKDIR /repo

RUN corepack enable

COPY package.json yarn.lock .yarnrc.yml ./
COPY backend/package.json ./backend/
COPY frontend/package.json ./frontend/

RUN yarn install --immutable

COPY backend ./backend

FROM node:22-alpine
WORKDIR /repo

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder --chown=appuser:appgroup /repo ./

ENV NODE_ENV=production
EXPOSE 3000

USER appuser
WORKDIR /repo/backend
CMD ["node", "bin/www"]
