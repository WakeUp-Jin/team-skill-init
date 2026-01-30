# Koa 框架规范（一页版）

## 目标
统一 routing-controllers 用法、路由与中间件约定，保持一致可维护。

---

## 基础约定
- 路由统一 `/api` 前缀，小写+连字符
- Controller 使用复数资源名（`/api/users`）
- RESTful 为默认（GET/POST/PUT/PATCH/DELETE）

---

## 装饰器使用（最小规范）
- **路径**：`@Controller('/api/xxx')`，不要尾斜杠
- **参数**：优先 `@Param/@Query/@Body`，避免滥用 `@Req`
- **参数校验**：小接口可手写校验；复杂/复用/安全敏感接口必须 DTO + 装饰器校验
- **响应**：除下载/流式响应外，不使用 `@Res`

示例：
```ts
@Controller('/api/chapters')
export class ChapterController {
  @Get('/:id')
  async get(@Param('id') id: string) {
    return await this.chapterService.findById(id);
  }

  @Post('/')
  async create(@Body() dto: CreateChapterDto) {
    return await this.chapterDoService.createChapter(dto);
  }
}
```

---

## 中间件规范
- **顺序**：Auth → RateLimit → Validation → Business → ResponseFormatter → ErrorHandler
- **共享数据**：使用 `ctx.state`，不要直接挂到 `ctx`
- **错误**：统一错误码；不吞错；所有异常记录 ERROR 日志

---

## 路由设计
- 资源路由：`/api/chapters/:id`
- 嵌套资源：`/api/chapters/:id/comments`
- 自定义动作：`/api/chapters/:id/publish`
- 版本管理：推荐请求头 `api-version`，必要时 URL 版本

---

## 响应格式（统一）
```ts
// Success
{ code: 0, message: 'success', data: T }

// Error
{ code: number, message: string, data?: any }
```

---

## 快速检查清单
- [ ] 路由是否 RESTful + `/api` 前缀
- [ ] 是否使用 DTO 校验参数
- [ ] 是否避免 `@Req/@Res` 滥用
- [ ] 中间件是否按层次组织且错误可追踪
- [ ] 响应格式是否统一

---

**相关文档**：
- [后端通用规范](./backend-general.md)
- [数据库规范](./database-standards.md)
- [API 接口规范](./api-standards.md)
