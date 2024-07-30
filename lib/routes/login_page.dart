import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/common/wan_api.dart';
import 'package:flutter_hub/models/index.dart';
import 'package:provider/provider.dart';

import '../common/global.dart';
import '../models/user.dart';
import '../states/profile_change_notifier.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin ?? "";
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(labelText: "username",
                    hintText: "username",
                    prefixIcon: Icon(Icons.person)),
                // 校验用户名（不能为空）
                validator: (v) {
                  return v == null || v
                      .trim()
                      .isNotEmpty ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pwdController,
                decoration: InputDecoration(labelText: "pwd",
                  hintText: "password",
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(icon: Icon(
                      pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },),),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v==null||v.trim().isNotEmpty ? null : "输入密码";
                },
              ),
              Padding(padding: EdgeInsets.only(top: 25.0),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55.0),
                child: ElevatedButton(
                  onPressed: _onLogin,
                  child: Text("loGIn"),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async{
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      UserInfo? user;
      try {
        user = await Wan(context)
            .login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        // Provider.of<UserModel>(context, listen: false).user = user;
      } on DioException catch( e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {

        } else {
          // showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }
      //登录成功则返回
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}