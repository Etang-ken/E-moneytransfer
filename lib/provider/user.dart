import 'package:flutter/material.dart';

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? admin;
  String? profileUrl;
  String? firstName;
  String? lastName;
}

class UserProvider extends ChangeNotifier {
  UserData userData = UserData();

  void updateUserData(data) {
    userData.id = data['id'];
    userData.name = data['name'];
    userData.email = data['email'];
    userData.phone = data['phone'];
    userData.admin = data['admin'];
    userData.firstName = data['firstName'];
    userData.lastName = data['lastName'];
    userData.profileUrl = data['profileUrl'];

    notifyListeners();
  }
}
