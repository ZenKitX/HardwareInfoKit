# hardware_info_kit 发布检查清单

本文档提供发布新版本前的完整检查清单。

## 版本号规范

遵循语义化版本 (Semantic Versioning):

- **主版本号 (Major)**: 不兼容的 API 变更
- **次版本号 (Minor)**: 向后兼容的功能新增
- **修订号 (Patch)**: 向后兼容的问题修正

示例: `1.2.3`
- 1 = 主版本号
- 2 = 次版本号
- 3 = 修订号

---

## 发布前检查清单

### 1. 代码质量 ✅

#### 代码分析

```bash
flutter analyze
```

- [ ] 无 error
- [ ] 无 warning
- [ ] info 级别问题已处理或确认可忽略

#### 代码格式化

```bash
dart format .
```

- [ ] 所有文件已格式化
- [ ] 代码风格一致

#### 单元测试

```bash
flutter test
```

- [ ] 所有测试通过
- [ ] 测试覆盖率 >= 80%
- [ ] 新功能有对应测试

#### 集成测试

```bash
cd example
flutter test integration_test
```

- [ ] Windows 平台测试通过
- [ ] Android 平台测试通过

---

### 2. 文档完整性 ✅

#### 核心文档

- [ ] README.md 已更新
  - [ ] 版本号正确
  - [ ] 功能列表完整
  - [ ] 示例代码可运行
  - [ ] 平台支持信息准确

- [ ] CHANGELOG.md 已更新
  - [ ] 新版本号和日期
  - [ ] 所有变更已记录
  - [ ] 分类清晰（新增/修复/变更/移除）

- [ ] pubspec.yaml 已更新
  - [ ] 版本号正确
  - [ ] 依赖版本正确
  - [ ] 描述准确

#### API 文档

- [ ] doc/API.md 已更新
  - [ ] 新 API 已文档化
  - [ ] 示例代码正确
  - [ ] 参数说明完整

- [ ] 代码注释完整
  - [ ] 所有公共 API 有文档注释
  - [ ] 示例代码可运行
  - [ ] 参数和返回值说明清晰

#### 其他文档

- [ ] CONTRIBUTING.md 准确
- [ ] LICENSE 文件存在
- [ ] doc/ARCHITECTURE.md 反映当前架构
- [ ] doc/CODE_STYLE.md 准确
- [ ] doc/QUICK_REFERENCE.md 已更新

---

### 3. 示例应用 ✅

#### 功能测试

- [ ] 示例应用可编译
- [ ] Windows 平台运行正常
- [ ] Android 平台运行正常
- [ ] 所有功能可演示
- [ ] UI 显示正确

#### 代码质量

- [ ] 示例代码清晰易懂
- [ ] 注释充分
- [ ] 遵循最佳实践

---

### 4. 平台兼容性 ✅

#### Windows

- [ ] Windows 10 测试通过
- [ ] Windows 11 测试通过
- [ ] 编译无警告
- [ ] 所有 API 正常工作

#### Android

- [ ] API 21 (Android 5.0) 测试通过
- [ ] 最新 Android 版本测试通过
- [ ] 编译无警告
- [ ] 所有 API 正常工作
- [ ] 权限配置正确

---

### 5. 发布准备 ✅

#### 版本信息

- [ ] pubspec.yaml 版本号已更新
- [ ] CHANGELOG.md 版本号已更新
- [ ] README.md 版本号已更新

#### Git 准备

- [ ] 所有变更已提交
- [ ] 提交消息符合规范
- [ ] 分支干净（无未提交的变更）

#### 发布检查

```bash
flutter pub publish --dry-run
```

- [ ] 无 error
- [ ] 无 warning
- [ ] 包大小合理
- [ ] 包含正确的文件

---

### 6. 性能测试 ✅

#### Benchmark 测试

```bash
dart run benchmark/hardware_info_benchmark.dart
```

- [ ] 性能符合预期
- [ ] 无性能退化
- [ ] 内存使用正常

#### 性能指标

- [ ] API 调用 < 100ms
- [ ] 内存占用合理
- [ ] 无内存泄漏

---

### 7. 安全检查 ✅

#### 代码安全

- [ ] 无硬编码的敏感信息
- [ ] 无安全漏洞
- [ ] 依赖包无已知漏洞

#### 权限检查

- [ ] Android 权限最小化
- [ ] 权限说明清晰

---

## 发布流程

### 1. 准备发布

```bash
# 1. 确保在 main 分支
git checkout main
git pull origin main

# 2. 更新版本号
# 编辑 pubspec.yaml, CHANGELOG.md, README.md

# 3. 运行所有检查
flutter analyze
flutter test
flutter pub publish --dry-run

# 4. 提交变更
git add .
git commit -m "chore: 准备 v1.x.x 发布"
git push origin main
```

### 2. 创建标签

```bash
# 创建标签
git tag v1.x.x

# 推送标签
git push origin v1.x.x
```

### 3. 发布到 pub.dev

```bash
# 发布
flutter pub publish

# 确认发布
# 输入 'y' 确认
```

### 4. 发布后检查

- [ ] pub.dev 页面显示正常
- [ ] 版本号正确
- [ ] 文档显示正常
- [ ] 示例代码正确

### 5. 创建 GitHub Release

1. 访问 GitHub 仓库
2. 点击 "Releases"
3. 点击 "Create a new release"
4. 选择标签 v1.x.x
5. 填写 Release 标题和说明
6. 从 CHANGELOG.md 复制变更内容
7. 发布 Release

---

## 发布后任务

### 1. 通知

- [ ] 在 GitHub 发布 Release 公告
- [ ] 更新项目主页
- [ ] 通知相关开发者

### 2. 监控

- [ ] 监控 pub.dev 下载量
- [ ] 关注 GitHub Issues
- [ ] 收集用户反馈

### 3. 文档

- [ ] 更新在线文档
- [ ] 更新示例项目
- [ ] 更新教程

---

## 回滚计划

如果发布后发现严重问题：

### 1. 评估问题

- 问题严重程度
- 影响范围
- 是否需要立即回滚

### 2. 快速修复

如果可以快速修复：

```bash
# 1. 修复问题
# 2. 更新版本号（patch 版本）
# 3. 重新发布
flutter pub publish
```

### 3. 回滚版本

如果需要回滚：

```bash
# 1. 在 pub.dev 标记版本为 discontinued
# 2. 发布修复版本
# 3. 通知用户
```

---

## 版本发布时间表

### 主版本 (Major)

- 频率: 每年 1-2 次
- 包含: 重大功能、不兼容变更
- 提前通知: 至少 1 个月

### 次版本 (Minor)

- 频率: 每季度 1-2 次
- 包含: 新功能、改进
- 提前通知: 至少 1 周

### 修订版本 (Patch)

- 频率: 按需发布
- 包含: Bug 修复、小改进
- 提前通知: 不需要

---

## 检查清单模板

复制以下模板用于每次发布：

```markdown
## 发布检查清单 - v1.x.x

### 代码质量
- [ ] flutter analyze 通过
- [ ] dart format 完成
- [ ] flutter test 通过
- [ ] 集成测试通过

### 文档
- [ ] README.md 已更新
- [ ] CHANGELOG.md 已更新
- [ ] API 文档已更新
- [ ] 版本号一致

### 测试
- [ ] Windows 测试通过
- [ ] Android 测试通过
- [ ] 示例应用正常

### 发布
- [ ] dry-run 通过
- [ ] Git 标签已创建
- [ ] 已发布到 pub.dev
- [ ] GitHub Release 已创建

### 发布后
- [ ] pub.dev 显示正常
- [ ] 文档显示正常
- [ ] 通知已发送
```

---

**文档版本**: 1.0  
**创建日期**: 2026-03-08  
**项目**: hardware_info_kit
