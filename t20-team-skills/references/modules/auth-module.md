# 权限模块规范（课程型项目）

## 适用范围
- 课程/内容类项目，**课程是最小权限颗粒度**
- 兑换码/商品驱动授权
- 需要灵活组合课程包，但不追求复杂 RBAC

---

## 设计目标
- 权限规则可组合、可运营、可审计
- 接口鉴权与数据过滤一致
- 过期时间可精确到单条授权
- 易扩展到非课程资源

---

## 核心概念
- **权限（Permission）**：表示“可以做什么”（如“课程可观看”）
- **权限组（PermissionGroup）**：商品/兑换码的权益集合（可 1-1 对权限）
- **资源（Resource）**：最小控制对象（本项目为 course_id）
- **授权（Grant）**：用户实际生效权限与过期时间

> 课程型项目可将“权限组 1-1 对权限”作为默认简化模式，保留组合能力。

---

## 推荐数据模型（最小可落地）

### 1) 权限表
```
permission
- id
- name
- status
```

### 2) 权限组表（可 1-1）
```
permission_group
- id
- name
- status
```

### 3) 权限组 → 权限（组合能力）
```
permission_group_permission
- permission_group_id
- permission_id
- duration_days     # 该权限在该组内的有效时长（null=永久）
```

### 4) 权限 → 课程（资源归属）
```
permission_course
- permission_id
- course_id
```

### 5) 用户授权（时间在这里）
```
user_permission_grant
- user_id
- permission_id
- permission_group_id  # 授权来源的权限组
- start_at
- expires_at        # null=永久
- status
```

> **时间必须放在 user_permission_grant**，满足“同组不同权限不同过期”的需求。

---

## 授权流程（购买/兑换）
1. 兑换码绑定权限组（或直接对应权限组）
2. 根据 `permission_group_permission` 展开权限列表
3. 为每条权限生成 `user_permission_grant`
4. `expires_at = max(now, existing.expires_at) + duration_days`
5. 清理用户权限缓存

---

## 鉴权策略（接口 + 数据）

### 1) 接口级（能否进入接口）
- 可选：接口声明需要的权限（`permission_id`）
- **写操作/非课程资源接口必须声明权限**
- 纯课程列表接口可仅依赖数据过滤（不强制接口级声明）

### 2) 数据级（能否访问具体课程）
- 依据权限 → 课程映射表进行过滤
- 规则：
  - `course_id` ∈ 用户权限对应的可访问课程集合

> 课程类接口：**数据级过滤为主**；关键接口可叠加接口级校验。

---

## 列表查询的权限过滤（标准做法）
- 查询可访问课程集合：
```
SELECT course_id FROM permission_course
WHERE permission_id IN (用户有效权限)
```
- 列表接口必须按该集合过滤

---

## 续费/重复购买策略
- **推荐：更新过期时间**（同权限合并更简单）
  - `expires_at = max(existing, now) + duration`
- 如果必须保留历史：写入 `grant_log`，业务只查当前授权表

---

## 缓存策略
- 缓存用户权限：`user:{id}:permissions`
- TTL = 最短 expires_at（若存在）
- 授权变更必须清缓存

---

## 新增权限流程（标准清单）
1. 新增 `permission`
2. 建立 `permission_group_permission` 映射
3. 建立 `permission_course` 映射
4. 若需要接口级校验，加入 `@Authorized(permission_id)`
5. 刷新缓存/发布

---

## 权限组是否必须？
- **不做复杂套餐时**：权限组可 1-1 对权限
- **需要运营组合时**：权限组作为组合层非常关键

---

**补充规则：权限 ID 一旦发布不可变**
- 禁止重建/重排权限表的 ID 顺序
- 迁移时保证 ID 一致

## 常见问题
**Q1：是否需要 scope？**
- 课程型项目以 course_id 为最小资源，通常不需要 scope
- 若资源不是课程（如下载/后台），可扩展 scope 或新增权限类型

**Q2：接口参数还需要权限判断吗？**
- 不建议把校验写死在参数层
- 统一走权限→课程映射进行判断更稳定

---

## 快速检查清单
- [ ] 课程是否通过 permission_course 过滤
- [ ] 过期时间是否在 user_permission_grant
- [ ] 接口是否声明权限
- [ ] 授权变更是否清缓存
- [ ] 新增权限是否更新两张映射表

---

**相关文档**：
- [后端通用规范](../backend-general.md)
- [API 接口规范](../api-standards.md)
- [数据库规范](../database-standards.md)
