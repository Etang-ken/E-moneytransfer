import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  final String auth_token = "token";


  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, "");
    prefs.setString("email", "");
    prefs.setString("profile", "");
    prefs.setString("phone", "");
    prefs.setString("firstname", "");
    prefs.setString("lastname", "");
    prefs.setBool("isLoggedin", false);
  }

// a function to logout user based on my current user model saved in shared preference
  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    prefs.remove("token");
    prefs.remove("user");
    prefs.setBool("isLoggedIn", false);
  }

  Future<bool> isLoggedin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isLoggedIn") ?? false;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? '';
  }

//disable First time on app
  Future<void> setFirstTime(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstTime", val);
  }

  //gets is First time on app
  Future<bool> getFirstTime(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isFirstTime") ?? true;
  }

  Future<String> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id").toString() ?? "";
  }

  Future<void> setProfileStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("profile_status", status);
  }

  Future<bool> getProfileStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("profile_status") ?? false;
  }

//get First time on app
  Future<bool> isFirstTime() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isFirstTime") ?? true;
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;
    auth_token = pref.getString(this.auth_token) ?? "";
    return auth_token;
  }

  Future<void> setCartItems(String items) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", items);
  }

  Future<String> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString("email") ?? "";
    return email;
  }

  Future<String> getProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String profile = pref.getString("profile") ?? "";
    return profile;
  }

  Future<String> getBio() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String bio = pref.getString("bio") ?? "";
    return bio;
  }

  Future<void> updateProfile(
      String firstname, String lastname, String bio) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
    prefs.setString("firstname", firstname);
    prefs.setString("lastname", lastname);
    prefs.setString("bio", bio);
  }

  Future<void> setNotificationsSettings(
      {notifications, messages, replies, shares, reminder_email, feedback_email, news_letter}) async{
    // print("notifications reaching session manager $messages");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(notifications != null) prefs.setInt("notifications", notifications);
    if(messages != null)prefs.setInt("messages", messages);
    if(replies != null)prefs.setInt("replies", replies) ;
    if(reminder_email != null)prefs.setInt("reminder_emails", reminder_email) ;
    if(feedback_email != null)prefs.setInt("feedback_emails", feedback_email) ;
    if(news_letter != null)prefs.setInt("news_letter", news_letter) ;
  }

  Future<dynamic> getNotificationsSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic result = {
      'notifications': prefs.getInt("notifications") ?? 1 ,
      'messages': prefs.getInt("messages") ?? 1,
      'replies': prefs.getInt('replies') ?? 1,
      'reminder_emails': prefs.getInt('reminder_emails') ?? 1,
      'feedback_emails': prefs.getInt('feedback_emails') ?? 1,
      'news_letter': prefs.getInt('news_letter') ?? 1
    };
    return result;
  }

  Future<bool?> allNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notifications");
  }


  Future<void> setQuiz(String items) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("quiz", items);
  }

  Future<dynamic> getQuiz() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String quiz = pref.getString("quiz") ?? "[]";
    return jsonDecode(quiz);
  }


  Future<void> setPhone(phone_number) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone_number);
  }


  Future<void> setEmail( emailData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", emailData);
  }

  Future<void> setFcmToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("fcmToken", token);
  }

  Future<String> getFcmToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("fcmToken") ?? "";
    return token;
  }

  Future<String> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userData") ?? "";
  }
}
