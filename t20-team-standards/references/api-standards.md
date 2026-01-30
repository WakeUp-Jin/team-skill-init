# API 接口规范（一页版）

## 目标
统一 RESTful 设计、请求/响应格式与错误码，保证接口一致性。

---

## REST 路由规则（必须）
- `/api` 前缀，资源使用**复数**、小写、连字符
- 嵌套资源不超过 2 层
- 自定义动作：`POST /resource/:id/action`

示例：
```
GET    /api/chapters
GET    /api/chapters/:id
POST   /api/chapters/:id/publish
```

---

## HTTP 方法（必须）
- GET 查询（幂等）
- POST 创建（非幂等）
- PUT 完整更新（幂等）
- PATCH 部分更新（幂等）
- DELETE 删除（幂等）

---

## 请求规范（必须）
**Headers**
- `Content-Type: application/json`
- `Authorization: Bearer <token>`

**分页/排序**
- `page` 从 1 开始，`pageSize` 默认 20，最大 100
- `sortBy` + `order=asc|desc`

---

## 响应规范（必须）
**统一响应结构**
```ts
{ code: number; message: string; data: any }
```

**分页结构**
```ts
{ items: T[]; total: number; page: number; pageSize: number; totalPages: number }
```

---

## 错误码规则（必须）
- 5 位数字：`XXYYZ`
  - `XX` = HTTP 状态码
  - `YY` = 业务模块
  - `Z`  = 具体错误

示例：
- 40001 参数错误
- 40101 未认证
- 40301 无权限
- 40401 资源不存在
- 40901 资源冲突
- 42201 参数校验失败
- 42901 请求过多
- 50001 系统错误

---

## 认证与授权（必须）
- JWT Bearer Token
- 未认证返回 401；无权限返回 403

---

## 版本与文档（必须）
- 版本：推荐 **URL 版本**（`/api/v1/...`）
- 文档：必须提供 OpenAPI/Swagger（至少包含路径、参数、响应、错误）

---

## 快速检查清单
- [ ] 路由是否 RESTful + `/api` 前缀
- [ ] 是否统一响应结构
- [ ] 错误码是否符合 5 位规则
- [ ] 是否有分页与排序约定
- [ ] 是否有认证/权限
- [ ] 是否有 API 文档

---

**相关文档**：
- [后端通用规范](./backend-general.md)
- [Koa 框架规范](./backend-framework.md)
- [数据库规范](./database-standards.md)
