# Flutter 一周学习计划

> 基于文章 `https://www.codefather.cn/post/2029156872626810882` 的全部技术栈，压缩为 7 天 intensive 学习。
> 学习者背景：React + Node.js 全栈开发者（可类比加速）
> 目标平台：仅移动端（iOS/Android）
> 工作目录：`e:\flutter`

## 学习者背景映射表（用于类比学习）

| React/Node.js 概念   | Flutter/Dart 对应概念     | 加速点             |
| -------------------- | ------------------------- | ------------------ |
| React 组件 (JSX)     | Widget（一切皆 Widget）   | 组件化思维已具备   |
| useState/useReducer  | setState + StatefulWidget | 状态驱动 UI 已理解 |
| Context API / Redux  | Provider / Riverpod       | 状态管理概念已具备 |
| async/await (JS)     | async/await (Dart)        | 语法几乎一致       |
| Promise              | Future                    | 异步概念一致       |
| Observable/RxJS      | Stream                    | 流式概念一致       |
| fetch / axios        | dio                       | 网络请求模式一致   |
| localStorage         | shared_preferences        | 轻量存储概念一致   |
| IndexedDB / MongoDB  | sqflite / hive            | 数据库概念一致     |
| React Native Flexbox | Row/Column + Flex         | 布局概念高度相似   |
| TypeScript 类型      | Dart 强类型 + 空安全      | 静态类型已理解     |

---

## 当前状态分析

- 工作目录 `e:\flutter` 为空，无任何已有代码

- Flutter SDK 未安装，需从零搭建开发环境

- 操作系统：Windows（需配置 Android 开发环境；iOS 调试需 Mac，本计划以 Android 为主，iOS 概念照搬）

- 学习者已具备组件化、状态管理、异步编程、网络请求等核心概念，可在 1-2 天内快速掌握 Dart 与 Flutter 基础

## 计划总览

| 天数  | 主题                                                | 对应文章阶段                   | Demo 项目                                       |
| ----- | --------------------------------------------------- | ------------------------------ | ----------------------------------------------- |
| Day 1 | 环境搭建 + Dart 基础语法（变量~函数）               | 阶段 1（前半）                 | `dart_basics` 控制台练习                        |
| Day 2 | Dart OOP/异步/集合 + Flutter 基础 + 布局            | 阶段 1（后半）+ 阶段 2（前半） | `dart_basics`（续）+ `hello_flutter` 个人名片页 |
| Day 3 | Flutter 组件进阶 + 路由导航                         | 阶段 2（后半）                 | `navigation_demo` 主从导航 App                  |
| Day 4 | 状态管理（setState + Provider 为主，Riverpod 了解） | 阶段 3                         | `state_management_demo` 计数器对比              |
| Day 5 | 网络请求 + 数据存储 + 第三方库                      | 阶段 4                         | `network_data_demo` 接口缓存 App                |
| Day 6 | 综合实战·天气查询 App（搜索+展示核心链路）          | 阶段 5                         | `weather_app` 核心版                            |
| Day 7 | 综合实战·收藏+完善+原生功能                         | 阶段 5                         | `weather_app` 完整版                            |

---

## Day 1：环境搭建 + Dart 基础语法（变量~函数）

### 学习目标

- 完成 Flutter 开发环境搭建

- 掌握 Dart 基础语法（变量、类型、控制流、函数）

> **注意**：OOP、空安全、泛型等高级语法移至 Day 2。Day 1 优先保证环境搭建顺利，Dart 基础语法对于 JS/TS 开发者可快速过完。

### 环境搭建步骤（上午）

1. 下载 Flutter SDK：访问 `https://docs.flutter.dev/get-started/install/windows/desktop` 下载最新稳定版
2. 解压到 `e:\flutter-sdk`（与工作目录分开，避免污染项目目录）
3. 配置环境变量：将 `e:\flutter-sdk\bin` 加入系统 PATH
4. 安装 Android Studio：`https://developer.android.com/studio`（包含 Android SDK + 模拟器）
5. 安装 VS Code + Flutter 插件 + Dart 插件（推荐用 VS Code 开发）
6. **Android Studio SDK 配置（关键，缺失会导致 flutter doctor 报错）**：
   - 打开 Android Studio → Settings → Languages & Frameworks → Android SDK

   - 安装 **SDK Tools** 中的 **Android SDK Command-line Tools (latest)**（必装，否则无法接受协议）

   - 确认 **Android SDK Platform** 已安装（建议 API 33+）

   - 确认 **JDK 版本**：当前 Flutter 要求 JDK 17，Android Studio 自带 JBR，若系统 JAVA_HOME 指向旧版本需调整

7. **接受 Android 协议**：运行 `flutter doctor --android-licenses`，全部输入 `y` 接受（不做会导致构建失败）
8. 创建 Android 模拟器（AVD）：
   - Android Studio → Device Manager → Create Device → 选择 Pixel 系列

   - **下载系统镜像**：选择 API 33+ 的镜像（推荐 API 34，稳定），首次需下载约 1GB

   - **硬件加速**：确认已开启 Hyper-V / HAXM（Windows 需在 BIOS 开启虚拟化）

   - 启动模拟器确认能开机

9. 运行 `flutter doctor` 检查环境，确保全部通过（如仍有 ✗，按提示逐项修复）

### 知识点学习（下午 + 晚上）

**Dart 基础语法【类比 JS】：**

- 变量与常量：`var` / `final` / `const`（类比 JS 的 let/const，但 final 运行时确定、const 编译时确定）

- 数据类型：`int` `double` `String` `bool` `List` `Map`（类比 JS 的 number/string/boolean/Array/Object，但 Dart 是强类型）

- 运算符：算术、关系、逻辑、空合并 `??`、条件 `?:`

- 控制流：`if` `switch` `for` `while`（与 JS 几乎一致）

- 函数：命名参数 `{}`、位置参数 `[]`、箭头函数 `=>`、默认值

> 如果环境搭建顺利提前完成，可提前开始 Day 2 的 OOP 内容。

### Demo：`dart_basics` 控制台练习

- 路径：`e:\flutter\dart_basics\`

- 创建方式：`dart create dart_basics`

- 练习内容：
  - `bin/variables.dart`：变量、类型、运算符、控制流、函数练习

- 运行验证：`dart run bin/variables.dart`

### 学习资源

- Dart 官方中文文档：`https://dart.cn/`

- DartPad 在线练习：`https://dartpad.dev/`

- 2025 Dart Flutter 入门教程：`https://www.bilibili.com/video/BV15P411P7DN/`

---

## Day 2：Dart OOP + 异步/集合 + Flutter 基础 + 布局

### 学习目标

- 掌握 Dart 面向对象（类、继承、Mixin、泛型）

- 理解 Dart 空安全

- 掌握 Dart 异步编程（Future、async/await、Stream）

- 掌握 Dart 集合操作（map、where、reduce）

- 理解 Flutter 架构与 Widget 树

- 掌握基础组件与布局

### 知识点学习

**上午：Dart OOP + 空安全 + 重要语法【类比 TS class】**

- 类与对象：`class`、构造函数（同名构造、命名构造）、`this`

- 继承：`extends`、`super`、方法重写 `@override`

- Mixin：`with` 关键字（React 无直接对应，类似多继承，用于复用代码）

- 抽象类与接口：`abstract class`、`implements`

- 泛型：`List<T>`、自定义泛型类/函数（类比 TS 泛型）

**空安全【重点，TS 严格模式类似】：**

- 非空类型 `String` vs 可空类型 `String?`

- 空断言 `!`、空合并 `??`、安全调用 `?.`

- `late` 关键字（延迟初始化）

**其他重要语法（补充，高频使用）：**

- `enum` 枚举：状态管理常用（如加载状态 `LoadStatus.loading`、天气类型），Dart 3 支持增强枚举（可带字段和方法）

- `factory` 工厂构造：`factory` 关键字，`fromJson` 必用（返回缓存实例或子类实例），Day 5 网络解析会频繁使用

- `extension` 扩展方法：给已有类型添加方法（类比 JS 原型扩展但更安全），如 `extension StringX on String { ... }`

- `typedef` 函数类型别名：定义回调类型（类比 TS 的 `type Callback = (x) => void`），用于自定义 Widget 的 onChange/onPressed 参数

**下午：Dart 异步 + 集合 + Flutter 基础**

**Dart 异步【类比 JS Promise/async-await】：**

- `Future`：类比 Promise，`Future.then()` 类比 `.then()`

- `async/await`：语法与 JS 几乎一致

- `Stream`：类比 RxJS Observable，用于连续数据流（了解概念即可，实战中用得少）

- `async*` 生成器函数：配合 Stream 使用，`yield` 产出数据

- 错误处理：`try/catch`、`Future.catchError`

**Dart 集合【类比 JS 数组方法】：**

- `List`：类比 Array

- `map` → 类比 `Array.map`

- `where` → 类比 `Array.filter`

- `reduce`/`fold` → 类比 `Array.reduce`

- `Set`：去重集合

- `Map`：类比 Object/Map

**Flutter 基础概念：**

- Flutter 架构：Framework → Engine → Embedder

- Widget 树：一切皆 Widget，通过嵌套组合 UI（类比 React 组件树）

- `StatelessWidget`：无状态，类比 React 函数组件（纯展示）

- `StatefulWidget`：有状态，类比带 useState 的组件

- `build()` 方法：类比 React 的 render/return JSX

**基础组件：**

- `Text`：文本（类比 `<Text>`）

- `Image`：图片（`Image.network`/`Image.asset`）

- `Icon`：图标

- `Container`：类比 `<div>`，可设 padding/margin/color/decoration

- `Padding` / `Center`：布局辅助

- `Row` / `Column`：类比 React Native 的 Flexbox（横向/纵向）

- `Stack`：类比 CSS `position: relative/absolute`，层叠布局

- `ListView` / `GridView`：列表/网格（类比 FlatList）

- `ElevatedButton` / `TextButton` / `IconButton`：按钮

**布局（快速了解，Day 3 深入）：**

- `Flex` 布局：主轴/交叉轴（类比 Flexbox）

- `Expanded` / `Flexible`：弹性占比（类比 `flex: 1`）

- `Align` / `Positioned`：对齐与绝对定位

**Material 脚手架与交互组件（补充）：**

- `MaterialApp` + `Scaffold`：App 骨架，提供 AppBar / Drawer / BottomNavigationBar / FloatingActionButton（FAB）

- `SafeArea`：**移动端必备**，处理刘海屏/状态栏/底部导航条遮挡（类比 React Native 的 SafeAreaView）

- `SingleChildScrollView`：内容溢出滚动（表单页常用，类比 overflow: auto）

- `InkWell` / `GestureDetector`：点击交互（类比 onClick），InkWell 带水波纹效果

- `ClipRRect` / `ClipOval`：圆角/圆形裁剪（头像场景必用，类比 border-radius / border-radius: 50%）

- `Hero`：路由共享元素动画（详情页大图过渡，类比 React Native 的共享元素动画）

- `Divider` / `Spacer` / `Tooltip`：辅助组件

### Demo 1：`dart_basics`（续，下午先完成）

- 路径：`e:\flutter\dart_basics\`

- 练习内容（在 Day 1 的 `dart_basics` 项目中补充）：
  - `bin/oop.dart`：定义一个 Animal 类 + Dog 子类 + FlyMixin，演示继承和 Mixin

  - `bin/null_safety.dart`：可空类型、空合并、late 的使用

  - `bin/generics.dart`：实现一个泛型 Stack 栈类

  - `bin/async_demo.dart`：Future、async/await、Stream 练习

- 运行验证：`dart run bin/oop.dart` 等

### Demo 2：`hello_flutter` 个人名片页

- 路径：`e:\flutter\hello_flutter\`

- 创建方式：`flutter create hello_flutter`

- 练习内容：
  - `lib/main.dart`：入口，MaterialApp + Scaffold 脚手架

  - `lib/widgets/profile_card.dart`：个人名片（头像 + 姓名 + 简介，用 Container/Row/Column）

  - `lib/widgets/skills_list.dart`：技能列表（ListView 展示技能项）

  - `lib/widgets/stat_grid.dart`：数据网格（GridView 展示 GitHub star/follow 等）

  - 练习 `StatelessWidget` 写静态页面，熟悉 Widget 嵌套

- 运行验证：`flutter run`（在模拟器中查看效果，体验热重载）

### 学习资源

- Dart 官方中文文档：`https://dart.cn/`

- Flutter 官方中文文档：`https://docs.flutter.cn/`

- 黑马程序员 Flutter 教程：`https://www.bilibili.com/video/BV1wR4Xz6EqG`

---

## Day 3：Flutter 组件进阶 + 路由导航

### 学习目标

- 掌握交互组件与表单

- 掌握路由导航（Navigator、传参、命名路由）

- 能独立开发多页面 App

### 知识点学习

**交互组件：**

- `TextField` / `TextFormField`：表单输入（类比 `<input>`）

- `Switch` / `Checkbox` / `Radio`：选择控件

- `Slider` / `DatePicker` / `TimePicker`：滑块/日期/时间选择

- `AlertDialog` / `SnackBar`：弹窗与提示

- `DropdownButton`：下拉选择

**路由导航：**

- `Navigator.push` / `Navigator.pop`：类比 React Router 的导航

- `MaterialPageRoute`：页面切换动画

- 路由传参：构造函数传参 / `settings.arguments`

- 命名路由：`'/detail'` 路由表（类比 React Router `path`）

- `onGenerateRoute`：动态路由生成

- 返回数据：`Navigator.pop(context, result)`

### Demo：`navigation_demo` 主从导航 App

- 路径：`e:\flutter\navigation_demo\`

- 创建方式：`flutter create navigation_demo`

- 练习内容：
  - `lib/main.dart`：入口 + 命名路由配置

  - `lib/pages/home_page.dart`：列表页，展示多条数据，点击跳转详情

  - `lib/pages/detail_page.dart`：详情页，接收参数展示内容，可返回数据

  - `lib/pages/search_page.dart`：搜索页，含 TextField 输入搜索

  - `lib/pages/form_page.dart`：表单页，练习 Switch/Checkbox/Slider/DatePicker

  - 练习路由 push/pop/传参/命名路由/返回数据

- 运行验证：`flutter run`，测试页面跳转与传参

---

## Day 4：状态管理（聚焦 setState + Provider）

### 学习目标

- 理解 Flutter 状态管理思想（类比 React 状态管理）

- **掌握** setState（局部状态）

- **掌握** Provider（官方推荐，全局状态）— 本日重点

- **了解** Riverpod（Provider 升级版，知道优势和基本用法即可）

- **浏览了解** GetX、Bloc（知道思想即可，不要求手写代码）

### 知识点学习

**setState【类比 useState】：**

- `StatefulWidget` 的 `setState()` 触发重建（类比 React 的 setState 触发 re-render）

- 适用场景：简单局部状态

**Provider【类比 Context API，官方推荐，本日重点】：**

- `ChangeNotifier`：被观察的状态容器（类比 React Context value + useReducer）

- `ChangeNotifierProvider`：在 Widget 树注入状态（类比 Context.Provider）

- `Consumer` / `context.watch` / `context.read`：消费状态（类比 useContext）

- `MultiProvider`：多状态注入

**Riverpod【Provider 升级版，类比 Redux Toolkit】（了解）：**

- `Provider` / `StateProvider` / `StateNotifierProvider` / `FutureProvider` / `StreamProvider`

- `ref.watch` / `ref.read`

- 优势：编译时安全、不依赖 BuildContext、易于测试

**GetX【一站式方案】（浏览了解，跳过代码）：**

- 状态管理 + 路由 + 依赖注入 + 国际化

- `.obs` / `GetxController` / `GetBuilder`

- `Get.to()` / `Get.back()` 路由

**Bloc【类比 Redux，基于 Stream】（浏览了解，跳过代码）：**

- `Cubit` / `Bloc` + `Event` + `State`

- `BlocProvider` / `BlocBuilder`

- 思想：事件 → 状态（单向数据流）

### Demo：`state_management_demo` 计数器对比

- 路径：`e:\flutter\state_management_demo\`

- 创建方式：`flutter create state_management_demo`

- 练习内容：
  - `lib/setstate/counter_setstate.dart`：用 setState 实现计数器（+/-/重置）**【必写】**

  - `lib/provider/counter_provider.dart`：用 ChangeNotifier + Provider 实现同功能 **【必写，重点】**

  - `lib/riverpod/counter_riverpod.dart`：用 Riverpod 实现同功能 **【必写，对比 Provider 差异】**

  - `lib/main.dart`：TabBar 切换查看三种方案实现，体会差异

  - 进阶（推荐）：加一个 Todo 列表（增删改查），用 Provider 实现，体会状态管理在复杂场景的价值

- 依赖：`provider` `flutter_riverpod`

- 运行验证：`flutter run`，对比 3 种方案的代码差异

- **不要求手写的方案**：GetX 和 Bloc 仅阅读官方文档示例代码，理解其设计思想即可，不在 Demo 中实现。

### 学习资源

- Provider 文档：`https://pub.dev/packages/provider`

- Riverpod 文档：`https://riverpod.dev/`

- GetX 文档：`https://pub.dev/packages/get`

---

## Day 5：网络请求 + 数据存储 + 第三方库

### 学习目标

- 掌握 dio 网络请求与封装（类比 axios）

- 掌握 JSON 解析与数据模型

- 掌握本地存储方案

- 了解常用第三方库

### 知识点学习

**网络请求：**

- `dio` 库（推荐，类比 axios）：
  - GET/POST/PUT/DELETE

  - BaseOptions 配置、拦截器（Interceptor，类比 axios.interceptors）

  - 文件上传/下载、超时、错误处理

- `http` 库（官方基础库，功能简单）

- JSON 解析：`jsonDecode` / `jsonEncode` + `fromJson`/`toJson` 工厂构造

- 数据模型：用 `json_serializable` / `freezed` 生成模型代码（可选）

- 网络请求封装：单例封装 Dio，统一拦截器处理 token/错误/log

**工程化配置（补充）：**

- `pubspec.yaml` 详解：
  - `dependencies`（生产依赖）vs `dev_dependencies`（开发依赖）

  - 版本约束语法：`^1.0.0`（兼容更新，类比 npm `^`）/ `any`（任意版本，慎用）/ 精确版本

  - `assets` 声明：图片/字体/JSON 文件路径，必须在此声明才能在代码中使用（类比 webpack 静态资源声明）

  - `fonts` 引入：自定义字体族配置

- 资源管理：图片放 `assets/images/`、字体放 `assets/fonts/`、访问用 `rootBundle.loadString('assets/xxx.json')`

- 代码生成工具（网络/状态管理常用）：
  - `build_runner`：代码生成运行器

  - `json_serializable`：自动生成 fromJson/toJson（手写易错，推荐用）

  - `freezed`：生成不可变数据类 + copyWith + union（Riverpod 配合最佳）

  - 运行命令：`dart run build_runner build`（一次性）/ `dart run build_runner watch`（监听自动生成）

- 多环境配置：`--dart-define=ENV=prod` + `String.fromEnvironment('ENV')` 区分 dev/prod

**数据存储：**

- `shared_preferences`：轻量 KV 存储（类比 localStorage），存配置/Token

- `sqflite`：SQLite 关系型数据库（类比 IndexedDB），结构化数据

- `hive`（推荐）：NoSQL 高性能本地数据库，存对象无需序列化

**第三方库：**

- `cached_network_image`：图片缓存加载（类比 react-native-fast-image）

- `pull_to_refresh` / `easy_refresh`：下拉刷新/上拉加载

- `webview_flutter`：内嵌 WebView（类比 iframe）

- `pub.dev`：Flutter 包仓库（类比 npm）

### Demo：`network_data_demo` 接口缓存 App

- 路径：`e:\flutter\network_data_demo\`

- 创建方式：`flutter create network_data_demo`

- 练习内容：
  - `lib/api/dio_client.dart`：封装 Dio 单例（BaseOptions + 拦截器）

  - `lib/api/api_service.dart`：定义接口方法（用 `https://jsonplaceholder.typicode.com` 测试 API）

  - `lib/models/post.dart`：Post 数据模型 + fromJson/toJson

  - `lib/pages/post_list_page.dart`：列表页，dio 请求 + ListView 展示 + 下拉刷新

  - `lib/pages/post_detail_page.dart`：详情页，展示单条 Post 详情

  - `lib/storage/local_storage.dart`：用 hive 缓存列表数据，离线可查看

  - `lib/storage/prefs.dart`：用 shared_preferences 存主题切换偏好

  - 练习：网络请求 → JSON 解析 → 模型转换 → 列表展示 → 本地缓存

- 依赖：`dio` `hive` `shared_preferences` `cached_network_image` `easy_refresh`

- 运行验证：`flutter run`，测试联网/断网场景的缓存表现

### 测试与调试（补充，贯穿全程）

**测试：**

- `flutter test`：单元测试与 Widget 测试

- 单元测试：`test/xxx_test.dart`，测纯 Dart 逻辑（如 fromJson、Provider 状态变化）

- Widget 测试：`testWidget('xxx', (tester) async { await tester.pumpWidget(...); })`，测 Widget 渲染与交互

- 建议：给天气 App 的 `weather.dart` 模型和 `weather_provider.dart` 各写 1-2 个测试用例

**调试工具：**

- `flutter analyze`：静态分析（类比 ESLint），检测未使用变量、空安全、类型错误，建议每次提交前运行

- DevTools（`flutter pub global activate devtools` 或运行时按 D）：
  - **Performance**：帧率/重建分析（类比 Chrome Performance 面板）

  - **Memory**：内存泄漏检测

  - **Network**：Dio 请求抓包（类比 Chrome Network）

  - **Widget Inspector**：可视化 Widget 树（类比 React DevTools）

- 日志输出区别：
  - `print()`：生产环境也输出，慎用

  - `debugPrint()`：仅 debug 模式，带节流（避免刷屏）

  - `dart:developer` 的 `log()`：结构化日志，DevTools 友好展示

### 学习资源

- dio 文档：`https://pub.dev/packages/dio`

- hive 文档：`https://pub.dev/packages/hive`

---

## Day 6：综合实战·天气查询 App（搜索+展示核心链路）

### 学习目标

- 综合运用 Flutter + Provider + dio + hive

- 完成天气查询 App 核心链路：**搜索城市 → 展示天气**

- 串联前 5 天所有知识点

### 项目规划

- 路径：`e:\flutter\weather_app\`

- 创建方式：`flutter create weather_app`

- 技术栈：Flutter + Provider（状态管理）+ dio（网络）+ hive（本地存储）+ cached_network_image

- API：和风天气免费版 `https://dev.qweather.com/`（需注册获取 API Key）或 OpenWeatherMap `https://openweathermap.org/api`
  - 推荐 OpenWeatherMap（注册简单，免费额度充足）：`https://api.openweathermap.org/data/2.5/weather?q={city}&appid={key}&units=metric&lang=zh_cn`

### Day 6 范围：搜索 → 展示（不含收藏）

**本期完成的功能：**

1. 城市搜索：输入城市名，调用 API 查询天气
2. 天气详情：温度、天气状况、湿度、风速、图标
3. 错误处理：网络错误/城市不存在提示（基础版）

**本期不做的功能（移至 Day 7）：**

- 城市收藏、多城市切换、搜索历史
- 天气预报、城市联想输入、单位切换

### 文件结构

```
weather_app/
├── lib/
│   ├── main.dart                    # 入口 + MultiProvider 注入
│   ├── api/
│   │   ├── dio_client.dart          # Dio 单例封装
│   │   └── weather_api.dart         # 天气接口方法
│   ├── models/
│   │   └── weather.dart             # 天气数据模型 + fromJson
│   ├── providers/
│   │   └── weather_provider.dart    # 天气状态（ChangeNotifier）
│   ├── pages/
│   │   ├── home_page.dart           # 首页：搜索框 + 天气展示
│   │   └── search_page.dart         # 搜索页：城市搜索输入
│   ├── widgets/
│   │   ├── weather_card.dart        # 天气信息卡片
│   │   └── weather_icon.dart        # 天气图标展示
│   └── utils/
│       └── date_format.dart         # 日期格式化工具
└── pubspec.yaml                     # 依赖配置
```

### Day 6 具体任务

- 上午（3h）：
  1. 创建项目，配置 `pubspec.yaml` 依赖
  2. 注册 OpenWeatherMap API Key（如注册不顺利，先用本地 Mock 数据跑通流程，见下方备选方案）
  3. 实现 `dio_client.dart` + `weather_api.dart`
  4. 实现 `weather.dart` 数据模型 + fromJson

- 下午（3h）：
  1. 实现 `weather_provider.dart`（当前天气状态 + 加载/错误状态）
  2. 实现 `home_page.dart`（搜索框 + 天气展示 UI）
  3. 实现 `weather_card.dart` + `weather_icon.dart` 等子组件

- 晚上（2h）：
  1. 实现 `search_page.dart`（城市搜索输入 + 调用 API）
  2. 串联完整流程：输入城市名 → 调用 API → 展示天气
  3. 基础错误处理：网络失败/城市不存在 toast 提示

- 运行验证：`flutter run`，测试搜索 → 展示天气完整链路

### API 备选方案（如 OpenWeatherMap 注册不顺利）

在 `assets/mock/weather.json` 放一份 Mock 数据，Provider 中先返回 Mock 数据跑通 UI 和状态逻辑：

```json
{
  "weather": [{ "main": "Clear", "description": "晴" }],
  "main": { "temp": 26.5, "humidity": 55, "pressure": 1013 },
  "wind": { "speed": 3.2 },
  "name": "北京"
}
```

> **原则**：API 不是核心，Provider + UI 才是。API 有问题就用 Mock 数据，不阻塞学习进度。

---

## Day 7：综合实战·收藏+完善+原生功能

### 学习目标

- 完成天气 App 收藏功能（hive 持久化 + 多城市切换）

- 完善天气 App（UI 打磨、错误处理、加载态、空状态、下拉刷新）

- 集成原生功能（定位，可选）

### 上午：收藏功能 + 完善（2-3h）

**收藏功能（Day 6 遗留，优先完成）：**

- 实现 `city.dart` 城市数据模型

- 实现 `hive_storage.dart`（hive 初始化 + CRUD 封装）

- 实现 `city_provider.dart`（收藏城市状态管理：添加/删除/切换当前城市）

- 实现 `city_list_page.dart`（收藏城市列表 + 点击切换）

- 在 `home_page.dart` 添加收藏按钮 → 调用 city_provider 添加/移除

**完善：**

- 加载态：`LoadingWidget`（CircularProgressIndicator / 自定义骨架屏）

- 错误态：网络错误/城市不存在的友好提示 + 重试按钮

- 空状态：无收藏城市时的引导页（`empty_state.dart`）

- UI 打磨：天气图标动画、卡片圆角阴影、主题色配置

- 下拉刷新：集成 `easy_refresh`

- 图片缓存：天气图标用 `cached_network_image`

### 下午：原生功能集成（2-3h）

- **定位功能**（geolocator 库）：
  - 依赖：`geolocator` + `geocoding`

  - 获取当前定位 → 反查城市名 → 自动查询天气

  - 练习权限申请（AndroidManifest.xml 配置权限）

- **天气图标**（可选）：
  - 用 `flutter_weather_icons` 或自定义 Icon 展示不同天气

- **进阶功能（选做，时间充裕再尝试）：**
  - 天气预报：未来 3-5 天预报
  - 搜索历史：hive 缓存最近搜索
  - 单位切换：°C/°F 切换

- **推送通知**（可选，时间紧可跳过）：
  - `flutter_local_notifications` 本地通知

- **主题切换（补充）：**
  - `ThemeData`：配置亮色/暗色主题（`ThemeData.light()` / `ThemeData.dark()`）

  - `ThemeMode`：在 `MaterialApp` 的 `themeMode` 控制，配合 shared_preferences 持久化

  - 自定义颜色：`ColorScheme`（Flutter 3+ 推荐，类比 CSS 变量）

- 性能优化实践：
  - `const` 构造函数减少重建

  - `Provider` 精细划分，避免大范围 rebuild

  - `ListView.builder` 懒加载长列表

  - `RepaintBoundary` 隔离重绘区域

### 最终验证

- 天气 App 完整功能跑通：搜索 → 展示 → 收藏 → 切换 → 定位 → 下拉刷新

- 在 Android 模拟器上无崩溃运行

- 5 个 Demo 项目均可运行：`dart_basics` `hello_flutter` `navigation_demo` `state_management_demo` `network_data_demo`

### 打包发布（补充，可选）

- **打包 APK**：
  - `flutter build apk --release`：生成 release APK（位于 `build/app/outputs/flutter-apk/app-release.apk`）

  - `flutter build apk --split-per-abi`：按 CPU 架构分包（体积更小，推荐）

  - `flutter build appbundle`：生成 AAB（Google Play 上架格式）

- **签名配置**（发布必做）：
  - 用 `keytool` 生成签名 keystore：`keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`

  - 创建 `android/key.properties`（存 keystore 密码，**加入 .gitignore**）

  - 修改 `android/app/build.gradle` 引用 keystore，配置 `signingConfigs.release`

  - 参考官方文档：`https://docs.flutter.cn/deployment/android`

- **版本管理**：在 `pubspec.yaml` 的 `version: 1.0.0+1` 控制（`+` 后为构建号，每次发布递增）

---

## 假设与决策

### 假设

1. 用户使用 Windows 系统，以 Android 开发为主（iOS 调试需 Mac，本计划暂不涉及 iOS 真机调试，但代码逻辑通用）
2. 用户每天可投入 7-8 小时学习时间（上午 3h + 下午 3h + 晚上 2h）
3. OpenWeatherMap 免费 API Key 可正常注册和使用（国内网络可访问）
4. Flutter SDK 安装过程中无重大网络障碍（如遇国内网络问题，配置 `PUB_HOSTED_URL` 和 Flutter 镜像）

### 决策

1. **状态管理主推 Provider**：文章官方推荐，学习曲线平缓，与 React Context 概念一致。Day 4 聚焦 **setState + Provider**，Riverpod 作为了解对比。GetX 和 Bloc 仅浏览文档了解设计思想，**不在 Demo 中实现**，避免贪多嚼不烂。
2. **网络库主用 dio**：文章推荐，与 axios 概念一致，功能强大。
3. **本地存储主用 hive**：文章推荐，NoSQL 高性能，无需序列化，学习成本低。
4. **实战项目选天气查询 App**：用户确认，且能覆盖网络请求、状态管理、本地存储、列表渲染全部知识点。
5. **Dart 学习跨 Day 1 + Day 2**：Day 1 主攻基础语法（变量~函数），Day 2 上午完成 OOP + 空安全。利用 JS/TS 语法相似性加速，但不过度压缩导致基础不牢。
6. **目录结构**：所有 Demo 项目放在 `e:\flutter\` 下平级，每个独立一个 Flutter 项目，便于管理和运行。

## 每日学习节奏建议

| 时段 | 时间        | 内容                             |
| ---- | ----------- | -------------------------------- |
| 上午 | 9:00-12:00  | 知识点学习（看文档/视频 + 跟练） |
| 下午 | 14:00-17:00 | Demo 编码实践                    |
| 晚上 | 19:00-21:00 | 巩固练习 + 查漏补缺              |

## 关键命令速查

```powershell
# 环境检查
flutter doctor

# 创建 Dart 项目
dart create dart_basics

# 创建 Flutter 项目
flutter create hello_flutter

# 运行项目（在项目目录下）
flutter run

# 运行指定设备
flutter devices          # 查看可用设备
flutter run -d <device_id>

# 添加依赖
flutter pub add provider dio hive

# 获取依赖
flutter pub get

# 运行 Dart 文件
dart run bin/xxx.dart

# 热重载（运行时按 r）
# 热重启（运行时按 R）
```

## 国内镜像配置（如遇网络问题）

```powershell
# PowerShell 临时配置
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

# 永久配置（写入环境变量）
# PUB_HOSTED_URL = https://pub.flutter-io.cn
# FLUTTER_STORAGE_BASE_URL = https://storage.flutter-io.cn
```

## 风险与应对

| 风险                               | 应对                                                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| 环境搭建卡住（Android SDK/模拟器） | Day 1 全天预留给环境搭建，Dart 基础只要求晚上学完变量~函数即可；优先用 VS Code + Android 模拟器，避免真机调试复杂度       |
| Dart OOP/空安全不熟导致进度慢      | 类比 TS class 学习，重点学差异点（Mixin、命名构造、空安全）；Day 2 上午集中攻克                                           |
| 状态管理概念多学不完               | 主攻 setState + Provider；Riverpod 对比了解；GetX/Bloc 只读文档不写代码，坚决不贪多                                       |
| API 注册/网络问题                  | OpenWeatherMap 国内可访问，备选和风天气；**Day 6 预置 Mock JSON 数据方案**，API 不通就先用 Mock 跑通 Provider + UI 全流程 |
| 一周时间不够                       | 核心目标：Day 1-5 基础打牢 + Day 6 搜索展示链路跑通；收藏/定位/进阶功能可后置                                             |
