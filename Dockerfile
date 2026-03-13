# --- Stage 1: Build the React Frontend ---
FROM node:22-alpine AS frontend-builder
WORKDIR /app/todo_frontend

# Copy frontend dependency files
COPY TODO/todo_frontend/package*.json ./
RUN npm install

# Copy frontend source and build
COPY TODO/todo_frontend/ ./
RUN npm run build

# --- Stage 2: Setup the Node.js Backend ---
FROM node:22-alpine
WORKDIR /usr/src/app

# Install build tools for native dependencies
RUN apk add --no-cache python3 make g++

# Copy backend dependency files
COPY TODO/todo_backend/package*.json ./
RUN npm install --omit=dev

# Copy backend source
COPY TODO/todo_backend/ ./

# Create the static folder and move the frontend build into it
RUN mkdir -p static
COPY --from=frontend-builder /app/todo_frontend/build ./static/build

# Final configuration
EXPOSE 5000
CMD ["npm", "start"]