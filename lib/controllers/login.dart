import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import '/config.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 500);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> _authUserLogin(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      Uri url = Uri.parse(Config.login);
      try {
        var response = await http.post(
          url,
          body: json.encode({
            "username": data.name,
            "password": data.password,
          }),
        );
        var responseData = json.decode(response.body);
        print(responseData);
        if (responseData['status']) {
          final SharedPreferences prefs = await _prefs;
          prefs.setString("token", responseData['token']);
        }
      } catch (err) {
        print(err);
        return err.toString();
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return 'fungsi belum dibuat';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
          primaryColor: Colors.indigo[900], pageColorLight: Colors.white),
      title: 'ERP DT Peduli',
      logo: AssetImage('assets/dtpeduli.png'),
      onLogin: _authUserLogin,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      userType: LoginUserType.phone,
      userValidator: (value) {
        if (value!.isEmpty) {
          return "Silahkan masukkan HP atau Email dari ERP";
        }
        return null;
      },
      messages: LoginMessages(
        userHint: 'No HP',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot huh?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}
