import 'package:flutter/material.dart';
import 'package:myfirstapp/root_page.dart';
import 'register.dart';

import 'database_helper.dart';
import 'package:myfirstapp/common.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // 不显示右上角的 debug
        title: 'Flutter Demo',
        theme:ThemeData(
          primarySwatch: Config.primarySwatchColor,//导航栏颜色
        ),
        // 注册路由表
        routes: {
          "/": (context) => const HomePage(title: "登录"), // 首页路由
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;
  final dbHelper = DatabaseHelper();


  final myController = TextEditingController();

  final List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.facebook,
    },
    {
      "title": "google",
      "icon": Icons.fiber_dvr,
    },
    {
      "title": "twitter",
      "icon": Icons.account_balance,
    },
  ];
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }
  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormStat
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            buildTitle(), // Login
            buildTitleLine(), // Login下面的下划线
            const SizedBox(height: 60),
            buildEmailTextField(), // 输入邮箱
            const SizedBox(height: 30),
            buildPasswordTextField(context), // 输入密码
            buildForgetPasswordText(context), // 忘记密码
            const SizedBox(height: 60),
            buildLoginButton(context), // 登录按钮
            const SizedBox(height: 40),
            buildOtherLoginText(), // 其他账号登录
            buildOtherMethod(context), // 其他登录方式
            buildRegisterText(), // 注册
          ],
        ),
      ),
    );
  }

  Widget buildRegisterText() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('No account yet? '),
            GestureDetector(
              child: Text(
                'Register',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegisterPage(title: 'Register'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget buildOtherMethod(context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(builder: (context) {
        return IconButton(
            icon: Icon(item['icon'],
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              //TODO: 第三方登录方法
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${item['title']}登录'),
                    action: SnackBarAction(
                      label: '取消',
                      onPressed: () {},
                    )),
              );
            });
      }))
          .toList(),
    );
  }

  Widget buildOtherLoginText() {
    return const Center(
      child: Text(
        '其他账号登录',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            // 设置圆角
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          child: Text('Login',
              style: Theme.of(context).primaryTextTheme.headline5),
          onPressed: () async {
            // 表单校验通过后保存数据
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              var user = await dbHelper.getUserByEmail(_email);
              if (user != null && user.password == _password) {
                print("Login successful.");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RootPage(),
                  ),
                );
              } else {
                print("Login failed.");
              }
            }
          },
        ),
      ),
    );
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            // Navigator.pop(context);
            print("忘记密码");
          },
          child: const Text("忘记密码？",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return TextFormField(
        obscureText: _isObscure, // 是否显示文字
        onSaved: (v) => _password = v!,
        onChanged: (text) {
          print('First text field: $text');
        },
        validator: (v) {
          if (v!.isEmpty) {
            return '请输入密码';
          }
        },
        decoration: InputDecoration(
            labelText: "Password",
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = (_isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color)!;
                });
              },
            )));
  }
//  邮箱
  Widget buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email Address'),
      onChanged: (text) {
        print('First text field: $text');
      },
      validator: (v) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(v!)) {
          return '请输入正确的邮箱地址';
        }
      },
      onSaved: (v) => _email = v!,
    );
  }

  Widget buildTitleLine() {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 4.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Colors.black,
            width: 40,
            height: 2,
          ),
        ));
  }

  Widget buildTitle() {
    return const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          '登录',
          style: TextStyle(fontSize: 42),
        ));
  }
}
