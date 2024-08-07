import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    height: MediaQuery.of(context).size.height - 50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: kToolbarHeight,
                        ),
                        const SizedBox(height: 60.0),
                        buildTitle(),
                        const SizedBox(height: 10),
                        buildTitleLine(),
                        const SizedBox(height: 70.0),
                        buildUnameTextField(),
                        const SizedBox(height: 20.0),
                        buildPasswordTextField(context),
                        buildForgetPasswordText(context),
                        const SizedBox(height: 60.0),
                        buildLoginButton(context),
                        const SizedBox(height: 30.0),
                        buildOtherLoginText(),
                        buildOtherMethod(context),
                        buildSignupText(context),
                      ],
                    )))));
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            WanLocalizations.of(context).login_title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(WanLocalizations.of(context).login_subtitle, style: TextStyle(fontSize: 15)),
        ],
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
        hintText: WanLocalizations.of(context).login_username_label,
        prefixIcon: Icon(Bootstrap.person_fill),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
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
        hintText: WanLocalizations.of(context).login_password_label,
        prefixIcon: Icon(AntDesign.lock_fill),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
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
            WanLocalizations.of(context).login_btn_forgot_password,
          ),
          onPressed: () {
            launchUrl(
              Uri.parse('https://www.wanandroid.com/blog/show/2947'),
              mode: LaunchMode.externalApplication,
            );
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
            style: TextStyle(fontSize: 16),
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

  Align buildSignupText(BuildContext context) {
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
                Navigator.of(context).pushNamed(Constants.signupRoutePath);
              },
            ),
          ],
        ),
      ),
    );
  }
}
