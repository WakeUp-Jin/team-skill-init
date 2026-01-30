# 团队 Skill 维护指南

团队共享的 **Claude Code Skill 仓库**，用于统一开发规范和最佳实践，确保代码风格和架构的一致性。

---

## 目录结构

```
team-skill/
├── SKILL.md                    # Skill 主入口文件
├── references/                 # 规范文档目录
│   ├── frontend-react.md       # 前端 React 规范
│   ├── backend-general.md      # 后端通用规范
│   ├── api-standards.md        # 接口规范
│   ├── database-standards.md   # 数据库规范
│   └── modules/                # 功能模块开发指南
│       ├── auth-module.md      # 权限模块
│       ├── payment-module.md   # 支付模块
│       └── ...
├── scripts/                    # 自动化脚本
└── assets/                     # 配置模板
```

---

## 维护原则

1. **简洁明确** - 只写团队统一方案，用代码示例代替长篇说明
2. **结构一致** - 规范放 `references/`，模块放 `references/modules/`
3. **及时更新** - 技术栈变化时更新文档，修改后更新 `SKILL.md` 入口

---

## 如何新增规范文档?

### 1. 创建文档

在对应目录下创建 `.md` 文件:
- 通用规范: `references/xxx-standards.md`
- 功能模块: `references/modules/xxx-module.md`

### 2. 编写内容

使用统一结构:
- 技术选型（团队用什么）
- 代码示例（关键代码）
- 必须遵守的规则（✅ 列表）

### 3. 更新入口

在 `SKILL.md` 中添加链接:
```markdown
- **XXX?** → [XXX规范](references/xxx.md)
```

---

## 如何使用?

在 Claude Code 中输入 `/team-standards` 或直接说"用团队规范实现XXX"

---

## 文档编写示例

❌ **太宽泛**: "可以使用 Session、JWT、OAuth2 等方式，根据项目需求选择..."

✅ **明确方案**: "我们统一使用 JWT，Token 存储在 HTTP-only Cookie 中，过期时间 1 小时"

---

## 常见问题

**Q: 修改后如何测试?**
A: 调用 `/team-standards` 检查是否读取到最新内容

**Q: 需要打包成 .skill 文件吗?**
A: 不需要，直接修改源文件即可

**Q: 如何让团队使用?**
A: 将仓库路径添加到 Claude Code 的 Skill 配置中

---

## 总结

**核心目标**: 让团队开发保持一致性，让 AI 生成符合团队规范的代码

**维护原则**: 简洁、明确、实用
