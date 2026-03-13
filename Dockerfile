# Use node:alpine
FROM node:alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy the rest of the code
COPY . .

# Port for the exam
EXPOSE 5000

# Path to your entry point
CMD ["node", "src/index.js"]
