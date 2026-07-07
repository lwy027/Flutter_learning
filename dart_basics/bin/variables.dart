// Dart 基础语法练习 - Day 1
// 覆盖：变量/常量、数据类型、运算符、控制流、函数
// 运行：dart run bin/variables.dart

// Dart 程序入口（类比 C/Java 的 main，JS 没有强制 main 但 Node 也有）
void main() {
  // print('=== 1. 变量与常量 ===');
  // variablesDemo();

  // print('\n=== 2. 数据类型 ===');
  // typesDemo();

  // print('\n=== 3. 运算符 ===');
  // operatorsDemo();

  // print('\n=== 4. 控制流 ===');
  // controlFlowDemo();

  // print('\n=== 5. 函数 ===');
  // functionsDemo();
  // sum1(1, 2);
  // sum2(a: 1, b: 2);
  // sum3(1);  // 位置参数：只传值，不写参数名
  // test();
  controlFlowDemoWithString('Tom', 25, '北京');  // 有值
  controlFlowDemoWithString('Tom', 25, null);     // city 为 null，用默认值
  controlFlowDemoWithString(null, null, null);    // 全部 null，用默认值
}





int sum1(int a, int b) {
  return a + b;
}

int sum2({required int a, required int b}) {
  return a + b;
}

// 全用命名参数（推荐）
int sum3( int a, [int b = 0]) {
  return a + b;
}


void test () {
  // 级联运算符 ..：对同一对象连续调用方法，返回对象本身（不是返回值）
  // 类比 JS 的链式调用 array.push(1).push(2)，但 JS 的 push 返回 length 不是数组
  List<int> nums = []
    ..add(1)   // ..add(1) 返回 nums 本身，继续操作
    ..add(2)   // 等价于 nums.add(1); nums.add(2);
    ..add(3);

  print("nums $nums");  // nums [1, 2, 3]
}




void controlFlowDemoWithString(String? name, int? age, String? city) {
  // 字符串插值中使用 ?? 必须用 ${} 包裹表达式
  // $name 只能取变量值，不能写 $name ?? 'xxx'
  print('你好我是 ${name ?? '匿名用户'}, 我今年 ${age ?? 100} 岁, 我来自 ${city ?? '上海'}');
}












// ============================================================
// 1. 变量与常量
// 类比 JS：var≈let, final≈JS的const(引用锁定), const=Dart独有的编译时常量
// ============================================================
void variablesDemo() {
  // var：类型推断（类比 JS 的 let，Dart 会推断类型后锁定）
  var name = 'Tom';        // 推断为 String，之后不能再赋值为其他类型
  var age = 25;            // 推断为 int
  print('name=$name, age=$age'); // $ 是字符串插值，类比 JS 模板字符串 ${name}

  // 显式类型声明（类比 TS 的 let name: string）
  String city = '北京';
  int year = 2026;
  print('city=$city, year=$year');

  // final：运行时常量，只能赋值一次（类比 JS 的 const）
  // 适合"运行时才能确定的不可变值"，如用户输入、当前时间
  final currentTime = DateTime.now();
  print('当前时间: $currentTime');
  // currentTime = DateTime.now(); // ❌ 报错：final 只能赋值一次

  // final 锁引用不锁内容（和 JS const 行为一致）
  final list = [1, 2, 3];
  list.add(4);             // ✅ 允许修改 List 内容
  print('final list: $list');

  // const：编译时常量，值在编译时就必须确定（Dart 独有，JS 无对应）
  // 适合"永远不变的值"，如配置常量、数学常数
  const pi = 3.14159;
  const appName = 'Flutter Learning';
  print('pi=$pi, appName=$appName');

  // const 的深度不可变特性
  const constList = [1, 2, 3];
  // constList.add(4); // ❌ 报错：const List 不可修改内容
  print('const list: $constList');

  // ⚠️ 关键差异陷阱：final vs const
  // final now2 = DateTime.now();  // ✅ 运行时确定
  // const now2 = DateTime.now();  // ❌ 编译时无法确定，报错

  // dynamic：动态类型（类比 JS 的弱类型，谨慎用，会失去类型安全）
  dynamic anything = 'hello';
  anything = 42;           // ✅ 允许换类型
  print('dynamic: $anything');
  // 提示：生产代码尽量少用 dynamic，用 Object 或泛型更安全
}

// ============================================================
// 2. 数据类型
// Dart 是强类型语言（类比 TS），所有类型在编译时检查
// JS 是弱类型（number/string/boolean/null/undefined/symbol/object）
// Dart 类型：int, double, String, bool, List, Map, Set, null
// ============================================================
void typesDemo() {
  // 数字：int（整数）和 double（浮点），不像 JS 的 number 涵盖两者
  int count = 100;
  double price = 19.99;
  print('int: $count, double: $price');

  // 数字类型转换（Dart 不会自动隐式转换，必须显式）
  double d = 3.7;
  int i = d.toInt();       // 截断小数 → 3
  int rounded = d.round(); // 四舍五入 → 4
  print('3.7 → toInt=$i, round=$rounded');

  // 字符串：String，单引号/双引号都行（和 JS 一致）
  String s1 = 'hello';
  String s2 = "world";
  // 字符串插值：$variable 或 ${expression}（类比 JS 模板字符串）
  String greeting = '$s1 ${s2.toUpperCase()}!';
  print('插值: $greeting');

  // 多行字符串（三个引号，类比 JS 的反引号）
  String multi = '''
第一行
第二行
第三行''';
  print('多行:\n$multi');

  // 布尔：bool（注意：Dart 的布尔只有 true/false，没有 JS 的"truthy/falsy"）
  bool isReady = true;
  bool isEmpty = false;
  print('bool: $isReady, $isEmpty');

  // ⚠️ 重大差异：Dart 没有 JS 的 truthy/falsy
  // JS 中 if (0) / if ('') / if (null) 都是 false
  // Dart 中必须显式判断：if (count == 0) / if (s.isEmpty) / if (x == null)
  String maybeEmpty = '';
  // if (maybeEmpty) { ... } // ❌ Dart 报错：类型不匹配
  if (maybeEmpty.isEmpty) { // ✅ 显式判断
    print('字符串为空');
  }

  // List：类比 JS Array
  List<String> fruits = ['apple', 'banana', 'cherry'];
  print('List: $fruits, 第一个: ${fruits[0]}, 长度: ${fruits.length}');
  fruits.add('date');
  print('添加后: $fruits');

  // Map：类比 JS Object / Map
  Map<String, int> scores = {
    'Alice': 95,
    'Bob': 87,
  };
  scores['Charlie'] = 92;
  print('Map: $scores');
  print('Alice 的分数: ${scores['Alice']}');

  // Set：去重集合（JS 也有 Set）
  Set<int> unique = {1, 2, 3, 2, 1}; // 自动去重
  print('Set: $unique'); // {1, 2, 3}

  // null：Dart 有空安全（重点，Day 2 详讲）
  // 非空类型不能赋 null（默认）
  String notNull = 'hello';
  // notNull = null; // ❌ 报错：String 不能为 null
  String? nullable = null; // ✅ 加 ? 表示可空
  print('可空: $nullable');
}

// ============================================================
// 3. 运算符
// 算术/关系/逻辑与 JS 基本一致，重点学 Dart 特有的空相关运算符
// ============================================================
void operatorsDemo() {
  // 算术运算符（和 JS 一致）
  int a = 10, b = 3;
  print('算术: $a+$b=${a + b}, $a-$b=${a - b}, $a*$b=${a * b}, $a/$b=${a / b}');
  print('整除: $a~/$b=${a ~/ b}'); // ~/ 整除（JS 用 Math.floor）
  print('取余: $a%$b=${a % b}');

  // 关系运算符（和 JS 一致）
  print('关系: ${a > b}, ${a < b}, ${a == b}, ${a != b}');

  // 逻辑运算符（和 JS 一致）
  bool x = true, y = false;
  print('逻辑: ${x && y}, ${x || y}, ${!y}');

  // ⭐ 空合并运算符 ??（Dart 常用，JS 也有 ?? 但用得少）
  // 作用：左侧为 null 时取右侧的值（类比 JS 的 value ?? defaultValue）
  String? username;
  String displayName = username ?? '匿名用户'; // username 为 null → 取 '匿名用户'
  print('空合并: $displayName');

  username = 'Alice';
  displayName = username ?? '匿名用户'; // username 非 null → 取 'Alice'
  print('空合并(非空): $displayName');

  // ⭐ 安全调用 ?.（类比 TS 的可选链）
  // 作用：左侧为 null 时整个表达式为 null，不报错
  String? name;
  int? nameLength = name?.length; // name 为 null → nameLength 为 null
  print('安全调用: $nameLength');

  name = 'Bob';
  nameLength = name?.length; // name 非 null → 取长度 3
  print('安全调用(非空): $nameLength');

  // ⭐ 空断言 !（告诉编译器"我确定它非 null"）
  // 作用：把 String? 强转为 String，若实际为 null 会运行时抛错
  String? maybeName = 'Carol';
  int len = maybeName!.length; // ! 表示"我保证非 null"
  print('空断言: $len');

  // ⚠️ 谨慎用 !：如果 maybeName 实际是 null，会抛 NullPointerException
  // 类比 TS 的非空断言 !，但 Dart 运行时会检查

  // 条件表达式（三元，和 JS 一致）
  int score = 85;
  String level = score >= 60 ? '及格' : '不及格';
  print('三元: $level');

  // 级联运算符 ..（Dart 特有，JS 无对应）
  // 作用：对同一对象连续操作，返回对象本身（类比链式调用但更通用）
  List<int> nums = [];
  nums
    ..add(1)
    ..add(2)
    ..add(3);
  print('级联: $nums');
}

// ============================================================
// 4. 控制流
// if/else/for/while/switch 与 JS 几乎完全一致，差异点会标注
// ============================================================
void controlFlowDemo() {
  // if-else（和 JS 一致，但条件必须是 bool，不能用 truthy/falsy）
  int age = 18;
  if (age >= 18) {
    print('已成年');
  } else {
    print('未成年');
  }

  // for 循环（和 JS 一致）
  for (int i = 0; i < 3; i++) {
    print('for i=$i');
  }

  // for-in（类比 JS 的 for...of）
  List<String> colors = ['red', 'green', 'blue'];
  for (var color in colors) {
    print('color: $color');
  }

  // while（和 JS 一致）
  int n = 3;
  while (n > 0) {
    print('while n=$n');
    n--;
  }

  // switch（Dart 3 支持模式匹配，比 JS 更强大）
  // JS 的 switch 只能做值匹配，Dart 3 还能做结构匹配（解构+类型匹配+条件守卫）
  // 高级用法 Day 2+ 详讲，这里先演示基本值匹配
  String weather = 'sunny'; // 示例数据，传给 switch 演示分支
  // Dart: String 首字母大写；JS: let（类型推断）；TS: string 小写
  switch (weather) {
    case 'sunny':
      print('晴天，适合出门');
      break;
    case 'rainy':
      print('下雨，带伞');
      break;
    case 'cloudy':
      print('多云');
      break;
    default:
      print('未知天气');
  }

  // break 和 continue（和 JS 一致）
  for (int i = 0; i < 5; i++) {
    if (i == 2) continue; // 跳过本次
    if (i == 4) break;    // 退出循环
    print('break/continue: i=$i');
  }
}

// ============================================================
// 5. 函数
// Dart 函数比 JS 灵活：命名参数、位置参数、默认值、箭头函数
// ============================================================

// 基本函数（和 JS function 一致，但需要类型注解）
int add(int a, int b) {
  return a + b;
}

// 箭头函数（类比 JS 的 =>，单表达式用）
int multiply(int a, int b) => a * b;

// ⭐ 命名参数 {}（Dart 特色，JS 无直接对应，类似 React props）
// 作用：调用时用参数名传递，顺序无关，可读性好
// 注意：命名参数默认就是可选的，required 才是给"必填"加的标记
void greet({String? name, int? age}) {
  print('你好，${name ?? '匿名'}，年龄 ${age ?? '未知'}');
}

// 命名参数 + 默认值 + required（必填）
// required 类比 React 的 propTypes/TS interface 的必填字段
void createProfile({
  required String username, // required 表示必填（类比 TS 的必填 props）
  String avatar = 'default.png', // 默认值（可选命名参数）
  int age = 0,
}) {
  print('Profile: $username, $avatar, $age');
}

// ⭐ 位置参数 []（可选参数，按位置传递）
// ⚠️ 注意：位置参数 ≠ "命名参数加可选"！
//   - 命名参数调用时写参数名：greet(name: 'Alice')，可任意省略
//   - 位置参数调用时只传值：formatPrice(99.9, 10)，只能从后往前省略
//   - JS 无直接对应语法，通常用 || 模拟默认值
String formatPrice(double price, [double discount = 0]) {
  return '价格: ${(price - discount).toStringAsFixed(2)}元';
}

void functionsDemo() {
  // 基本调用
  print('add: ${add(2, 3)}');
  print('multiply: ${multiply(4, 5)}');

  // 命名参数调用（用参数名，顺序无关）
  greet(name: 'Alice', age: 25);
  greet(age: 30, name: 'Bob'); // 顺序可换
  greet(); // 都可省略（因为有 ? 可空）

  // required 参数必须传
  createProfile(username: 'tom');
  createProfile(username: 'jerry', avatar: 'cat.png', age: 3);

  // 位置参数调用
  print(formatPrice(99.9));
  print(formatPrice(99.9, 10)); // 第二个参数 discount

  // 函数作为值传递（类比 JS 的函数是一等公民）
  var operation = add; // 把函数赋值给变量
  print('函数作为值: ${operation(10, 20)}');

  // 匿名函数（类比 JS 的箭头函数）
  var square = (int x) => x * x;
  print('匿名函数: ${square(5)}');

  // 高阶函数：forEach（类比 JS 的 array.forEach）
  [1, 2, 3].forEach((item) {
    print('forEach: $item');
  });
}
