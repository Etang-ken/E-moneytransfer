import 'dart:async';

import 'package:flutter/material.dart';
import 'package:elcrypto/home_nav.dart';
import 'package:elcrypto/onboarding/auth/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = FlutterSecureStorage();
  Future<String?> getToken() async {
    return await storage.read(key: 'authToken');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print(getToken());
      // Timer(const Duration(seconds: 4), () {
      //   if(getToken() == null) {

      //   } else {
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) => LogIn()), (route) => false);}
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container()
    );
  }

 
}
