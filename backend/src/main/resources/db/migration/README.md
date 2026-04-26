数据库迁移说明
================

这里放 Flyway 增量迁移脚本，后端启动时会自动执行尚未执行过的脚本。

命名规则：

```text
VyyyyMMddHHmm__short_description.sql
```

示例：

```text
V202604261530__add_private_message_reply_to.sql
```

开发流程：

1. 修改 `backend/sql/*.sql`，让全新数据库初始化时带上最新结构。
2. 在本目录新增一条增量迁移，处理已有数据库的结构变化。
3. 迁移尽量写成幂等形式，例如 `ADD COLUMN IF NOT EXISTS`、`CREATE INDEX IF NOT EXISTS`。
4. 不要修改已经上线执行过的迁移文件；需要调整时新增下一条迁移。
