# 后端通用规范（一页版）

## 目标
统一分层职责，降低耦合与循环依赖，保证业务规则可维护、可测试。

---

## 分层架构（默认规则）
- **Controller**：参数验证、调用 Service/DoService、简单数据整理（仅展示/格式化）
- **DoService（可选）**：跨服务编排、事务管理、复杂业务规则
- **Service**：单一业务逻辑（含业务规则）、数据库操作、外部 API 调用
- **Utils**：纯函数，无副作用
- **Helpers**：基础设施/SDK 封装（可能有副作用），仅由 Service/DoService 调用

---

## 选择规则（决策树）
```
是否涉及业务规则（价格/权限/支付校验）？
├─ 是
│   ├─ 跨多个 Service 或需要事务？
│   │   ├─ 是 → Controller + DoService + Service
│   │   └─ 否 → Controller + Service (+ Utils)
└─ 否（仅展示/格式化）
    ├─ 1-2 个 Service → Controller + Service + Utils
    └─ 3+ 个 Service → Controller + DoService + Service
```

---

## 各层职责与禁区

**Controller**
- 允许：1-2 个 Service 的展示聚合、格式化
- 禁止：业务规则、事务、直接 DB

**DoService**
- 允许：跨服务编排、事务、复杂业务规则
- 禁止：直接操作 DB（应通过 Service）

**Service**
- 允许：单一业务逻辑、DB/外部 API、缓存
- 禁止：调用其他 Service（避免循环依赖）

**Utils**
- 允许：纯函数、可复用计算/格式化
- 禁止：DB/外部调用/副作用

**Helpers**
- 允许：基础设施封装（SDK/第三方客户端）
- 禁止：业务规则、业务编排

---

## 结构建议（最小集）
```
src/
├── controllers/
├── doservices/        # 复杂场景才需要
├── services/
├── utils/
├── helpers/
├── dto/
├── middlewares/
└── config/
```

---

## 错误处理与日志（最低要求）
- 业务错误与系统错误分离（统一错误码）
- 关键路径写 INFO，异常写 ERROR
- 不吞错，不使用裸 console.log

---

## 快速检查清单
- [ ] 业务规则是否放在 Service/DoService？
- [ ] 是否需要事务？需要则用 DoService
- [ ] Service 是否调用了其他 Service？（不允许）
- [ ] Controller 是否仅做验证/格式化？
- [ ] 是否存在 N+1 / 缓存缺失？
- [ ] 是否有关键日志与错误码？
