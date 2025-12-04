# Stage 1: Build the Nuxt app
FROM node:24-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

# Stage 2: Serve the app
FROM node:24-alpine AS runner
WORKDIR /app
COPY --from=build /app/.output ./.output
ENV NITRO_HOST=0.0.0.0
ENV NITRO_PORT=80
EXPOSE 80
CMD ["node", ".output/server/index.mjs"]
