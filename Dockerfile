FROM node:latest as build
WORKDIR /app
COPY package*.json ./
ARG REACT_APP_NAME=default_value
ENV REACT_APP_NAME $REACT_APP_NAME
COPY . .
RUN npm install
RUN npm run build
#2nd stage
FROM node:alpine
WORKDIR /myapp
COPY --from=build /app/build /myapp
RUN npm install -g http-server
EXPOSE 8080
CMD ["http-server", "-p", "8080", "-d", "false"]