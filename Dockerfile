# 使用Python 3.10作为基础镜像
FROM python:3.10-slim

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    cairo \
    libcairo2-dev \
    pango1.0-tools \
    libpango1.0-dev \
    libgobject-2.0-0 \
    libgirepository1.0-dev \
    pkg-config \
    gcc \
    g++ \
    libyaml-dev \
    nodejs \
    npm \
    libqalculate-dev \
    libzim-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装PDM
RUN pip install pdm

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 使用PDM安装依赖（包含所有可选功能）
RUN pdm install -G :all

# 创建必要的目录
RUN mkdir -p configs resources states user_plugins

# 设置启动命令
CMD ["pdm", "run", "start"] 