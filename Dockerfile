# Create an image for the weather-app
FROM node AS build 
ARG SRC_DIR=/node/weather-app
RUN mkdir -p ${SRC_DIR}
ADD /src ${SRC_DIR}
WORKDIR ${SRC_DIR} 
RUN npm install

FROM node:alpine
ARG APP_VERSION=v1.0
LABEL org.label-schema.version=${APP_VERSION}
ENV NODE_ENV="development"
ENV PORT 3000
COPY --from=build /node/weather-app /node/weather-app
WORKDIR /node/weather-app
EXPOSE ${PORT}
ENTRYPOINT ./bin/www
