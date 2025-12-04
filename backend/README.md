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
com.novacloudedu.backend/
│
├── interfaces/                      # 接口层（用户接口层）
│   └── rest/                        # REST API
│       ├── auth/                    # 认证模块
│       │   ├── AuthController.java
│       │   ├── dto/
│       │   │   ├── request/         # 请求 DTO (UserLoginRequest, UserRegisterRequest)
│       │   │   └── response/        # 响应 DTO (LoginUserResponse)
│       │   └── assembler/           # DTO 组装器 (UserAssembler)
│       └── common/                  # 通用接口 (HealthController)
│
├── application/                     # 应用层
│   └── user/                        # 用户模块
│       ├── UserApplicationService.java  # 应用服务（编排用例流程）
│       └── command/                 # 命令对象
│           ├── RegisterUserCommand.java
│           └── LoginUserCommand.java
│
├── domain/                          # 领域层（核心业务逻辑）
│   └── user/                        # 用户领域
│       ├── entity/
│       │   └── User.java            # 聚合根（充血模型）
│       ├── valueobject/             # 值对象
│       │   ├── UserId.java
│       │   ├── UserAccount.java
│       │   ├── Password.java
│       │   └── UserRole.java
│       └── repository/
│           └── UserRepository.java  # 仓储接口
│
├── infrastructure/                  # 基础设施层
│   ├── persistence/                 # 持久化
│   │   ├── po/                      # 持久化对象 (UserPO)
│   │   ├── mapper/                  # MyBatis Mapper (UserMapper)
│   │   ├── repository/              # 仓储实现 (UserRepositoryImpl)
│   │   └── converter/               # PO↔Entity 转换器 (UserConverter)
│   └── security/                    # 安全相关
│       ├── JwtTokenProvider.java
│       ├── JwtAuthenticationFilter.java
│       ├── JwtAuthenticationEntryPoint.java
│       ├── JwtAccessDeniedHandler.java
│       └── PasswordEncoderAdapter.java
│
├── common/                          # 通用类
│   ├── BaseResponse.java            # 统一响应封装
│   ├── ErrorCode.java               # 错误码枚举
│   └── ResultUtils.java             # 响应工具类
│
├── config/                          # 配置类
│   ├── SecurityConfig.java          # Spring Security 配置
│   └── OpenApiConfig.java           # Swagger 配置
│
├── exception/                       # 异常处理
│   ├── BusinessException.java       # 业务异常
│   ├── ThrowUtils.java              # 抛异常工具
│   └── GlobalExceptionHandler.java  # 全局异常处理器
│
├── aop/                             # AOP 切面
│   └── AuthInterceptor.java         # 权限校验切面
│
├── annotation/                      # 自定义注解
│   └── AuthCheck.java               # 权限校验注解
│
└── BackendApplication.java          # 启动类

resources/
├── application.yml                  # 主配置
├── application-dev.yml              # 开发环境配置
└── application-prod.yml             # 生产环境配置
```

## 各层职责

| 层级 | 职责 | 依赖方向 |
|------|------|----------|
| **interfaces** | 处理 HTTP 请求，参数校验，DTO 转换 | → application |
| **application** | 编排领域服务，事务管理，权限控制 | → domain |
| **domain** | 核心业务逻辑，领域模型，业务规则 | 无外部依赖 |
| **infrastructure** | 数据持久化，外部服务调用，技术实现 | → domain |

## DDD 架构设计原理

### 什么是 DDD

**领域驱动设计（Domain-Driven Design）** 是一种软件开发方法论，核心思想是将业务领域专家的知识融入代码中，使代码结构与业务概念保持一致。

### 核心概念

#### 1. 领域模型（Domain Model）

领域模型是对业务领域的抽象，包含以下构建块：

| 概念 | 说明 | 本项目示例 |
|------|------|-----------|
| **实体（Entity）** | 具有唯一标识的对象，标识不变但属性可变 | `User` |
| **值对象（Value Object）** | 无唯一标识，通过属性值定义，不可变 | `UserId`, `UserAccount`, `Password` |
| **聚合（Aggregate）** | 一组相关对象的集合，有一个聚合根 | `User` 聚合 |
| **聚合根（Aggregate Root）** | 聚合的入口点，外部只能通过它访问聚合内对象 | `User` |
| **仓储（Repository）** | 提供聚合的持久化抽象，隐藏数据访问细节 | `UserRepository` |
| **领域服务（Domain Service）** | 无法归属于单一实体的领域逻辑 | - |
| **领域事件（Domain Event）** | 领域中发生的业务事件 | - |

#### 2. 充血模型 vs 贫血模型

```java
// ❌ 贫血模型：实体只有 getter/setter，业务逻辑在 Service 中
public class User {
    private String password;
    // 只有 getter/setter
}

// ✅ 充血模型：实体包含业务行为
public class User {
    private Password password;
    
    public boolean verifyPassword(String raw, PasswordEncoder encoder) {
        return password.matches(raw, encoder);
    }
    
    public void ensureNotBanned() {
        if (banned) throw new UserBannedException("账号已被封禁");
    }
}
```

#### 3. 值对象的设计原则

```java
// 值对象封装业务规则，保证数据始终合法
public record UserAccount(String value) {
    public UserAccount {
        // 构造时校验，不合法直接抛异常
        if (value.length() < 4 || value.length() > 20) {
            throw new IllegalArgumentException("账号长度为4-20个字符");
        }
        if (!PATTERN.matcher(value).matches()) {
            throw new IllegalArgumentException("账号只能包含字母、数字、下划线");
        }
    }
}
```

### 分层架构原则

```
┌─────────────────────────────────────────────────────────────┐
│                      Interfaces 接口层                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ Controller  │  │    DTO      │  │     Assembler       │  │
│  └──────┬──────┘  └─────────────┘  └─────────────────────┘  │
└─────────┼───────────────────────────────────────────────────┘
          │ 调用
┌─────────▼───────────────────────────────────────────────────┐
│                     Application 应用层                        │
│  ┌─────────────────────┐  ┌─────────────┐  ┌─────────────┐  │
│  │ ApplicationService  │  │   Command   │  │    Query    │  │
│  └──────────┬──────────┘  └─────────────┘  └─────────────┘  │
└─────────────┼───────────────────────────────────────────────┘
              │ 调用
┌─────────────▼───────────────────────────────────────────────┐
│                       Domain 领域层                           │
│  ┌────────────┐  ┌─────────────┐  ┌───────────────────────┐ │
│  │   Entity   │  │ ValueObject │  │ Repository (接口)     │ │
│  └────────────┘  └─────────────┘  └───────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
              ▲ 实现
┌─────────────┴───────────────────────────────────────────────┐
│                   Infrastructure 基础设施层                    │
│  ┌────────────┐  ┌─────────────┐  ┌───────────────────────┐ │
│  │   Mapper   │  │     PO      │  │ Repository (实现)     │ │
│  └────────────┘  └─────────────┘  └───────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### 依赖倒置原则

**核心原则**：高层模块不应依赖低层模块，两者都应依赖抽象。

```
传统架构：Controller → Service → DAO → Database
                      （高层依赖低层）

DDD架构：
  Domain 层定义 Repository 接口（抽象）
  Infrastructure 层实现 Repository（实现依赖抽象）
  Application 层依赖 Repository 接口（高层依赖抽象）
```

这样 **Domain 层不依赖任何外部框架**，可以独立测试和演进。

### 数据流转

```
HTTP Request
    │
    ▼
┌─────────────────┐
│   Controller    │ ←── 接收请求
└────────┬────────┘
         │ UserLoginRequest (DTO)
         ▼
┌─────────────────┐
│   Assembler     │ ←── DTO → Command 转换
└────────┬────────┘
         │ LoginUserCommand
         ▼
┌─────────────────┐
│ AppService      │ ←── 编排用例流程
└────────┬────────┘
         │ 调用领域对象
         ▼
┌─────────────────┐
│ Domain Entity   │ ←── 执行业务逻辑
│ (User)          │
└────────┬────────┘
         │ 通过 Repository 接口
         ▼
┌─────────────────┐
│ RepositoryImpl  │ ←── 数据持久化
└────────┬────────┘
         │ PO ↔ Entity 转换
         ▼
┌─────────────────┐
│    Database     │
└─────────────────┘
```

### 最佳实践

1. **按领域模块组织代码**，而非按技术分层
2. **领域层零框架依赖**，保持纯净
3. **值对象优先**，减少原始类型的使用
4. **聚合根控制访问**，保护内部一致性
5. **仓储只针对聚合根**，不要为每个实体创建仓储
6. **应用服务薄而轻**，业务逻辑下沉到领域层

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
