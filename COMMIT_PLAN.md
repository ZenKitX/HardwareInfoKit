# hardware_info_kit 项目提交方案（原子化版本）

[English Version](COMMIT_PLAN_EN.md)

## 提交原则

1. **清晰明确 (Clear and Concise)**: 提交信息清楚说明"做了什么"以及"为什么这么做"
2. **原子性 (Atomic)**: 每次提交只包含一个逻辑变更
3. **格式化 (Structured)**: 采用统一的格式，方便工具解析和生成 CHANGELOG

## 详细提交方案（共约 25 个原子化提交）

### 第一阶段：项目基础配置（4 个提交）

#### 1. 项目配置文件

```bash
git commit -m "chore: 添加项目配置文件

- 添加 pubspec.yaml 定义项目元数据和依赖
- 配置 Flutter SDK 约束 >=3.3.0
- 配置 plugin_platform_interface 依赖"
```

#### 2. Git 忽略规则

```bash
git commit -m "chore: 添加 Git 忽略规则

- 添加 .gitignore 排除构建产物
- 排除 IDE 配置文件
- 排除临时文件和缓存"
```

#### 3. 发布忽略规则

```bash
git commit -m "chore: 添加发布忽略规则

- 添加 .pubignore 排除示例代码
- 排除文档源文件
- 排除开发工具配置"
```

#### 4. 代码分析配置

```bash
git commit -m "chore: 添加代码分析配置

- 添加 analysis_options.yaml
- 启用 flutter_lints 规则集
- 配置严格的代码质量检查"
```

### 第二阶段：许可证和元数据（2 个提交）

#### 5. MIT 许可证

```bash
git commit -m "docs: 添加 MIT 许可证

- 添加 LICENSE 文件
- 声明开源协议为 MIT"
```

#### 6. Flutter 元数据

```bash
git commit -m "chore: 添加 Flutter 元数据

- 添加 .metadata 文件
- 记录项目版本信息"
```

### 第三阶段：数据模型实现（9 个提交）

#### 7. SystemInfo 模型

```bash
git commit -m "feat(models): 添加 SystemInfo 数据模型

- 实现 SystemInfo 类
- 包含 CPU、内存、GPU、磁盘等信息
- 实现 JSON 序列化和反序列化"
```

#### 8. CpuInfo 模型

```bash
git commit -m "feat(models): 添加 CpuInfo 数据模型

- 实现 CpuInfo 类
- 包含处理器名称、核心数、频率
- 实现 JSON 序列化和反序列化"
```

#### 9. MemoryInfo 模型

```bash
git commit -m "feat(models): 添加 MemoryInfo 数据模型

- 实现 MemoryInfo 类
- 包含总量、可用、已用内存
- 实现使用率计算
- 实现 JSON 序列化和反序列化"
```

#### 10. GpuInfo 模型

```bash
git commit -m "feat(models): 添加 GpuInfo 数据模型

- 实现 GpuInfo 类
- 包含显卡名称、显存、渲染器
- 实现 JSON 序列化和反序列化"
```

#### 11. DiskInfo 模型

```bash
git commit -m "feat(models): 添加 DiskInfo 数据模型

- 实现 DiskInfo 类
- 包含总量、可用、已用空间
- 实现使用率计算
- 实现 JSON 序列化和反序列化"
```

#### 12. OsInfo 模型

```bash
git commit -m "feat(models): 添加 OsInfo 数据模型

- 实现 OsInfo 类
- 包含操作系统名称、版本、架构
- 实现 JSON 序列化和反序列化"
```

#### 13. BatteryInfo 模型

```bash
git commit -m "feat(models): 添加 BatteryInfo 数据模型

- 实现 BatteryInfo 类
- 包含电量百分比、充电状态
- 实现 JSON 序列化和反序列化"
```

#### 14. NetworkInfo 模型

```bash
git commit -m "feat(models): 添加 NetworkInfo 数据模型

- 实现 NetworkInfo 类
- 包含 IP 地址、MAC 地址
- 实现 JSON 序列化和反序列化"
```

#### 15. 模型导出文件

```bash
git commit -m "feat(models): 添加模型统一导出

- 添加 models.dart 导出所有模型
- 简化模型导入路径"
```

### 第四阶段：枚举类型（1 个提交）

#### 16. 枚举定义

```bash
git commit -m "feat(enums): 添加枚举类型定义

- 添加 BatteryState 枚举
- 定义充电、放电、已充满等状态"
```

### 第五阶段：平台接口层（2 个提交）

#### 17. 平台接口定义

```bash
git commit -m "feat(api): 添加平台接口定义

- 添加 HardwareInfoKitPlatform 抽象类
- 定义获取硬件信息的接口方法
- 使用 plugin_platform_interface"
```

#### 18. MethodChannel 实现

```bash
git commit -m "feat(api): 实现 MethodChannel 平台通信

- 添加 MethodChannelHardwareInfoKit 类
- 实现与原生平台的通信
- 处理平台返回的 JSON 数据"
```

### 第六阶段：Dart API 层（2 个提交）

#### 19. HardwareInfo 主 API

```bash
git commit -m "feat(api): 实现 HardwareInfo 主 API

- 添加 HardwareInfo 类
- 实现 getSystemInfo() 等方法
- 添加异常处理"
```

#### 20. API 导出文件

```bash
git commit -m "feat(api): 添加 API 统一导出

- 添加 hardware_info_kit.dart 导出文件
- 简化 API 使用"
```

### 第七阶段：Windows 平台实现（3 个提交）

#### 21. Windows 插件框架

```bash
git commit -m "feat(windows): 添加 Windows 插件框架

- 添加 CMakeLists.txt 构建配置
- 添加插件注册代码
- 配置 C++ 编译选项"
```

#### 22. Windows 硬件信息获取

```bash
git commit -m "feat(windows): 实现 Windows 硬件信息获取

- 实现 CPU 信息获取（WMI）
- 实现内存信息获取（GlobalMemoryStatusEx）
- 实现 GPU 信息获取（DXGI）
- 实现磁盘信息获取（GetDiskFreeSpaceEx）
- 实现操作系统信息获取（GetVersionEx）
- 实现电池信息获取（GetSystemPowerStatus）
- 实现网络信息获取（GetAdaptersInfo）"
```

#### 23. Windows 头文件

```bash
git commit -m "feat(windows): 添加 Windows 插件头文件

- 添加 C API 头文件
- 定义插件接口"
```

### 第八阶段：Android 平台实现（2 个提交）

#### 24. Android 插件配置

```bash
git commit -m "feat(android): 添加 Android 插件配置

- 添加 build.gradle.kts 构建配置
- 添加 AndroidManifest.xml
- 配置 Kotlin 编译选项"
```

#### 25. Android 硬件信息获取

```bash
git commit -m "feat(android): 实现 Android 硬件信息获取

- 实现 HardwareInfoKitPlugin 类
- 实现 CPU 信息获取（/proc/cpuinfo）
- 实现内存信息获取（ActivityManager）
- 实现 GPU 信息获取（GLES20）
- 实现磁盘信息获取（StatFs）
- 实现操作系统信息获取（Build）
- 实现电池信息获取（BatteryManager）
- 实现网络信息获取（NetworkInterface）"
```

### 第九阶段：测试（3 个提交）

#### 26. 平台接口测试

```bash
git commit -m "test(api): 添加平台接口测试

- 测试 MethodChannel 调用
- 测试数据解析
- 测试错误处理"
```

#### 27. 数据模型测试

```bash
git commit -m "test(models): 添加数据模型测试

- 测试模型创建
- 测试 JSON 序列化
- 测试 JSON 反序列化
- 验证数据完整性"
```

#### 28. Windows 平台测试

```bash
git commit -m "test(windows): 添加 Windows 平台测试

- 添加 C++ 单元测试
- 测试硬件信息获取"
```

#### 29. Android 平台测试

```bash
git commit -m "test(android): 添加 Android 平台测试

- 添加 Kotlin 单元测试
- 测试插件方法调用"
```

### 第十阶段：性能基准测试（1 个提交）

#### 30. 性能基准测试

```bash
git commit -m "perf: 添加性能基准测试

- 添加 benchmark/hardware_info_benchmark.dart
- 测试各个 API 的性能
- 验证响应时间 < 100ms"
```

### 第十一阶段：示例应用（4 个提交）

#### 31. 示例项目配置

```bash
git commit -m "docs(example): 添加示例项目配置

- 创建 example 目录
- 添加 pubspec.yaml
- 配置依赖"
```

#### 32. 示例应用 UI

```bash
git commit -m "docs(example): 实现示例应用 UI

- 实现 main.dart 主界面
- 展示硬件信息
- 添加刷新功能"
```

#### 33. 示例应用 Android 配置

```bash
git commit -m "docs(example): 添加示例应用 Android 配置

- 配置 Android 构建文件
- 配置 AndroidManifest.xml
- 添加 MainActivity"
```

#### 34. 示例应用 Windows 配置

```bash
git commit -m "docs(example): 添加示例应用 Windows 配置

- 配置 Windows CMakeLists.txt
- 添加 Windows runner 代码
- 配置资源文件"
```

#### 35. 示例应用测试

```bash
git commit -m "test(example): 添加示例应用测试

- 添加 widget 测试
- 添加集成测试
- Mock 平台调用"
```

### 第十二阶段：文档（6 个提交）

#### 36. README 文档

```bash
git commit -m "docs: 添加 README 文档

- 添加 README.md（中文）
- 添加 README_EN.md（英文）
- 项目介绍和特性说明
- 安装和快速开始指南"
```

#### 37. 使用指南

```bash
git commit -m "docs: 添加使用指南

- 添加 USAGE_GUIDE.md（中文）
- 添加 USAGE_GUIDE_EN.md（英文）
- 详细的 API 使用说明
- 代码示例和最佳实践"
```

#### 38. 贡献指南

```bash
git commit -m "docs: 添加贡献指南

- 添加 CONTRIBUTING.md（中文）
- 添加 CONTRIBUTING_EN.md（英文）
- 开发环境设置
- 提交规范和代码风格"
```

#### 39. API 参考文档

```bash
git commit -m "docs: 添加 API 参考文档

- 添加 doc/API.md
- 详细的 API 文档
- 参数说明和返回值"
```

#### 40. 架构文档

```bash
git commit -m "docs: 添加架构文档

- 添加 doc/ARCHITECTURE.md
- 系统架构说明
- 平台实现原理
- 扩展指南"
```

#### 41. 其他技术文档

```bash
git commit -m "docs: 添加其他技术文档

- 添加 doc/CODE_STYLE.md 代码风格指南
- 添加 doc/QUICK_REFERENCE.md 快速参考
- 添加 doc/RELEASE_CHECKLIST.md 发布检查清单
- 添加 doc/RELEASE_SUMMARY.md 发布摘要"
```

### 第十三阶段：CI/CD 配置（2 个提交）

#### 42. GitHub Actions CI

```bash
git commit -m "ci: 添加 GitHub Actions CI 配置

- 添加 .github/workflows/dart.yml
- 配置自动化测试
- 配置代码分析
- 配置发布检查"
```

#### 43. Git Hooks

```bash
git commit -m "chore: 添加 Git Hooks

- 添加 commit-msg hook 验证提交信息
- 添加 prepare-commit-msg hook
- 添加安装脚本"
```

### 第十四阶段：提交规范（1 个提交）

#### 44. 提交规范文档

```bash
git commit -m "docs: 添加提交规范文档

- 添加 .github/COMMIT_CONVENTION.md
- 定义提交信息格式
- 提供提交示例"
```

### 第十五阶段：变更日志和发布准备（3 个提交）

#### 45. 变更日志

```bash
git commit -m "docs: 添加变更日志

- 添加 CHANGELOG.md（中文）
- 添加 CHANGELOG_EN.md（英文）
- 记录 v1.0.0 的所有变更"
```

#### 46. 提交计划文档

```bash
git commit -m "docs: 添加提交计划文档

- 添加 COMMIT_PLAN.md（中文）
- 添加 COMMIT_PLAN_EN.md（英文）
- 记录提交策略和执行计划"
```

#### 47. Android 测试文档

```bash
git commit -m "docs: 添加 Android 测试文档

- 添加 ANDROID_TESTING.md
- 说明 Android 平台测试方法"
```

---

## 提交规范

遵循 `.github/COMMIT_CONVENTION.md` 中定义的规范。

### Type 类型

- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档变更
- `style`: 代码格式（不影响代码运行）
- `refactor`: 重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动
- `ci`: CI 配置变更

### Scope 范围

- `models`: 数据模型
- `enums`: 枚举类型
- `api`: Dart API 层
- `windows`: Windows 平台实现
- `android`: Android 平台实现
- `example`: 示例应用

---

## 执行计划

### 准备工作

1. 确保所有文件已保存
2. 确保测试通过
3. 确保代码分析通过

### 执行步骤

按照上述 47 个提交逐个执行，每个提交：
1. 只包含一个逻辑变更
2. 提交信息清晰明确
3. 代码可编译可运行
4. 相关测试通过

### 最终步骤

```bash
# 创建标签
git tag v1.0.0

# 推送到远程仓库
git push -u origin new-main
git push origin v1.0.0
```

---

## 当前状态

- ✅ 所有代码已完成
- ✅ Windows 和 Android 平台实现完成
- ✅ 文档已完善
- ✅ 示例应用已实现
- ✅ 所有测试通过
- ✅ CI 验证通过
- ✅ 项目更名修复完成
- 🚀 准备执行原子化提交方案（47 个提交）
- 📝 当前在 new-main 分支，已完成第 1 个提交

---

**准备日期**: 2026-03-08  
**项目**: hardware_info_kit  
**版本**: v1.0.0  
**提交方案**: 原子化版本（47 个提交）

### 第一阶段：项目初始化

#### 1. 项目基础配置

```bash
git commit -m "chore: 初始化项目配置

- 添加 pubspec.yaml 项目配置
- 添加 pubspec.lock 依赖锁定
- 配置 Flutter SDK 和依赖
- 配置 plugin_platform_interface"
```

#### 2. 忽略规则

```bash
git commit -m "chore: 添加 Git 和发布忽略规则

- 添加 .gitignore
- 添加 .pubignore
- 排除构建产物和临时文件"
```

#### 3. 许可证

```bash
git commit -m "docs: 添加 MIT 许可证

- 添加 LICENSE 文件"
```

#### 4. 代码分析配置

```bash
git commit -m "chore: 添加代码分析配置

- 添加 analysis_options.yaml
- 配置 flutter_lints 规则"
```

### 第二阶段：核心数据模型

#### 5. 数据模型实现

```bash
git commit -m "feat(models): 实现硬件信息数据模型

- 添加 SystemInfo 类
- 添加 CpuInfo 类
- 添加 MemoryInfo 类
- 添加 GpuInfo 类
- 添加 DiskInfo 类
- 添加 OsInfo 类
- 添加 BatteryInfo 类
- 添加 NetworkInfo 类
- 实现 JSON 序列化和反序列化"
```

#### 6. 数据模型测试

```bash
git commit -m "test(models): 添加数据模型测试

- 测试模型创建和序列化
- 测试 JSON 转换
- 测试便捷 getter 方法
- 验证数据完整性"
```

### 第三阶段：平台实现

#### 7. Windows 平台实现

```bash
git commit -m "feat(windows): 实现 Windows 平台支持

- 添加 Windows C++ 插件代码
- 实现 CPU 信息获取
- 实现内存信息获取
- 实现 GPU 信息获取
- 实现磁盘信息获取
- 实现操作系统信息获取
- 实现电池信息获取
- 实现网络信息获取
- 配置 CMakeLists.txt"
```

#### 8. Android 平台实现

```bash
git commit -m "feat(android): 实现 Android 平台支持

- 添加 Android Kotlin 插件代码
- 实现 CPU 信息获取
- 实现内存信息获取
- 实现 GPU 信息获取
- 实现磁盘信息获取
- 实现操作系统信息获取
- 实现电池信息获取
- 实现网络信息获取
- 配置 build.gradle.kts"
```

### 第四阶段：Dart API 层

#### 9. HardwareInfo API 实现

```bash
git commit -m "feat(api): 实现 HardwareInfo Dart API

- 添加 HardwareInfo 主类
- 实现 getSystemInfo() 方法
- 实现 getCpuInfo() 方法
- 实现 getMemoryInfo() 方法
- 实现 getGpuInfo() 方法
- 实现 getDiskInfo() 方法
- 实现 getOsInfo() 方法
- 实现 getBatteryInfo() 方法
- 实现 getNetworkInfo() 方法
- 添加异常处理"
```

#### 10. API 测试

```bash
git commit -m "test(api): 添加 API 测试

- 测试 MethodChannel 调用
- 测试数据解析
- 测试错误处理
- 验证 API 完整性"
```

### 第五阶段：示例应用

#### 11. 示例项目初始化

```bash
git commit -m "docs(example): 初始化示例项目

- 创建 Flutter 示例项目结构
- 配置 pubspec.yaml
- 添加 Windows 和 Android 平台配置"
```

#### 12. 示例应用实现

```bash
git commit -m "docs(example): 实现示例应用

- 实现硬件信息展示页面
- 展示 CPU、内存、GPU 信息
- 展示磁盘、电池、网络信息
- 展示操作系统信息
- 添加刷新功能
- 优化 UI 布局"
```

### 第六阶段：文档完善

#### 13. README 和使用指南

```bash
git commit -m "docs: 添加 README 和使用指南

- 添加 README.md 项目说明
- 添加 USAGE_GUIDE.md 详细使用指南
- 项目介绍和特性
- 安装和快速开始
- API 使用示例
- 平台支持说明
- 故障排查指南"
```

#### 14. 贡献指南和技术文档

```bash
git commit -m "docs: 添加贡献指南和技术文档

- 添加 CONTRIBUTING.md 贡献指南
- 添加 doc/API.md API 参考
- 添加 doc/ARCHITECTURE.md 架构文档
- 添加 doc/CODE_STYLE.md 代码风格指南
- 添加 doc/QUICK_REFERENCE.md 快速参考
- 说明扩展新平台的方法
- 说明添加新硬件信息的方法"
```

### 第七阶段：发布准备

#### 15. 发布准备

```bash
git commit -m "chore: 准备 v1.0.0 发布

- 更新 CHANGELOG.md
- 添加 doc/RELEASE_CHECKLIST.md
- 添加 doc/RELEASE_SUMMARY.md
- 验证所有测试通过
- 验证代码分析通过
- 验证 pub publish dry-run 通过
- 准备发布到 pub.dev"
```

---

## 提交规范

遵循 `.github/COMMIT_CONVENTION.md` 中定义的规范。

### Scope 范围

- `models`: 数据模型
- `api`: Dart API 层
- `windows`: Windows 平台实现
- `android`: Android 平台实现
- `example`: 示例应用
- `docs`: 文档

---

## 执行计划

### 准备工作

1. 确保所有文件已保存
2. 确保测试通过
3. 确保代码分析通过
4. 确保 dry-run 通过

### 执行步骤

```bash
# 1. 初始化 Git 仓库（如果还没有）
git init

# 2. 按照上述方案逐个提交
# 每个提交都应该是独立的、可编译的、测试通过的

# 3. 创建标签
git tag v1.0.0

# 4. 推送到远程仓库
git remote add origin https://github.com/yourusername/hardware_info_kit.git
git push -u origin main
git push origin v1.0.0
```

### 提交分组建议

**方案 A：详细提交（15 个提交）**

按照上述方案逐个提交，展现完整开发过程，适合团队协作和代码审查。

**方案 B：精简提交（约 8 个提交）**

合并相关提交，适合个人项目快速发布：

```bash
1. chore: 项目初始化（合并 1-4）
2. feat(models): 实现数据模型和测试（合并 5-6）
3. feat(windows): 实现 Windows 平台支持（7）
4. feat(android): 实现 Android 平台支持（8）
5. feat(api): 实现 Dart API 和测试（合并 9-10）
6. docs(example): 实现示例应用（合并 11-12）
7. docs: 完善文档（合并 13-14）
8. chore: 准备 v1.0.0 发布（15）
```

---

## 项目特点

### 核心功能

- ✅ 跨平台硬件信息获取（Windows、Android）
- ✅ 8 种硬件信息类型（CPU、内存、GPU、磁盘、电池、网络、操作系统）
- ✅ 类型安全的数据模型
- ✅ 简洁的 API 设计
- ✅ 异步非阻塞调用

### 质量保证

- ✅ 单元测试覆盖
- ✅ 代码分析通过
- ✅ 完整文档覆盖
- ✅ 示例应用演示
- ✅ 平台特定实现

### 设计理念

- 🎯 易用性：简单直观的 API
- 🔧 可扩展：易于添加新平台和新硬件信息
- 📦 模块化：清晰的代码结构
- 🚀 性能：快速信息获取（< 100ms）

---

**总计：15 个提交（详细方案）或 8 个提交（精简方案）**

每个提交都有明确的单一目的，展现了完整的开发过程：

项目初始化 → 数据模型 → 平台实现 → API 层 → 示例应用 → 文档 → 发布准备

---

**准备日期**: 2026-03-08  
**项目**: hardware_info_kit  
**版本**: v1.0.0  
**状态**: 待执行 ✅

## 当前状态

- ✅ 所有代码已完成
- ✅ Windows 和 Android 平台实现完成
- ✅ 文档已完善
- ✅ 示例应用已实现
- ✅ 所有测试通过
- ✅ CI 验证通过
- ✅ 项目更名修复完成
- � 准备执行详细提交方案（15 个提交）
- 📝 当前在 new-main 分支，已完成第 1 个提交
