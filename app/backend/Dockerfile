FROM node:20-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --omit=dev

FROM node:20-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY index.js .

RUN addgroup -S nodeuser && adduser -S nodeuser -G nodeuser \
    && chown -R nodeuser:nodeuser /usr/src/app
USER nodeuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/api/health || exit 1

CMD ["node", "index.js"]
