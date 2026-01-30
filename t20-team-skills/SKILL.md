---
name: t20-team-skills
description: 团队全栈 TypeScript 项目开发规范。当需要以下操作时使用：(1) 编写 React 组件或前端功能，(2) 开发 Koa 后端 API，(3) 设计 RESTful 接口，(4) 编写 Prisma 数据库查询，(5) 实现权限模块，(6) 创建 Git 提交或 PR，(7) 审查代码是否符合团队规范。
---

# 团队开发规范

## 快速决策

### 后端分层

```
是否涉及业务规则？
├─ 是 + 跨服务/需事务 → Controller + DoService + Service
├─ 是 + 单一服务     → Controller + Service
└─ 否（仅展示）      → Controller + Service + Utils
```

### 前端组件

```
Hooks → 事件处理 → 渲染（顺序固定）
```

### 状态管理

```
本地状态 → Context → 全局状态（Zustand/Redux）
```

---

## 规范文档索引

| 任务类型 | 参考文档 |
|---------|---------|
| 后端架构分层 | [references/backend-general.md](references/backend-general.md) |
| Koa + routing-controllers | [references/backend-framework.md](references/backend-framework.md) |
| React 组件开发 | [references/frontend-react.md](references/frontend-react.md) |
| RESTful API 设计 | [references/api-standards.md](references/api-standards.md) |
| Prisma 数据库操作 | [references/database-standards.md](references/database-standards.md) |
| 权限模块设计 | [references/modules/auth-module.md](references/modules/auth-module.md) |
| Git 工作流与 PR | [references/team-workflow.md](references/team-workflow.md) |

---

## 配置与脚本

| 资源 | 位置 |
|-----|------|
| TypeScript 配置 | [assets/tsconfig.json](assets/tsconfig.json) |
| Prettier 配置 | [assets/.prettierrc](assets/.prettierrc) |
| ESLint 配置 | [assets/eslint.config.mjs](assets/eslint.config.mjs) |
| 配置说明 | [assets/README.md](assets/README.md) |
| Lint 脚本 | [scripts/lint-check.sh](scripts/lint-check.sh) |
| Format 脚本 | [scripts/format-code.sh](scripts/format-code.sh) |

---

## 关键约定

- **API 路由**：`/api` 前缀，复数资源，小写连字符
- **响应格式**：`{ code, message, data }`
- **错误码**：5 位数字 `XXYYZ`（XX=HTTP状态码, YY=模块, Z=错误）
- **Commit**：`<type>: <subject>`（feat/fix/docs/refactor/perf/test/chore）
- **分支**：`feature/*`、`bugfix/*`、`hotfix/*`、`release/*`

---

## 使用流程

1. 确定任务类型
2. 查阅对应的 references 文档
3. 按文档中的检查清单验证代码
4. 提交前运行 `scripts/lint-check.sh` 和 `scripts/format-code.sh`
