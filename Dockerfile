
FROM node:18-alpine as builder
WORKDIR /DevOpsAssign2
COPY package.json ./
RUN npm install -g parcel && npm install
COPY . .
RUN parcel build src/{your file name}.html
FROM nginx:alpine
COPY --from=builder /DevOpsAssign2/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
