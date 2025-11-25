# syntax=docker/dockerfile:1

ARG NODE_VERSION=20

############################################
# 1️⃣ TEST STAGE  → target: test
############################################
FROM node:${NODE_VERSION}-alpine AS test

WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install ALL dependencies (including devDependencies for tests)
RUN npm install

# Copy rest of code
COPY . .

# Run tests (if you have tests)
# If no tests, keep a dummy command:
RUN echo "Running test stage..."

############################################
# 2️⃣ PRODUCTION STAGE  → target: prod
############################################
FROM node:${NODE_VERSION}-alpine AS prod

ENV NODE_ENV=production
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install ONLY production dependencies
RUN npm ci --omit=dev

# Copy code
COPY . .


USER node


EXPOSE 3003


CMD ["node", "src/index.js"]
