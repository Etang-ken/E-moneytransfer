import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:emoneytransfer/helper/network.dart';
import 'package:emoneytransfer/helper/shared_preference.dart';
import 'package:emoneytransfer/models/user_image.dart';

import 'package:emoneytransfer/helper/custom_snack_bar.dart';

class User {
  int id;
  bool me;
  String? email;
  String? phone_number;
  String first_name;
  String last_name;
  String relationship_status;
  String children_status;
  String address;
  String? city;
  String bio;
  int age;
  String distance;
  String ageRange;
  final List<UserImage> images;
  dynamic prompts;

  User(
      {required this.id,
      required this.me,
      required this.first_name,
      this.email,
      required this.last_name,
      this.phone_number,
      required this.relationship_status,
      required this.children_status,
      required this.address,
      this.city,
      required this.bio,
      required this.age,
      required this.distance,
      required this.ageRange,
      required this.images,
      this.prompts});

  factory User.fromJson(Map<String, dynamic> user) {
    List<UserImage> images = [];
    var jsonList = user['images'] as List;
    for (var element in jsonList) {
      images.add(UserImage.fromJson(element as Map<String, dynamic>));
    }

    return User(
      id: user['id'] as int,
      me: user['is_me'] as bool,
      email: user['email'] as String,
      first_name: user['first_name'] as String,
      last_name: user['last_name'] as String,
      phone_number: user['phone_number'] as String?,
      relationship_status: user['relationship_status'] as String,
      children_status: user['children_status'] as String,
      address: user['address'] as String,
      city: user['city'] as String?,
      bio: user['bio'] as String,
      age: user['age'] as int,
      distance: user['distance'] as String,
      ageRange: user['age_range'] as String,
      prompts: user['prompts'] as dynamic,
      images: images,
    );
  }
  static Future<dynamic> registerUser(Map<String, dynamic> userData) async {
    final Map<String, dynamic> data = {
      "first_name": userData['first_name'],
      "last_name": userData['last_name'],
      'phone': userData['phone'],
      'email': userData['email'],
      'password': userData['password'],
    };

    final String url = 'api/register';
    return await HttpResource().post(endpoint: url, data: data);
  }

  static Future<dynamic> loginUser({context, required Map userData}) async {
    final Map<String, dynamic> data = {
      'phone': userData['phone'],
      'password': userData['password'],
    };
    final String url = 'api/login';
    final response = await HttpResource().auth(endpoint: url, data: data);
    if (response != 'error') {
      if (response['success']) {
        Map user = response['user'];
        String token = response['token'];
        saveUser(user, token);
        if (response['user']['role'] != "") {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => HomeNav()),
          //         (route) => route.isFirst);
        }else{
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => GetStarted()),
          //         (route) => route.isFirst);
        }
      } else {
        final snackBar = customSnackBar(
            context: context, type: ContentType.failure, data: response);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Navigator.of(context).pop();
      }
    } else {
      var data = {
        "message": "Check your connection and try again",
      };
      Navigator.of(context).pop();
      final snackBar = customSnackBar(
          context: context, type: ContentType.failure, data: data);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<dynamic> getUserDetails() async {
    final url = 'api/return_profile';
    try {
      final response = await HttpResource().get(url);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  static Future<dynamic> resetPassword(Map<String, dynamic> data) async {
    final url = 'api/check_user_account';

    Map<String, dynamic> userData = {'email': data['email']};
    try {
      print("data before request $data");
      final response = await HttpResource().post(endpoint: url, data: userData);
      print(response.body);
      return response;
    } catch (e) {
      throw e;
    }
  }

  static Future<dynamic> setNewPassword(data) async {
    Map<String, dynamic> userData = {
      'email': data['email'],
      'password': data['password']
    };
    final url = 'api/set_new_password';
    try {
      final response = await HttpResource().post(endpoint: url, data: userData);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
