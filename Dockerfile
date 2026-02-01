# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the app with API key
ARG VITE_API_KEY
ENV VITE_API_KEY=${VITE_API_KEY}
RUN npm run build

# Production stage
FROM node:20-alpine

WORKDIR /app

# Install serve to run the built app
RUN npm install -g serve

# Copy built app from builder
COPY --from=builder /app/dist ./dist

# Accept API key as build argument and set as environment variable
ARG VITE_API_KEY
ENV API_KEY=${VITE_API_KEY}
ENV VITE_API_KEY=${VITE_API_KEY}

# Expose port
EXPOSE 3000

# Serve the app
CMD ["serve", "-s", "dist", "-l", "3000"]
