# 数据库规范（一页版）

## 目标
统一命名、查询、事务与性能策略，保证数据库层一致性。

---

## 命名与映射（必须）
- **新表**：Schema 用 camelCase，DB 字段用 snake_case，通过 `@map` 映射
- **旧表**：保持 snake_case，不强制迁移
- **表名**：复数，snake_case

示例：
```prisma
model Chapter {
  id        String   @id @default(cuid())
  authorId  String   @map("author_id")
  createdAt DateTime @map("created_at")

  @@map("chapters")
}
```

---

## Prisma 使用规范（必须）
- **查询**：优先 `select`，避免无脑 `include`
- **分页**：统一 `skip/take`
- **动态条件**：构建 `where` 对象
- **避免 N+1**：需要时用 `include`

---

## 事务（必须）
- 关键多步写操作必须用 `prisma.$transaction`
- 失败必须回滚，禁止“半成功”

---

## 索引与性能（必须）
- 常用查询字段必须加索引
- 复合索引仅在高频联合查询时使用
- 避免对超长文本字段建索引

---

## Migration（必须）
- 命名清晰：`add_xxx_field` / `create_xxx_table`
- 开发：`migrate dev`
- 生产：`migrate deploy`

---

## Redis（推荐）
- Key 命名：`namespace:resource:id`
- 更新策略：写库后删缓存（或更新缓存）

---

## 快速检查清单
- [ ] 新表是否使用 `@map`，旧表是否保持原样
- [ ] 查询是否使用 `select` 限制字段
- [ ] 是否存在 N+1
- [ ] 关键写操作是否使用事务
- [ ] 是否有必要的索引
- [ ] 是否统一分页方式

---

**相关文档**：
- [后端通用规范](./backend-general.md)
- [Koa 框架规范](./backend-framework.md)
- [API 接口规范](./api-standards.md)
