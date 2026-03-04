# 多阶段构建：Maven 构建阶段
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /build

# 复制 Maven 配置文件（利用 Docker 缓存）
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# 下载依赖（利用缓存层）
RUN ./mvnw dependency:go-offline -B

# 复制源代码
COPY src ./src

# 构建应用
RUN ./mvnw clean package -DskipTests -B

# 运行阶段：使用更小的 JRE 镜像
FROM eclipse-temurin:21-jre-alpine

# 安装必要工具（健康检查等）
RUN apk add --no-cache curl

# 创建非 root 用户（docker-compose 中以 root 运行以访问 Docker socket）
RUN addgroup -S spring && \
    adduser -S spring -G spring -h /home/spring

WORKDIR /app

# 从构建阶段复制 JAR 文件
COPY --from=builder /build/target/*.jar app.jar

# 暴露端口
EXPOSE 8080

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
    CMD curl -f http://localhost:8080/api/health || exit 1

# JVM 优化参数
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Djava.security.egd=file:/dev/./urandom"

# 启动应用
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
