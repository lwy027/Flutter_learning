# Day 1 知识点汇总：环境搭建 + Dart 基础语法

> 学习日期：2026-07-06
> 项目目录：`e:\flutter\dart_basics\`
> 运行命令：`dart run bin/variables.dart`

---

## 一、环境搭建

### 1.1 Flutter SDK 安装

- **作用**：Flutter SDK 提供 `flutter` 和 `dart` 命令行工具，是所有开发的起点。类比 Node.js 之于 React 开发。
- **版本**：Flutter 3.44.4 + Dart 3.12.2
- **安装路径**：`e:\flutter-sdk\flutter`
- **关键配置**：
  - PATH 环境变量加 `e:\flutter-sdk\flutter\bin`
  - 国内镜像变量（加速 pub 包下载）：
    ```
    PUB_HOSTED_URL = https://pub.flutter-io.cn
    FLUTTER_STORAGE_BASE_URL = https://storage.flutter-io.cn
    ```

### 1.2 Android SDK + 模拟器

- **Android SDK**：类比浏览器引擎，提供 Android 系统库
- **Android Studio**：SDK 的图形化管理器 + 模拟器管理器
- **Command-line Tools**：flutter 依赖命令行版 `sdkmanager` 来做自动化操作
- **模拟器（AVD）**：虚拟 Android 手机，设备 ID `emulator-5554`，API 35 (Android 15)

### 1.3 踩坑记录

- `cmdline-tools/latest` 目录嵌套结构错误（`latest\cmdline-tools\` 而非 `latest\bin\`），需重命名修复
- `flutter.bat.lock` 残留问题：用 `dart.exe` 直接调用 `flutter_tools.snapshot` 绕过
- 国内网络必须配置镜像变量，否则 `flutter pub get` 会超时

---

## 二、变量与常量

### 核心概念

Dart 声明变量有 4 种方式，关键是 `final` 和 `const` 的区别——这是 Dart 与 JS 最大的差异点之一。

### 类比映射

| Dart | JS 对应 | 何时用 |
|------|---------|--------|
| `var name = 'Tom'` | `let name = 'Tom'` | 局部变量，类型由推断确定后锁定 |
| `String name = 'Tom'` | `let name: string = 'Tom'` | 显式指定类型（类似 TS） |
| `final name = 'Tom'` | `const name = 'Tom'` | 运行时常量，赋值后引用不可变 |
| `const name = 'Tom'` | 无直接对应 | 编译时常量，值在编译时就必须确定 |

### 差异陷阱（重点）

**Dart 的 `const` vs JS 的 `const` 完全不同！**

```dart
// JS 的 const：引用不变即可，对象内部可变
const arr = [1, 2, 3];
arr.push(4);  // ✅ JS 允许

// Dart 的 const：整个对象必须是编译时不可变的
const arr = [1, 2, 3];
arr.add(4);  // ❌ Dart 报错，const List 不可变

// Dart 的 final：引用不可变，但对象内部可变（类似 JS 的 const）
final arr = [1, 2, 3];
arr.add(4);  // ✅ Dart 允许，final 只锁引用不锁内容
```

**关键区别**：
- `final` = **运行时**确定值，赋值后**引用**不可变（对象内部可变）
- `const` = **编译时**就必须确定值，整个对象**深度不可变**

```dart
final now = DateTime.now();  // ✅ 运行时才知道时间
const now = DateTime.now();  // ❌ 编译时无法确定，报错
```

### Flutter 场景预告

后面写 Flutter 时，`const` 极其重要——**`const Widget` 不会被重建**，是性能优化的关键。这也是为什么 Flutter 代码里到处都是 `const` 前缀。

---

## 三、数据类型

### 核心概念

Dart 是**强类型语言**（类比 TypeScript），所有类型在编译时检查。JS 是弱类型，Dart 的类型系统更严格。

### 类型对照

| Dart | JS 对应 | 差异 |
|------|---------|------|
| `int` / `double` | `number` | Dart 拆分为整数和浮点两个类型 |
| `String` | `string` | 首字母大写，单双引号都行 |
| `bool` | `boolean` | 只有 `true`/`false`，**无 truthy/falsy** |
| `List<T>` | `Array` | 强类型泛型 |
| `Map<K,V>` | `Object` / `Map` | 键值对，键值都有类型 |
| `Set<T>` | `Set` | 去重集合 |
| `null` | `null`/`undefined` | Dart 只有 `null`，无 `undefined` |

### 差异陷阱

#### 1. 数字类型拆分

Dart 把 JS 的 `number` 拆成 `int` 和 `double`，不会自动转换：

```dart
double d = 3.7;
int i = d.toInt();       // 必须显式转换 → 3
int rounded = d.round(); // 四舍五入 → 4
```

#### 2. 无 truthy/falsy（重大陷阱）

```dart
// JS 中 if (0) / if ('') / if (null) 都是 false
// Dart 中必须显式判断，条件必须是 bool

String maybeEmpty = '';
if (maybeEmpty.isEmpty) { ... }  // ✅ 显式判断
// if (maybeEmpty) { ... }       // ❌ 编译报错
```

#### 3. 字符串插值

```dart
// Dart 用 $variable 或 ${expression}
String s = 'hello';
String greeting = '$s ${s.toUpperCase()}!';
// 等价于 JS 的 `${s} ${s.toUpperCase()}!`

// 多行字符串用三个引号（类比 JS 反引号）
String multi = '''
第一行
第二行''';
```

#### 4. 空安全（Day 2 详讲）

```dart
String notNull = 'hello';
// notNull = null;  // ❌ 默认非空类型不能赋 null

String? nullable = null;  // ✅ 加 ? 表示可空
```

### Flutter 场景预告

- `List` 和 `Map` 在 Flutter 里极其常用——`ListView` 的数据源、JSON 解析结果
- `String?` 空安全是网络请求返回数据处理的核心（API 返回可能为 null 的字段）

---

## 四、运算符

### 核心概念

算术/关系/逻辑运算符与 JS 基本一致。Dart 的重点在**空相关运算符**——这是空安全语言的核心，JS 中用得少但 Dart 中无处不在。

### 与 JS 一致的运算符

- 算术：`+ - * / %`
- 关系：`> < >= <= == !=`
- 逻辑：`&& || !`
- 三元：`condition ? a : b`

### Dart 特有运算符（重点）

#### 1. 整除 `~/`

```dart
int a = 10, b = 3;
print(a ~/ b);  // 3（整除，JS 需用 Math.floor(a/b)）
print(a / b);   // 3.333...（普通除法，结果是 double）
```

#### 2. 空合并 `??`（⭐ 最常用）

**作用**：左侧为 null 时取右侧的值（类比 JS 的 `value ?? defaultValue`，但 Dart 中用得更频繁）

```dart
String? username;
String displayName = username ?? '匿名用户';
// username 为 null → displayName = '匿名用户'

username = 'Alice';
displayName = username ?? '匿名用户';
// username 非 null → displayName = 'Alice'
```

**Flutter 场景**：网络请求返回的字段可能为 null，用 `??` 给默认值：
```dart
Text(user.nickname ?? user.username)  // 昵称为空就显示用户名
```

#### 3. 安全调用 `?.`（类比 TS 可选链）

**作用**：左侧为 null 时整个表达式为 null，不抛错

```dart
String? name;
int? len = name?.length;  // name 为 null → len = null

name = 'Bob';
len = name?.length;       // name 非 null → len = 3
```

#### 4. 空断言 `!`

**作用**：告诉编译器"我确定它非 null"，把 `String?` 强转为 `String`

```dart
String? maybeName = 'Carol';
int len = maybeName!.length;  // ! 表示"我保证非 null"

// ⚠️ 谨慎用：如果 maybeName 实际是 null，运行时抛 NullPointerException
// 类比 TS 的非空断言 !，但 Dart 运行时会检查
```

#### 5. 级联 `..`（Dart 特有，JS 无对应）

**作用**：对同一对象连续操作，返回对象本身（比链式调用更通用）

```dart
List<int> nums = [];
nums
  ..add(1)
  ..add(2)
  ..add(3);
```

### 差异总结

| 运算符 | JS | Dart | 备注 |
|--------|----|------|------|
| `~/` | 无 | ✅ 整除 | JS 用 Math.floor |
| `??` | ✅ ES2020 | ✅ 更常用 | 空合并 |
| `?.` | ✅ ES2020 | ✅ 更常用 | 安全调用 |
| `!` | TS 有 | ✅ 运行时检查 | 空断言 |
| `..` | 无 | ✅ 特有 | 级联 |

---

## 五、控制流

### 核心概念

`if/else`、`for`、`while`、`switch` 与 JS 几乎完全一致。差异点主要是**条件必须是 bool**（无 truthy/falsy）。

### 与 JS 一致的部分

```dart
// if-else
if (age >= 18) { ... } else { ... }

// for 循环
for (int i = 0; i < 3; i++) { ... }

// for-in（类比 JS 的 for...of）
for (var color in colors) { ... }

// while / do-while
while (n > 0) { ... }

// break / continue
```

### 差异陷阱

#### 1. 条件必须是 bool（无 truthy/falsy）

```dart
// ❌ JS 可以，Dart 报错
if (0) { ... }
if ('') { ... }
if (null) { ... }
if (list.length) { ... }  // 即使 length 是 int 也不行

// ✅ Dart 必须显式
if (count == 0) { ... }
if (s.isEmpty) { ... }
if (x == null) { ... }
if (list.isNotEmpty) { ... }
```

#### 2. switch 支持模式匹配（Dart 3+）

**示例代码**（[variables.dart#L237-238](file:///e:/flutter/dart_basics/bin/variables.dart#L237-L238)）：
```dart
// switch（Dart 3 支持模式匹配，比 JS 更强大）
String weather = 'sunny';  // 示例数据，传给下面的 switch 演示分支

switch (weather) {
  case 'sunny': print('晴天'); break;
  case 'rainy': print('下雨'); break;
  default: print('未知');
}
```

**什么是模式匹配？**
- JS 的 switch 只能做**值匹配**：`case 'sunny':`
- Dart 3 的 switch 还能做**结构匹配**：解构对象、匹配类型、加条件守卫

```dart
// Dart 3 模式匹配示例（高级用法，Day 2+ 详讲）
switch (user) {
  case Admin(name: var n): print('管理员 $n');  // 解构+类型匹配
  case User(name: var n) when n.length > 10: print('长名用户');  // 条件守卫
}
```

**变量声明差异**：
- Dart：`String weather = 'sunny'`（显式类型，首字母大写 `String`）
- JS：`let weather = 'sunny'`（类型推断）
- TS：`let weather: string = 'sunny'`（类似 Dart，但关键字小写 `string`）

### 移动端场景预告

Flutter 中 `if` 常用于**条件渲染**（类比 React 的 `{cond && <Comp />}`）：
```dart
if (isLoading)
  CircularProgressIndicator()
else
  Text('加载完成')
```

---

## 六、函数

### 核心概念

Dart 函数比 JS 灵活：除了基本函数和箭头函数，还有**命名参数**和**位置参数**——这是 React 开发者最容易理解的特性，因为命名参数就像 React 的 props。

### 与 JS 一致的部分

```dart
// 基本函数（加类型注解）
int add(int a, int b) {
  return a + b;
}

// 箭头函数（类比 JS 的 =>）
int multiply(int a, int b) => a * b;

// 匿名函数（类比 JS 箭头函数）
var square = (int x) => x * x;

// 高阶函数（函数是一等公民）
[1, 2, 3].forEach((item) { print(item); });
```

### Dart 特有：命名参数 `{}`（⭐ 重点）

**作用**：调用时用参数名传递，顺序无关，可读性好。**类比 React 的 props**。

```dart
void greet({String? name, int? age}) {
  print('你好，${name ?? '匿名'}，年龄 ${age ?? '未知'}');
}

// 调用时用参数名（顺序可换）
greet(name: 'Alice', age: 25);
greet(age: 30, name: 'Bob');  // ✅ 顺序无关
greet();                       // 都可省略（因为有 ?）
```

#### required（必填命名参数）

```dart
void createProfile({
  required String username,    // 必填（类比 TS 必填 props）
  String avatar = 'default.png', // 默认值
  int age = 0,
}) { ... }

createProfile(username: 'tom');  // ✅ username 必传
// createProfile();              // ❌ 缺 username 报错
```

### Dart 特有：位置参数 `[]`

**作用**：可选参数按位置传递，省略时用默认值。

```dart
String formatPrice(double price, [double discount = 0]) {
  return '价格: ${(price - discount).toStringAsFixed(2)}元';
}

formatPrice(99.9);        // 第二个参数省略 → discount=0
formatPrice(99.9, 10);    // 第二个参数传 10
```

**对比 JS**：JS 没有直接对应语法，通常用 `||` 模拟：
```js
// JS 模拟位置参数
function formatPrice(price, discount) {
  discount = discount || 0;  // 手动处理默认值
  return `价格: ${(price - discount).toFixed(2)}元`;
}
```
Dart 用 `[]` 一行搞定，且编译器帮你检查类型。

### ⚠️ 常见误解：位置参数 ≠ "命名参数加可选"

**位置参数和命名参数是两种完全不同的传参机制**，不是"命名参数加可选"。

```dart
// 命名参数 {}
void greet({String name, int age}) { ... }
greet(name: 'Alice', age: 25);   // 调用时必须写参数名 name: / age:
greet(age: 25, name: 'Alice');   // ✅ 顺序可换

// 位置参数 []
void greet(String name, [int age]) { ... }
greet('Alice', 25);   // 调用时只传值，不写参数名
greet('Alice');        // ✅ age 可省略
greet(25, 'Alice');    // ❌ 25 被当成 name，类型错！
```

**关键区别**：
- **命名参数的可选** = "这个参数名可以不出现" → `greet(name: 'Alice')` 省略 `age:`
- **位置参数的可选** = "这个位置的值可以不传" → `greet('Alice')` 省略第二个值

**位置参数的限制**：只能从后往前省略，不能跳过前面省略后面：
```dart
void f(String a, [int b, double c]) { ... }
f('x');        // ✅ a='x', b/c 用默认
f('x', 1);     // ✅ a='x', b=1, c 用默认
f('x', 1, 2.0); // ✅ a='x', b=1, c=2.0
// f('x', 2.0);  // ❌ 不能只传 a 和 c 跳过 b
```

命名参数可以任意省略，位置参数只能从后往前省略。

### 命名参数 vs 位置参数

| 维度 | 命名参数 `{}` | 位置参数 `[]` |
|------|--------------|--------------|
| **调用时** | 要写参数名 `name: 'Alice'` | 只写值 `'Alice'` |
| **顺序** | 可换 | 不能换 |
| **可选性** | 默认可选（除非加 `required`） | 默认可选（用 `[]` 标记） |
| **省略方式** | 任意省略（按名省） | 从后往前省（按位置省） |
| **可读性** | 高（参数名可见） | 低 |
| **适用** | 多参数、可选参数多 | 1-2 个可选参数 |
| **Flutter** | **Widget 构造函数全用这个** | 少用（核心库如 `List.sublist`） |

### 命名参数的两种形态：可选 vs 必填

**命名参数默认就是可选的**，`required` 是给"必填"加的标记。

```dart
void createProfile({
  required String username,    // 必填命名参数（类比 React 必填 props）
  String avatar = 'default.png', // 可选命名参数 + 默认值
  int age = 0,                   // 可选命名参数 + 默认值
}) { ... }
```

| 形态 | 写法 | 含义 |
|------|------|------|
| 可选 | `String avatar = 'default.png'` | 可不传，不传用默认值 |
| 必填 | `required String username` | 必须传，不传编译报错 |

**类比 React 的 propTypes**：React 里 props 默认可选，用 TS 的 `interface` 标必填。Dart 直接用 `required` 关键字在函数签名上标记，更直观。

```dart
// Dart
void createProfile({required String username}) { ... }
// 不传 username → 编译报错，防止漏传

// React + TS 等价
interface ProfileProps { username: string }  // 必填
function createProfile(props: ProfileProps) { ... }
```

### Flutter 场景预告

**Flutter 的所有 Widget 构造函数都用命名参数**，这是 Flutter 的编码规范。你后面写 Widget 时会大量看到：

```dart
Text(
  'Hello',
  style: TextStyle(fontSize: 16),  // 命名参数
  textAlign: TextAlign.center,     // 命名参数
)
```

这种写法和 React JSX 的 props 完全对应：
```jsx
<Text text="Hello" style={...} textAlign="center" />
```

---

## 七、Dart 项目结构分析

### 目录树

```
dart_basics/
├── bin/                        # 可执行入口（程序起点）
│   ├── dart_basics.dart        # 默认入口文件
│   └── variables.dart          # 我们写的练习代码
├── lib/                        # 库代码（可复用的业务逻辑）
│   └── dart_basics.dart        # 导出公共功能
├── test/                       # 测试代码
│   └── dart_basics_test.dart   # 单元测试
├── .gitignore                  # Git 忽略规则
├── CHANGELOG.md                # 版本变更记录
├── README.md                   # 项目说明
├── analysis_options.yaml       # 静态分析配置（lint 规则）
└── pubspec.yaml                # 项目配置 + 依赖管理（核心）
```

### 各文件作用（类比 Node.js）

#### 1. `pubspec.yaml` — 项目配置 + 依赖管理（最重要）

**类比 `package.json`**，是 Dart 项目的核心配置文件。

```yaml
name: dart_basics              # 项目名（类比 package.json 的 name）
description: A sample...        # 描述
version: 1.0.0                 # 版本号（语义化版本）

environment:
  sdk: ^3.12.2                 # Dart SDK 版本要求（类比 engines 字段）

dependencies:                  # 生产依赖（类比 dependencies）
  path: ^1.9.0                 # ^ 表示兼容 1.9.0 但不兼容 2.0.0

dev_dependencies:              # 开发依赖（类比 devDependencies）
  lints: ^6.0.0                # 代码检查规则
  test: ^1.25.6                # 测试框架
```

**关键差异**：
- Node.js 用 `npm install` 装依赖，Dart 用 `dart pub get`
- Node.js 依赖装在 `node_modules/`，Dart 装在全局缓存 `.dart_tool/`（不占项目空间）
- `^1.9.0` 语义和 npm 的 `^1.9.0` 一致

#### 2. `bin/` — 可执行入口

**类比 Node.js 的 `bin/` 字段或 `index.js`**，是程序运行起点。

```bash
dart run bin/variables.dart    # 运行指定入口
```

- `dart_basics.dart` 是默认生成的入口，`main` 函数是程序起点
- `variables.dart` 是我们加的练习文件，也可以独立运行
- **bin 里的代码可以 import lib 里的库**

#### 3. `lib/` — 库代码（业务逻辑）

**类比 Node.js 的 `src/` 或 `lib/`**，放可复用的业务代码。

```dart
// lib/dart_basics.dart
int calculate() {
  return 6 * 7;
}
```

```dart
// bin/dart_basics.dart
import 'package:dart_basics/dart_basics.dart' as dart_basics;
// 导入 lib 里的代码，package:dart_basics/ 是项目名
```

**关键差异**：
- Node.js 用 `require('./lib/xxx')` 相对路径导入
- Dart 用 `package:项目名/文件名` 包名导入（更规范，不怕路径变）

#### 4. `test/` — 测试代码

**类比 Node.js 的 `__tests__/` 或 `*.test.js`**，放单元测试。

```dart
// test/dart_basics_test.dart
import 'package:test/test.dart';
import 'package:dart_basics/dart_basics.dart';

void main() {
  test('calculate returns 42', () {
    expect(calculate(), 42);
  });
}
```

运行测试：`dart test`

#### 5. `analysis_options.yaml` — 静态分析配置

**类比 `.eslintrc.js` / `.eslintrc.json`**，配置代码检查规则。

```yaml
include: package:lints/recommended.yaml  # 使用推荐规则集
# 类比 eslint:recommended
```

VS Code 会实时检查代码风格、潜在 bug，红线就是这里的规则触发的。

#### 6. `.gitignore` — Git 忽略

```gitignore
.dart_tool/    # 类比 node_modules/，不提交到 git
```

#### 7. `CHANGELOG.md` / `README.md`

- `CHANGELOG.md` — 版本变更记录（类比 Node 项目的 CHANGELOG）
- `README.md` — 项目说明

### Dart vs Node.js 项目结构对比

| Dart 项目 | Node.js 项目 | 作用 |
|-----------|-------------|------|
| `pubspec.yaml` | `package.json` | 配置 + 依赖 |
| `pubspec.lock` | `package-lock.json` | 锁定依赖版本 |
| `.dart_tool/` | `node_modules/` | 依赖缓存（gitignore） |
| `bin/` | `bin/` 或 `index.js` | 可执行入口 |
| `lib/` | `src/` 或 `lib/` | 业务逻辑库 |
| `test/` | `__tests__/` | 测试代码 |
| `analysis_options.yaml` | `.eslintrc` | 代码检查规则 |
| `dart pub get` | `npm install` | 安装依赖 |
| `dart run` | `node` | 运行代码 |
| `dart test` | `npm test` | 运行测试 |

### Flutter 项目的结构差异（预告）

Flutter 项目也是 `pubspec.yaml` + `lib/` 结构，但多了：
- `lib/main.dart` — App 入口（不是 `bin/`）
- `android/` / `ios/` — 原生工程目录（打包用）
- `assets/` — 图片/字体等资源
- 没有 `bin/`（Flutter App 不是命令行程序）

明天写 Flutter 时你会看到这个差异。

---

## 八、运行验证

```bash
cd e:\flutter\dart_basics
dart run bin/variables.dart
```

输出覆盖：变量/常量、数据类型、运算符、控制流、函数 5 大模块，全部通过。
