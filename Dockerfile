# 使用Python 3.10作为基础镜像
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    libyaml-dev \
    bubblewrap \
    curl \
    gnupg \
    libqalculate-dev \
    libzim-dev \
    pkg-config \
    gcc \
    g++ \
    cmake \
    libcairo2-dev \
    libgirepository1.0-dev \
    python3-cairo-dev \
    gir1.2-gtk-3.0 \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && rm -rf /var/lib/apt/lists/*

# 安装 PDM
RUN pip install -U pip setuptools wheel
RUN pip install pdm

# 克隆原始仓库
RUN git clone https://github.com/su226/IdhagnBot.git .

# 安装所有功能
RUN pdm install -G :all

# 设置环境变量
ENV PATH="/app/.venv/bin:$PATH"

# 启动命令
CMD ["pdm", "run", "start"] 