import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../common/index.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmpwdController = TextEditingController();
  bool _isObscure = true;

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
                const SizedBox(height: 20.0),
                buildConfirmPasswordTextField(context),
                const SizedBox(height: 60.0),
                buildSignupButton(context),
                const SizedBox(height: 30.0),
                buildLoginText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            WanLocalizations.of(context).signup_title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(WanLocalizations.of(context).signup_subtitle, style: TextStyle(fontSize: 15)),
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
          color: Theme.of(context).colorScheme.primary,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  TextFormField buildUnameTextField() {
    return TextFormField(
      controller: _unameController,
      decoration: InputDecoration(
        hintText: WanLocalizations.of(context).signup_username_label,
        prefixIcon: Icon(Bootstrap.person_fill),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        filled: true,
      ),
      validator: (v) {
        return v == null || v.trim().isNotEmpty ? null : WanLocalizations.of(context).signup_username_validator;
      },
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _pwdController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: WanLocalizations.of(context).signup_password_label,
        prefixIcon: Icon(AntDesign.lock_fill),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
        return v == null || v.trim().isNotEmpty ? null : WanLocalizations.of(context).signup_password_validator;
      },
    );
  }

  TextFormField buildConfirmPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _confirmpwdController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: WanLocalizations.of(context).signup_confirm_password_label,
        prefixIcon: Icon(AntDesign.lock_fill),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
        return v == null || v.trim().isNotEmpty ? null : WanLocalizations.of(context).signup_confirm_password_validator;
      },
    );
  }

  Align buildSignupButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: ElevatedButton(
          child: Text(
            WanLocalizations.of(context).signup_btn_signup,
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            // if (_formKey.currentState.validate()) {
            //   /// 只有输入内容符合通过要求才能到达此处
            //   _formKey.currentState.save();

            /// TODO 执行注册方法
            // print('email:$_username, password:$_password');
            // }
          },
        ),
      ),
    );
  }

  Align buildLoginText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(WanLocalizations.of(context).signup_already_have_an_account),
            GestureDetector(
              child: Text(
                WanLocalizations.of(context).signup_btn_login,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                /// TODO 执行登录方法
                Navigator.of(context).pushNamed(Constants.loginRoutePath);
              },
            ),
          ],
        ),
      ),
    );
  }
}
