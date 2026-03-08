# Android 测试指南

## 方案一：构建 APK（推荐）

### 前提条件
1. 安装 Android Studio 或 Android SDK
2. 配置 ANDROID_HOME 环境变量
3. 确保 Flutter 能检测到 Android 工具链

### 构建步骤

```bash
# 1. 进入示例目录
cd example

# 2. 获取依赖
flutter pub get

# 3. 构建 Debug APK
flutter build apk --debug

# 4. 构建 Release APK（可选）
flutter build apk --release
```

构建完成后，APK 文件位于：
- Debug: `example/build/app/outputs/flutter-apk/app-debug.apk`
- Release: `example/build/app/outputs/flutter-apk/app-release.apk`

## 方案二：使用 Android 模拟器

```bash
# 1. 启动 Android 模拟器
flutter emulators --launch <emulator_id>

# 2. 运行应用
cd example
flutter run
```

## 方案三：连接真机测试

```bash
# 1. 启用开发者选项和 USB 调试
# 2. 连接设备
flutter devices

# 3. 运行应用
cd example
flutter run
```

## 测试功能

应用将显示以下硬件信息：

### 操作系统信息
- 系统名称（Android）
- 架构（arm64-v8a, armeabi-v7a 等）
- 计算机名称
- 版本号
- 内核版本

### CPU 信息
- 处理器型号
- 厂商
- 架构
- 逻辑核心数
- 物理核心数
- 频率

### 内存信息
- 总内存
- 可用内存
- 已用内存
- 使用率百分比

### GPU 信息
- 显卡型号
- 厂商
- 显存大小
- 驱动版本

### 磁盘信息
- 总存储空间
- 可用空间
- 已用空间
- 使用率百分比
- 驱动器数量

### 电池信息（如果可用）
- 电量百分比
- 充电状态
- 电池健康状态
- 温度
- 电压

## 故障排查

### 1. Android SDK 未找到
```bash
# 设置环境变量（Windows）
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set PATH=%PATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools

# 或者安装 Android Studio
```

### 2. 构建失败
```bash
# 清理项目
flutter clean
flutter pub get

# 检查 Flutter 配置
flutter doctor
```

### 3. 设备连接问题
```bash
# 检查连接的设备
flutter devices
adb devices

# 重启 ADB
adb kill-server
adb start-server
```

## 预期结果

应用启动后会自动获取硬件信息并显示在卡片式界面中。每个信息类别都有独立的卡片，包含相关的硬件参数。

如果某些信息无法获取，对应的字段会被隐藏或显示为 "N/A"。

## 性能测试

应用包含性能基准测试，可以通过以下方式运行：

```bash
cd benchmark
dart hardware_info_benchmark.dart
```

这将测试各个 API 的响应时间，确保在 100ms 内完成。