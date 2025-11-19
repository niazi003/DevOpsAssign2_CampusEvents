# Stage 1: Build the website
FROM node:18-alpine AS builder


# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json ./
# Install parcel globally to ensure the build command works
RUN npm install -g parcel && npm install

# Copy the source code (src and styles)
COPY . .

# Build the static website
RUN parcel build src/events.html --public-url ./

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built files from the previous stage to Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the server
CMD ["nginx", "-g", "daemon off;"]
