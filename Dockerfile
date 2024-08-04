# Dockerfile for custom Redis image
#
# This Dockerfile sets up a standard Redis container that you can use
# inside your docker compose projects or standalone
#
# Standard redis image
FROM redis/redis-stack-server:latest

WORKDIR /

# By default the redis image will start `init.sh` when booted
COPY ./config/init.sh /
RUN chmod +x /init.sh
