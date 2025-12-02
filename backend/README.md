# NovaCloudEdu Backend

基于 Spring Boot 3.5 + MyBatis Plus 的后端服务，采用 DDD 四层架构。

## 技术栈

- **Java 21**
- **Spring Boot 3.5.8**
- **MyBatis Plus 3.5.5**
- **PostgreSQL**
- **Redis**
- **Spring Security**
- **Elasticsearch**

## 项目架构

采用 DDD（领域驱动设计）四层架构：

```
com.novacloudedu.backend
├── interfaces/              # 用户接口层
│   ├── controller/          # REST 控制器
│   ├── dto/
│   │   ├── request/         # 请求 DTO
│   │   └── response/        # 响应 DTO
│   └── assembler/           # DTO 与领域对象转换器
│
├── application/             # 应用层
│   ├── service/             # 应用服务（编排领域服务，处理事务）
│   ├── command/             # 命令对象（写操作）
│   └── query/               # 查询对象（读操作）
│
├── domain/                  # 领域层（核心业务逻辑）
│   ├── entity/              # 领域实体
│   ├── valueobject/         # 值对象
│   ├── repository/          # 仓储接口（抽象）
│   ├── service/             # 领域服务
│   └── event/               # 领域事件
│
└── infrastructure/          # 基础设施层
    ├── persistence/
    │   ├── mapper/          # MyBatis Mapper 接口
    │   └── repository/      # 仓储接口实现
    ├── config/              # 配置类
    └── external/            # 外部服务适配器

resources/
├── mapper/                  # MyBatis XML 映射文件
├── application.yml          # 主配置
├── application-dev.yml      # 开发环境配置
└── application-prod.yml     # 生产环境配置
```

## 各层职责

| 层级 | 职责 | 依赖方向 |
|------|------|----------|
| **interfaces** | 处理 HTTP 请求，参数校验，DTO 转换 | → application |
| **application** | 编排领域服务，事务管理，权限控制 | → domain |
| **domain** | 核心业务逻辑，领域模型，业务规则 | 无外部依赖 |
| **infrastructure** | 数据持久化，外部服务调用，技术实现 | → domain |

## 环境配置

### 开发环境 (dev)
```bash
mvn spring-boot:run
# 或
java -jar backend.jar --spring.profiles.active=dev
```

### 生产环境 (prod)
```bash
java -jar backend.jar --spring.profiles.active=prod
```

## 构建

```bash
mvn clean package -DskipTests
```
