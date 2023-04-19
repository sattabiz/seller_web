FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/flutter/bin"

RUN flutter channel master  & \ 
    flutter upgrade  & \ 
    flutter config --enable-web

RUN mkdir ./app/
COPY . ./app/
WORKDIR ./app/

RUN flutter build web


FROM nginx:1.21.1-alpine
COPY --from=build-env /home/satta/app/build/web /usr/share/nginx/html