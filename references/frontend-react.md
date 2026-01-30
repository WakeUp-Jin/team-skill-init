# 前端 React 规范（一页版）

## 目标
统一组件/状态/样式/API 调用与性能策略，保证代码一致性。

---

## 组件规范（必须）
- 组件命名 PascalCase，Props 接口为 `ComponentNameProps`
- 事件处理函数 `handleXxx`，布尔值 `is/has/should`
- 组件结构：Hooks → 事件 → 渲染（顺序固定）

---

## Hooks 规范（必须）
- `useState` 明确类型，使用函数式更新
- `useEffect` 明确依赖，必要时清理
- `useCallback/useMemo` 仅在性能需要时使用

---

## 状态管理（建议路径）
- 本地状态 → Context → 全局状态（Zustand/Redux）
- 共享/复杂状态才上全局

---

## 样式规范（必须）
- 默认使用 CSS Modules
- 条件样式用 `classnames`
- 禁止大面积内联样式

---

## API 调用（必须）
- 统一封装在自定义 Hooks 或请求层
- 必须处理 loading / error 状态
- 推荐使用 SWR/React Query

---

## 性能优化（按需）
- `React.memo`、懒加载、虚拟列表
- 长列表必须虚拟化

---

## 错误处理（必须）
- 关键页面使用 Error Boundary
- 统一上报错误（日志/监控）

---

## 测试（建议）
- 关键组件使用 RTL 测试

---

## 快速检查清单
- [ ] 组件/Props 命名是否规范
- [ ] Hooks 依赖是否完整
- [ ] 是否避免不必要重渲染
- [ ] API 是否有 loading/error
- [ ] 样式是否 CSS Modules
- [ ] 关键页面是否有 Error Boundary

---

**相关文档**：
- [API 接口规范](./api-standards.md)
- [团队协作规范](./team-workflow.md)
