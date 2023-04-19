FROM anilguvenc/flutter-web-builder:latest AS build-env

RUN mkdir ./app/
COPY . ./app/
WORKDIR ./app/
RUN flutter create .
RUN flutter build web --no-tree-shake-icons

FROM nginx:1.21.1-alpine
COPY --from=build-env ./app/build/web /usr/share/nginx/html