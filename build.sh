#!/bin/bash

# 创建必要的目录
mkdir -p configs resources states user_plugins

# 复制配置文件
cp configs/nonebot.yaml.example configs/nonebot.yaml

# 构建并启动容器
docker-compose up -d

echo "Bot is running! Check logs with: docker-compose logs -f" 