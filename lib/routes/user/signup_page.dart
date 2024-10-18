import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/utils/logger.dart';
import 'package:flutter_hub/widgets/show_loading.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../common/index.dart';
import '../../models/index.dart';
import '../../services/index.dart';
import '../../states/profile_state.dart';
import '../../widgets/show_toast.dart';

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
  final _authService = getIt<AuthService>();
  final _apiService = getIt<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
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
                const SizedBox(height: 20.0),
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
            AppLocalizations.of(context).signup_title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context).signup_subtitle, style: TextStyle(fontSize: 15)),
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
        hintText: AppLocalizations.of(context).signup_username_label,
        prefixIcon: Icon(Bootstrap.person_fill),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        filled: true,
      ),
      validator: (v) {
        return v == null || v.trim().isNotEmpty ? null : AppLocalizations.of(context).signup_username_validator;
      },
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _pwdController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).signup_password_label,
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
        return v == null || v.trim().isNotEmpty ? null : AppLocalizations.of(context).signup_password_validator;
      },
    );
  }

  TextFormField buildConfirmPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _confirmpwdController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).signup_confirm_password_label,
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
        if (v == null || v.trim().isEmpty) {
          return AppLocalizations.of(context).signup_password_validator;
        } else if (v != _pwdController.text) {
          return AppLocalizations.of(context).signup_password_mismatch_error;
        }
        return null;
      },
    );
  }

  Align buildSignupButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: ElevatedButton(
          onPressed: _onSignup,
          child: Text(
            AppLocalizations.of(context).signup_btn_signup,
            style: TextStyle(fontSize: 16),
          ),
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
            Text(AppLocalizations.of(context).signup_already_have_an_account),
            GestureDetector(
              child: Text(
                AppLocalizations.of(context).signup_btn_login,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Constants.loginRoutePath);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSignup() async {
    /// 取消所有 TextFormField 的焦点
    FocusScope.of(context).unfocus();

    /// 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);

      ///执行注册方法
      Log.info('username:${_unameController.text}, password:${_pwdController.text}, repassword:${_confirmpwdController.text}');
      ResponseModel<UserInfo>? userInfo;
      try {
        userInfo = await _authService.register(_unameController.text, _pwdController.text, _confirmpwdController.text);
        if (userInfo.errorCode != 0) {
          showToast("${userInfo.errorMsg}${userInfo.errorCode}");
        }
        Log.info(userInfo.toString());
      } catch (e) {
        showToast(e.toString());
      } finally {
        if (mounted) {
          hideLoading(context);
        }
      }

      ///注册成功则返回
      if (userInfo?.errorCode == 0 && userInfo?.data != null) {
        if (mounted) {
          ///执行获取用户信息
          ResponseModel<User>? res = await _apiService.retrieveUserData(context);
          Provider.of<UserModel>(context, listen: false).user = res?.data;
          showToast(AppLocalizations.of(context).signup_message_welcome_signup_successful(userInfo?.data?.username ?? ''));
          Navigator.of(context).pop();
        }
      }
    }
  }
}
