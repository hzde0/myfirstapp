import 'package:flutter/material.dart';
import 'User.dart';
import 'database_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
              buildTitle(), // Login
              TextFormField(

                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  var emailReg = RegExp(
                      r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
                  if (!emailReg.hasMatch(value!)) {
                    return '请输入正确的邮箱地址';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),

              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: SizedBox(
                    height: 45,
                    width: 170,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          // 设置圆角
                            shape: MaterialStateProperty.all(const StadiumBorder(
                                side: BorderSide(style: BorderStyle.none)))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await dbHelper.insertUser(User(email: _email, password: _password));
                          Navigator.pop(context); // 返回登录界面
                        }
                      },
                      child: const Text('注册'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildTitle() {
    return const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          '注册',
          style: TextStyle(fontSize: 42),
        ));
  }
}
