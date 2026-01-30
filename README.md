# Team Skills

团队共享的 Claude Code Skills 仓库，用于统一开发规范和最佳实践。

## 📦 包含的 Skills

### team-standards - 团队开发规范

团队全栈 TypeScript 项目开发规范，涵盖前端、后端、API、数据库等全方位开发标准。

**适用场景：**
- 编写 React 组件或前端功能
- 开发 Koa 后端 API
- 设计 RESTful 接口
- 编写 Prisma 数据库查询
- 实现权限模块
- 创建 Git 提交或 PR
- 审查代码是否符合团队规范

**包含内容：**
- 后端架构分层规范
- React 组件开发规范
- RESTful API 设计标准
- Prisma 数据库操作规范
- 权限模块设计指南
- Git 工作流与 PR 规范
- TypeScript/ESLint/Prettier 配置模板

## 🚀 安装方法

### 安装特定 Skill

```bash
npx skills add https://github.com/你的用户名/team-skill --skill team-standards
```

### 安装所有 Skills

```bash
npx skills add https://github.com/你的用户名/team-skill
```

## 💡 使用方法

安装后，在 Claude Code 中：

1. **自动触发**：当你进行相关开发任务时，Claude 会自动参考团队规范
2. **手动调用**：输入 `/team-standards` 查看规范内容
3. **代码审查**：要求 Claude "按团队规范审查这段代码"

## 📚 Skill 详情

### team-standards

详细文档请查看：[team-standards/SKILL.md](team-standards/SKILL.md)

**快速决策树：**

```
后端分层：
├─ 涉及业务规则 + 跨服务/需事务 → Controller + DoService + Service
├─ 涉及业务规则 + 单一服务     → Controller + Service
└─ 仅展示数据                → Controller + Service + Utils

前端组件：
Hooks → 事件处理 → 渲染（顺序固定）

状态管理：
本地状态 → Context → 全局状态（Zustand/Redux）
```

## 🔧 维护指南

### 如何添加新规范

1. 在 `team-standards/references/` 目录下创建新的 `.md` 文件
2. 更新 `team-standards/SKILL.md` 添加索引链接
3. 提交更改并推送到仓库

### 如何添加新 Skill

1. 在根目录创建新的 skill 目录（如 `new-skill/`）
2. 在该目录下创建 `SKILL.md` 文件，包含 frontmatter 元数据
3. 更新本 README.md 添加新 skill 的说明
4. 提交更改并推送到仓库

## 📝 关键约定

- **API 路由**：`/api` 前缀，复数资源，小写连字符
- **响应格式**：`{ code, message, data }`
- **错误码**：5 位数字 `XXYYZ`（XX=HTTP状态码, YY=模块, Z=错误）
- **Commit**：`<type>: <subject>`（feat/fix/docs/refactor/perf/test/chore）
- **分支**：`feature/*`、`bugfix/*`、`hotfix/*`、`release/*`

## 🤝 贡献

欢迎团队成员贡献新的规范和最佳实践：

1. Fork 本仓库
2. 创建特性分支
3. 提交更改
4. 发起 Pull Request

## 📄 许可证

内部团队使用
