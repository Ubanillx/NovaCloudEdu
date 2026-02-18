# Elasticsearch with IK Chinese Analyzer
FROM elasticsearch:8.13.0

# 切换到 root 用户安装插件
USER root

# 安装工具并下载 IK 分词器 + Pinyin 分词器（使用 infinilabs 官方源）
# zip 文件直接包含插件文件，需要解压到对应子目录
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    mkdir -p /usr/share/elasticsearch/plugins/analysis-ik && \
    wget -qO /tmp/ik.zip https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-8.13.0.zip && \
    unzip -q /tmp/ik.zip -d /usr/share/elasticsearch/plugins/analysis-ik && \
    rm /tmp/ik.zip && \
    mkdir -p /usr/share/elasticsearch/plugins/analysis-pinyin && \
    wget -qO /tmp/pinyin.zip https://release.infinilabs.com/analysis-pinyin/stable/elasticsearch-analysis-pinyin-8.13.0.zip && \
    unzip -q /tmp/pinyin.zip -d /usr/share/elasticsearch/plugins/analysis-pinyin && \
    rm /tmp/pinyin.zip && \
    apt-get remove -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 切回 elasticsearch 用户
USER elasticsearch

# 验证插件安装
RUN ls -la /usr/share/elasticsearch/plugins/
