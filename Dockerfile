FROM node:20-alpine

WORKDIR /app

COPY package.json bun.lock* ./

RUN npm install

COPY . .

RUN npm run build

# Verify build directory exists
RUN ls -la build/

EXPOSE 3000