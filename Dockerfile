# 使用 Python Alpine 基础镜像
FROM python:3.10-alpine

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apk add --no-cache \
    git \
    yaml-dev \
    bubblewrap \
    curl \
    nodejs \
    npm \
    libqalculate \
    libzim \
    pkgconfig \
    gcc \
    g++ \
    musl-dev \
    cmake \
    meson \
    ninja \
    cairo \
    cairo-dev \
    gobject-introspection-dev \
    py3-cairo \
    py3-gobject3 \
    mesa-gl \
    linux-headers \
    # skia-python 依赖
    fontconfig \
    fontconfig-dev \
    freetype \
    freetype-dev \
    harfbuzz \
    harfbuzz-dev \
    # playwright 依赖
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ttf-freefont \
    font-noto

# 安装 PDM
RUN pip install -U pip setuptools wheel typing-extensions
RUN pip install pdm

# 克隆原始仓库
RUN git clone https://github.com/su226/IdhagnBot.git .

# 安装所有功能
RUN pdm install -G :all

# 设置环境变量
ENV PATH="/app/.venv/bin:$PATH"
# Playwright 环境变量
ENV PLAYWRIGHT_BROWSERS_PATH=/usr/lib/chromium
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

# 启动命令
CMD ["pdm", "run", "start"] 