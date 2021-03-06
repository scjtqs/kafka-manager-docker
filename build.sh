#!/bin/bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --use --name mybuilder
docker buildx build --tag scjtqs/kafka-manager:latest --platform linux/amd64,linux/arm64 --push .
docker buildx build --tag registry.cn-hangzhou.aliyuncs.com/scjtqs/kafka-manager:latest --platform linux/amd64,linux/arm64 --push .
docker buildx rm mybuilder
