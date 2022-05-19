import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/config.dart';

class Auth with ChangeNotifier {
  String? _Token;
  String? _tempToken;

  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> tempData() async {
    _Token = _tempToken;

    final sharedPref = await SharedPreferences.getInstance();

    final myMapSPref = json.encode({
      'token': _tempToken,
    });

    sharedPref.setString('authData', myMapSPref);

    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_Token != null) {
      return _Token;
    } else {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse(Config.login);
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "username": email,
          "password": password,
        }),
      );

      var responseData = json.decode(response.body);

      if (responseData['status'] != null) {
        throw responseData['error']["message"];
      }
      _tempToken = responseData["token"];
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _Token = null;
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    final pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('authData')) {
      return false;
    }
    final String? myData = pref.getString('authData');
    final Data = json.decode(myData!) as Map<String, dynamic>;

    _Token = Data["token"];

    notifyListeners();
    return true;
  }
}
