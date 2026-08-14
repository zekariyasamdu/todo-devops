FROM node:22-alpine AS builder
WORKDIR /repo

RUN corepack enable

COPY package.json yarn.lock .yarnrc.yml ./
COPY backend/package.json ./backend/
COPY frontend/package.json ./frontend/

RUN yarn install --immutable

COPY frontend ./frontend
RUN yarn workspace frontend build

FROM nginx:1.27-alpine
COPY --from=builder /repo/frontend/dist /usr/share/nginx/html
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
