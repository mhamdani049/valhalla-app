FROM node:16.17.0-alpine AS builder
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . /app
RUN npm i

ENV NODE_ENV development
RUN npm run build

# production environment
FROM nginx:1.23.2-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
