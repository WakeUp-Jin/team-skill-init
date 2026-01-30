# 配置文件说明

本目录包含项目的标准配置文件模板。

---

## 文件列表

### 1. tsconfig.json - TypeScript 配置

**用途：** TypeScript 编译器配置文件

**主要配置：**
- **target**: `ES2022` - 编译目标为 ES2022
- **module**: `Node16` - 使用 Node.js 16+ 的模块系统
- **experimentalDecorators**: 启用装饰器支持（用于依赖注入等）
- **emitDecoratorMetadata**: 启用装饰器元数据（TypeORM、NestJS 等需要）
- **baseUrl**: `./` - 基础路径
- **paths**: 路径映射，支持 `@/*` 别名指向 `src/*`
- **outDir**: `dist` - 编译输出目录
- **esModuleInterop**: 启用 CommonJS 模块兼容
- **noImplicitAny**: `false` - 允许隐式 any 类型（可根据团队规范调整）

**使用方法：**
```bash
# 复制到项目根目录
cp assets/tsconfig.json ./

# 根据项目需求调整配置
# 例如：修改 paths 映射、include/exclude 路径等
```

**常见调整：**
```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["src/*"],
      "@models/*": ["src/models/*"],
      "@services/*": ["src/services/*"]
    }
  },
  "include": [
    "src/**/*",
    "tests/**/*"  // 如果需要包含测试文件
  ]
}
```

---

### 2. .prettierrc - Prettier 代码格式化配置

**用途：** 统一代码格式化风格

**主要配置：**
- **semi**: `true` - 语句末尾添加分号
- **trailingComma**: `es5` - 在 ES5 支持的地方添加尾随逗号
- **singleQuote**: `true` - 使用单引号
- **printWidth**: `100` - 每行最大字符数
- **tabWidth**: `2` - 缩进空格数
- **useTabs**: `false` - 使用空格而非 Tab

**使用方法：**
```bash
# 复制到项目根目录
cp assets/.prettierrc ./

# 安装 Prettier
npm install --save-dev prettier

# 格式化代码
npx prettier --write "src/**/*.{ts,js,json}"
```

**VSCode 集成：**
```json
// .vscode/settings.json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

---

### 3. eslint.config.mjs - ESLint 配置

**用途：** 代码质量检查和规范约束

**主要配置：**
- 使用 TypeScript ESLint 推荐配置
- 忽略 `node_modules`、`dist`、`build` 等目录
- 关闭与 Prettier 冲突的规则
- 允许使用 `any` 类型和 `let` 声明
- 关闭未使用变量检查（可根据团队规范调整）

**使用方法：**
```bash
# 复制到项目根目录
cp assets/eslint.config.mjs ./

# 安装依赖
npm install --save-dev eslint globals typescript-eslint

# 运行 ESLint
npx eslint .

# 自动修复
npx eslint . --fix
```

**规则说明：**

| 规则 | 配置 | 说明 |
|------|------|------|
| `prefer-const` | `off` | 允许使用 `let`，不强制 `const` |
| `no-unused-vars` | `off` | 允许未使用的变量（开发阶段） |
| `@typescript-eslint/no-explicit-any` | `off` | 允许使用 `any` 类型 |
| `@typescript-eslint/no-unused-vars` | `off` | 关闭 TS 未使用变量检查 |

**根据团队规范调整：**

如果团队要求更严格的代码质量，可以启用以下规则：

```javascript
rules: {
  "prefer-const": "warn",                              // 警告未使用 const
  "@typescript-eslint/no-unused-vars": ["warn", {      // 警告未使用变量
    "argsIgnorePattern": "^_",                         // 忽略 _ 开头的参数
    "varsIgnorePattern": "^_"
  }],
  "@typescript-eslint/no-explicit-any": "warn",        // 警告使用 any
}
```

---

## 完整项目设置流程

### 1. 初始化项目

```bash
# 创建项目目录
mkdir my-project && cd my-project

# 初始化 package.json
npm init -y

# 安装 TypeScript
npm install --save-dev typescript @types/node
```

### 2. 复制配置文件

```bash
# 从 team-skill/assets 复制配置文件
cp path/to/team-skill/assets/tsconfig.json ./
cp path/to/team-skill/assets/.prettierrc ./
cp path/to/team-skill/assets/eslint.config.mjs ./
```

### 3. 安装开发依赖

```bash
# 安装 ESLint 和 Prettier
npm install --save-dev \
  eslint \
  prettier \
  globals \
  typescript-eslint
```

### 4. 配置 package.json 脚本

```json
{
  "scripts": {
    "build": "tsc",
    "dev": "tsx watch src/index.ts",
    "start": "node dist/index.js",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write \"src/**/*.{ts,js,json}\"",
    "format:check": "prettier --check \"src/**/*.{ts,js,json}\""
  }
}
```

### 5. 创建项目结构

```bash
mkdir -p src/{models,services,controllers,routes,utils}
touch src/index.ts
```

### 6. 配置 Git 忽略

创建 `.gitignore`：

```gitignore
# 依赖
node_modules/

# 编译输出
dist/
build/

# 环境变量
.env
.env.local

# IDE
.vscode/
.idea/

# 日志
*.log
npm-debug.log*

# 操作系统
.DS_Store
Thumbs.db
```

---

## VSCode 推荐配置

创建 `.vscode/settings.json`：

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsdk": true
}
```

创建 `.vscode/extensions.json`（推荐扩展）：

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "ms-vscode.vscode-typescript-next"
  ]
}
```

---


## 配置文件版本

- **tsconfig.json**: v1.0.0
- **.prettierrc**: v1.0.0
- **eslint.config.mjs**: v1.0.0

**最后更新：** 2024-01-30

---

**相关文档：**
- [TypeScript 官方文档](https://www.typescriptlang.org/docs/)
- [Prettier 官方文档](https://prettier.io/docs/en/)
- [ESLint 官方文档](https://eslint.org/docs/latest/)
- [后端通用规范](../references/backend-general.md)
