# Docker portainer

![GitHub action workflow status](https://github.com/SW-Luis-Palacios/base-redis/actions/workflows/docker-publish.yml/badge.svg)

This repository contains a `Dockerfile` aimed to create a *base image* to provide a dockerized Redis service. Redis allows for db caching and handling of configurations of real-time data, making use of its in-memory data storage capabilities to help support highly responsive database constructs. Caching with Redis allows for fewer database accesses, which helps to reduce the amount of traffic and instances required.

## Use Cases for a Redis Docker Container

- Data Cache. Redis is commonly used as a cache store to hold data in memory that needs to be accessed quickly. This can include database query results, user sessions, and any other data that needs to be retrieved rapidly to improve application performance.

- Message Queue. Redis offers data structures like lists and sorted sets, which are ideal for implementing message queues. Applications can use Redis to manage queued tasks, background jobs, and other inter-process communication mechanisms.

- Session Storage. Web applications often use Redis to store session information. As an in-memory database, Redis allows very fast access to session data, enhancing user experience with quicker response times.

- Leaderboards and Counters. Due to its atomic operations and advanced data structures, Redis is perfect for implementing leaderboards, counters, and other systems that require precise and fast accounting. For example, it can be used to count web page visits or user interactions in real-time.

- Pub/Sub (Publish/Subscribe). Redis includes a publish/subscribe mechanism that allows messages to be sent between different services or components of an application. This is useful for applications that require real-time notifications or distributed event systems.

- Temporary Data Persistence. Redis can be used to store data that needs to be persisted temporarily. For example, it can be used to store form data before processing or to save the temporary state of an application.

- Development and Test Automation. During development and testing, Docker containers running Redis allow developers to create consistent and isolated test environments. This ensures that applications work correctly with Redis before deploying to production.

- Microservices Implementations. In microservices architectures, Redis can be used as a shared service for different microservices, providing a fast and accessible data store for efficiently sharing information between services.

I recommend installing **Redisinsight** together with Redis if you want to manage it. Redis Insight is a powerful desktop user interface that helps you visualize and optimize your data for Redis and Redis Stack. Plus it supports CLI interaction in a fully featured desktop UI client.

## Custom image

I'm configuring a custom image, to fix the overcommit_memory warning. I need to run it as privileged to allow the container to change the vm.overcommit_memory setting

## Sample `docker-compose.yml`

This is an example where I'm running Redis together with Redisinsight.

```yaml
### Docker Compose example
volumes:
  redis_data:
    driver: local
  redisinsight_data:
    driver: local

networks:
  my_network:
    name: my_network
    driver: bridge

services:
  ct_redis:
    image: ghcr.io/sw-luis-palacios/base-redis:main
    hostname: redis
    container_name: ct_redis
    restart: always
    ports:
      - 6379:6379
    command:
      sh -c "/init.sh"
    privileged: true
    volumes:
      - redis_data:/data
    networks:
      - my_network

  ct_redisinsight:
    image: ghcr.io/sw-luis-palacios/base-redisinsight:main
    hostname: redisinsight
    container_name: ct_redisinsight
    restart: always
    ports:
      - 5540:5540 # Management UI
    volumes:
      - redisinsight_data:/data
    networks:
      - my_network
    depends_on:
      - redis

  ct_other_container:
    :

  ct_other_container:
    :

  ct_other_container:
    :
```

- Start your services

```sh
docker compose up --build -d
```

## For developers

If you copy or fork this project to create your own base image.

### Building the Image

To build the Docker image, run the following command in the directory containing the Dockerfile:

```sh
docker build -t your-image/base-redis:main .
```

### Troubleshoot

```sh
docker run --rm --name ct_redis --hostname redis -p 6379:6379 your-image/base-portainer:main
```
