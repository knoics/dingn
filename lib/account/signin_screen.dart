import 'package:dingn/account/account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';


const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class SigninScreen extends StatelessWidget {
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String> _signinUser(BuildContext context, LoginData data) async {
    final accountModel = Provider.of<AccountModel>(context);
    final account = await accountModel.signInWithCredentials(email:data.name, password:data.password);
    return account == null ? 'Email and password does not match' : null;
  }

  Future<String> _signupUser(BuildContext context, LoginData data) async {
    final accountModel = Provider.of<AccountModel>(context);
    final account = await accountModel.signUp(email:data.name, password:data.password);
    return account == null ? 'Sorry signup failed.' : null;
  }

  Future<String> _recoverPassword(BuildContext context, String email) async {
    final accountModel = Provider.of<AccountModel>(context);
    await accountModel.sendPasswordResetEmail(email);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'dingn',
      theme: LoginTheme(
        primaryColor: Colors.grey
      ),
      messages: LoginMessages(
        loginButton: 'sign in', 
        signupButton: 'sign up', 
        recoverPasswordIntro: 'Password Reset',
        recoverPasswordDescription: 'Please specify your email to send the password reset link.',
        recoverPasswordButton: 'send'),
      onLogin: (loginData)=>_signinUser(context, loginData),
      onSignup: (loginData)=>_signupUser(context, loginData),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pop();
      },
      onRecoverPassword: (email)=>_recoverPassword(context, email),
    );
  }
}