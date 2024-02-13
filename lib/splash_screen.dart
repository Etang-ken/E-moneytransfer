import 'dart:async';

import 'package:flutter/material.dart';
import 'package:truelife_mobile/onboarding/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 4), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => LogIn()), (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              image: const DecorationImage(
                  image: AssetImage('assets/images/splash_bg2.png'),
                  fit: BoxFit.fill)),
          width: double.infinity,
          height: double.infinity,
          child: const Center(
              child: Icon(
            Icons.home,
            size: 50,
          ))),
    );
  }
}
