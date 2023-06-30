FROM anilguvenc/flutter-web-builder:latest AS build-env

RUN mkdir ./app/
COPY . ./app/
WORKDIR ./app/
RUN flutter create .
RUN flutter build web --no-tree-shake-icons --dart-define=API_URL=$API_URL --dart-define=USERNAME=$USERNAME --dart-define=PASSWORD=$PASSWORD --dart-define=API_URL_CONTENT=$API_URL_CONTENT --dart-define=API_URL_CONTENT2=$API_URL_CONTENT2

FROM nginx:1.21.1-alpine
COPY --from=build-env ./app/build/web /usr/share/nginx/html