# Stage 1: Build
FROM node:20-slim AS builder
WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy configuration files
COPY package.json pnpm-lock.yaml ./

# Install ALL dependencies including devDeps for the build process
RUN pnpm install --frozen-lockfile

# Copy the rest of the source code
COPY . .

# Build the project (compiles TS to JS)
RUN pnpm run build

# Stage 2: Production
FROM node:20-slim
WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy only the necessary files from builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/pnpm-lock.yaml ./pnpm-lock.yaml

# Install ONLY production dependencies
# This removes devDependencies to make the image smaller and avoid the error you saw
RUN pnpm install --prod --frozen-lockfile

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "dist/index.js"]
