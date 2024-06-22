import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

late DateTime token_expires_at;

Future<void> saveUser(dynamic user, String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  prefs.setBool("isLoggedIn", true);
  prefs.setBool("isFirstTime", false);
  saveUserWithoutToken(user);
}

Future<void> saveUserWithoutToken(dynamic user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userData", json.encode(user));
  prefs.setString("phone", user['phone']);
  prefs.setString("email", user['email']??"");
  prefs.setBool("isLoggedIn", true);
}

Future getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('userData')) {
    final userData = prefs.getString("userData") as Map;
    return userData;
  }
  return false;
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token") ?? '';
}

Future<String> getRole() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("role") ?? '';
}

Future<bool> isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isLoggedIn") ?? false;
}

void removeUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("userData");
  prefs.remove("token");
  prefs.setBool("isLoggedIn", false);
}

Future<void> setOnboardingStatus(bool status) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("profile_status", status);
}

Future<bool> getOnboardingStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("profile_status") ?? false;
}
