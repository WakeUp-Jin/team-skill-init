import globals from "globals";
import tseslint from "typescript-eslint";

/** @type {import('eslint').Linter.Config[]} */
export default [
  {
    ignores: [
      "node_modules/**",
      "dist/**",
      "build/**",
      "*.md",
      ".eslintrc.js",
      "webpack.config.js",
    ],
  },
  ...tseslint.configs.recommended,
  {
    files: ["**/*.{js,mjs,cjs,ts}"],
    languageOptions: {
      globals: globals.node,
    },
    rules: {
      // 基础规则
      "prefer-const": "off", // 关闭 prefer-const 规则，允许使用 let
      "no-unused-vars": "off", // 关闭未使用变量检查

      // TypeScript 规则
      "@typescript-eslint/no-explicit-any": "off", // 允许使用 any 类型
      "@typescript-eslint/no-unused-vars": "off", // 关闭 TypeScript 未使用变量检查
      "@typescript-eslint/no-inferrable-types": "off", // 允许显式类型注解，即使可以推断
      "@typescript-eslint/prefer-const": "off", // 关闭 TypeScript 的 prefer-const
      "@typescript-eslint/prefer-ts-expect-error": "off", // 允许 @ts-ignore

      // 禁用与Prettier冲突的规则
      "indent": "off",
      "linebreak-style": "off",
      "quotes": "off",
      "semi": "off",
      "comma-dangle": "off",
      "max-len": "off",
      "object-curly-spacing": "off",
      "array-bracket-spacing": "off",
      "space-before-function-paren": "off",
    },
  },
];
