import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../common/index.dart';
import '../../l10n/localization_intl.dart';
import '../../services/index.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool _isObscure = true;
  bool _unameAutoFocus = true;
  final _authService = getIt<AuthService>();
  final _apiService = getIt<ApiService>();

  List _loginMethod = [
    {
      "title": "facebook",
      "icon": Bootstrap.facebook,
    },
    {
      "title": "google",
      "icon": Bootstrap.google,
    },
    {
      "title": "twitter",
      "icon": Bootstrap.twitter,
    },
    {
      "title": "wechat",
      "icon": Bootstrap.wechat,
    },
    {
      "title": "telegram",
      "icon": Bootstrap.telegram,
    }
  ];

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin ?? "";
    if (_unameController.text.isNotEmpty) {
      _unameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 70.0),
                buildUnameTextField(),
                SizedBox(height: 30.0),
                buildPasswordTextField(context),
                buildForgetPasswordText(context),
                SizedBox(height: 60.0),
                buildLoginButton(context),
                SizedBox(height: 30.0),
                buildOtherLoginText(),
                buildOtherMethod(context),
                buildRegisterText(context),
              ],
            )));
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        WanLocalizations.of(context).nav_login,
        style: TextStyle(
          fontSize: 42.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Theme.of(context).primaryColor,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  TextFormField buildUnameTextField() {
    return TextFormField(
      autofocus: _unameAutoFocus,
      controller: _unameController,
      decoration: InputDecoration(
        labelText: WanLocalizations.of(context).login_username_label,
        prefixIcon: Icon(Bootstrap.person_fill),
      ),
      validator: (v) {
        return v == null || v.trim().isNotEmpty ? null : WanLocalizations.of(context).login_username_validator;
      },
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      autofocus: !_unameAutoFocus,
      controller: _pwdController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: WanLocalizations.of(context).login_password_label,
        prefixIcon: Icon(AntDesign.lock_fill),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? AntDesign.eye_invisible_fill : AntDesign.eye_fill,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      validator: (v) {
        return v == null || v.trim().isNotEmpty ? null : WanLocalizations.of(context).login_password_validator;
      },
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          child: Text(
            WanLocalizations.of(context).login_btn_forget_password,
          ),
          onPressed: () {
          },
        ),
      ),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: ElevatedButton(
          child: Text(
            WanLocalizations.of(context).login_btn_login,
          ),
          onPressed: () {
            // if (_formKey.currentState.validate()) {
            //   /// 只有输入内容符合通过要求才能到达此处
            //   _formKey.currentState.save();

            /// TODO 执行登录方法
            // print('email:$_username, password:$_password');
            // }
          },
        ),
      ),
    );
  }

  Align buildOtherLoginText() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        // '其他帐号登录',
        WanLocalizations.of(context).login_other_method,
        style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 14.0),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return IconButton(
                      icon: Icon(
                        item['icon'],
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        /// TODO 第三方登录方法
                      });
                },
              ))
          .toList(),
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(WanLocalizations.of(context).login_no_account),
            GestureDetector(
              child: Text(
                WanLocalizations.of(context).login_btn_signup,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onTap: () {
                /// TODO 跳转到注册页面
                print('去注册');
              },
            ),
          ],
        ),
      ),
    );
  }
}
