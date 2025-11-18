# syntax=docker/dockerfile:1

ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-alpine

# Use production environment
ENV NODE_ENV=production

WORKDIR /usr/src/app

# Copy package files first for better caching
COPY package*.json ./

# Install only production deps - RUN npm ci --omit=dev
RUN npm ci --omit=dev

# Copy all source files
COPY . .

# Run app as non-root
USER node

# App port
EXPOSE 3003

# Start the app
CMD ["node", "src/index.js"]
