# Use lightweight image
FROM node:alpine

# Install build tools for native dependencies (fixes the npm install error)
RUN apk add --no-cache python3 make g++

WORKDIR /usr/src/app

# Copy only necessary files
COPY package*.json ./
RUN npm install --omit=dev

# Copy application code
COPY . .

# Accessible on port 5000 inside container
EXPOSE 5000

CMD ["node", "src/index.js"]