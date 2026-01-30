# 团队协作规范

## Git 工作流

### 分支管理

```
main (master)           # 生产环境 [🔒 保护分支，禁止直接 push]
├── develop             # 开发环境 [🔒 保护分支，禁止直接 push]
├── feature/*           # 功能分支
├── bugfix/*            # Bug 修复
├── hotfix/*            # 紧急修复
└── release/*           # 发布分支
```

**分支命名**：
```bash
feature/user-authentication      # 功能
bugfix/login-error               # Bug 修复
hotfix/security-patch            # 紧急修复
release/v1.2.0                   # 发布
```

---

### 工作流程

#### 日常开发（Feature）

```bash
# 1. 创建分支
git checkout develop && git pull origin develop
git checkout -b feature/my-feature

# 2. 开发 + 提交
git add . && git commit -m "feat: 添加新功能"

# 3. 推送 + 创建 PR
git push origin feature/my-feature
# 在 GitHub/GitLab 创建 PR → 审查 → 合并

# 4. 合并后清理
git checkout develop && git pull origin develop
git branch -d feature/my-feature
```

#### 紧急修复（Hotfix）

```bash
# 1. 从 main 创建分支
git checkout main && git pull origin main
git checkout -b hotfix/critical-fix

# 2. 修复 + 推送
git add . && git commit -m "fix: 修复严重 Bug"
git push origin hotfix/critical-fix

# 3. 创建 PR 到 main → 合并
# 4. 创建 PR 到 develop → 合并
```

---

## Commit 规范

### 格式

```
<type>(<scope>): <subject>
```

### Type 类型

```
feat:     新功能
fix:      Bug 修复
docs:     文档更新
refactor: 重构
perf:     性能优化
test:     测试
chore:    构建/工具变动
```

### 示例

```bash
# ✅ 好的示例（英文 type + 中文描述）
git commit -m "feat: 添加用户登录功能"
git commit -m "fix: 修复标题重复问题"
git commit -m "refactor: 简化错误处理逻辑"

# ❌ 坏的示例
git commit -m "更新"           # 太简单
git commit -m "修复bug"        # 不够具体
```

---

## Pull Request 规范

### PR 标题

```
feat: 添加用户认证系统
fix: 修复章节重复 Bug
refactor: 简化 API 错误处理
```

### PR 描述模板

```markdown
## 变更类型
- [ ] 新功能 / Bug 修复 / 重构 / 文档

## 变更说明
简要描述变更内容和原因

## 测试
- [ ] 单元测试已通过
- [ ] 手动测试已完成

## Checklist
- [ ] 代码遵循项目规范
- [ ] 已更新相关文档
- [ ] 所有测试通过
```

---

## 代码审查

### 审查清单

**代码质量**
- [ ] 代码清晰易懂，命名规范
- [ ] 无重复代码，遵循团队规范

**功能实现**
- [ ] 功能正确实现，边界情况已处理
- [ ] 错误处理完善

**性能与安全**
- [ ] 无性能问题（N+1 查询、大循环）
- [ ] 无安全风险（SQL 注入、XSS）
- [ ] 权限验证完善

**测试**
- [ ] 有单元测试，覆盖率足够

### 审查评论示例

```markdown
❓ 这里是否考虑了用户未登录的情况？
💡 建议使用 useMemo 缓存计算结果
⚠️ 直接使用用户输入可能导致 XSS 攻击
🐌 这个查询可能导致 N+1 问题
```

---

## 测试规范

### 测试覆盖率要求

```
语句覆盖率: >= 80%
分支覆盖率: >= 75%
函数覆盖率: >= 80%
```

### 测试示例

```typescript
// 单元测试
describe('calculateDiscount', () => {
  it('应该正确计算 10% 折扣', () => {
    expect(calculateDiscount(100, 0.1)).toBe(90);
  });
});

// 集成测试
describe('POST /api/chapters', () => {
  it('应该成功创建章节', async () => {
    const response = await request(app)
      .post('/api/chapters')
      .send({ title: '测试章节' })
      .set('Authorization', `Bearer ${token}`);

    expect(response.status).toBe(201);
  });
});
```

---

## 文档规范

### README.md 结构

```markdown
# 项目名称

## 功能特性
- 功能列表

## 技术栈
- 前端/后端/数据库

## 快速开始
### 环境要求
### 安装步骤
### 运行命令

## 项目结构
```

### 代码注释

```typescript
/**
 * 函数功能描述
 * @param paramName 参数说明
 * @returns 返回值说明
 */
function functionName(paramName: string): ReturnType {
  // 实现
}
```

---

## 发布流程

### 版本号规范

```
1.0.0 → 1.0.1  # PATCH: Bug 修复
1.0.1 → 1.1.0  # MINOR: 新功能（向后兼容）
1.1.0 → 2.0.0  # MAJOR: 破坏性变更
```

### CHANGELOG.md

```markdown
## [1.2.0] - 2024-01-30

### Added
- 新增功能列表

### Changed
- 变更内容

### Fixed
- 修复的 Bug
```

---

## 快速检查清单

### 提交代码前
- [ ] 代码符合团队规范
- [ ] 通过本地测试和 lint
- [ ] Commit message 符合规范

### 创建 PR 前
- [ ] 分支与 develop 同步
- [ ] 已解决所有冲突
- [ ] 已填写 PR 描述

### 审查代码时
- [ ] 代码质量合格
- [ ] 功能正确实现
- [ ] 无性能和安全问题
- [ ] 测试覆盖率足够

### 合并 PR 前
- [ ] 通过所有 CI 检查
- [ ] 有足够的审查批准
- [ ] 已解决所有评论

---

## 常见问题

**Q: 无法推送到 main/develop**
```bash
# ❌ 错误：直接 push
git push origin main

# ✅ 正确：创建 PR
git push origin feature/my-feature
# 然后在 GitHub/GitLab 创建 PR
```

**Q: PR 被拒绝，CI 检查失败**
```bash
# 本地修复问题
npm run lint && npm run test && npm run build

# 提交并推送
git add . && git commit -m "fix: 修复 CI 问题"
git push origin feature/your-branch
```

**Q: PR 冲突**
```bash
# 同步最新代码
git fetch origin develop
git rebase origin/develop

# 解决冲突后
git add . && git rebase --continue
git push origin feature/your-branch --force-with-lease
```

---

**相关文档**：
- [后端通用规范](./backend-general.md)
- [Koa 框架规范](./backend-framework.md)
- [数据库规范](./database-standards.md)
- [API 接口规范](./api-standards.md)
- [前端 React 规范](./frontend-react.md)
