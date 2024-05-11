import 'dart:async';

import 'package:emoneytransfer/onboarding/auth/register.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:emoneytransfer/home_nav.dart';
import 'package:emoneytransfer/onboarding/auth/login.dart';
import 'package:emoneytransfer/provider/transaction.dart';
import 'package:emoneytransfer/provider/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //print('User granted permission: ${settings.authorizationStatus}');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xff0488DD), // navigation bar color
    statusBarColor: Color(0xff0488DD), // status bar color
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'authToken');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pro4home',
      theme: ThemeData(
        // primarySwatch: MaterialColor(),
        // Define the default brightness and colors.
        primaryColor: Color(0xFF008100),
        hintColor: Color(0xffFF9719),
        backgroundColor: Color(0xFF008100).withOpacity(0.03),
        unselectedWidgetColor: Colors.grey,
        primaryColorDark: Color(0xff000000),
        primaryColorLight: Color(0xffffffff),
        fontFamily: 'Barlow',
        textTheme: const TextTheme(
          // body text styles
          bodyText1: TextStyle(
            color: Color(0xff212121),
            fontFamily: 'Barlow',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          bodyText2: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Barlow',
              height: 1.5,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 16),

          // heading styles
          headline1: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontSize: 30,
              fontWeight: FontWeight.w700),

          // for secondary headers that are black
          headline2: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontSize: 26,
              fontWeight: FontWeight.w700),

          // for secondary headers that are purple
          headline3: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontSize: 23,
              fontWeight: FontWeight.w700),

          // used for buttons
          headline4: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4),

          headline5: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4),
          headline6: TextStyle(
              color: Color(0xff212121),
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4),
        ),
      ),
      home: Scaffold(
        body: FutureBuilder<String?>(
          future: getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final authToken = snapshot.data;
              if (authToken != null) {
                return showSplashScreen(HomeNav(), context);
              } else {
                return showSplashScreen(LogIn(), context);
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      routes: {},
    );
  }

  Widget showSplashScreen(Widget screen, BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => screen, // Change to the desired screen
        ),
      );
    });
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
              image: AssetImage('assets/images/splash_bg.png'),
              fit: BoxFit.fill)),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/images/logo/elcrypto.png',
          height: 250,
        ),
      ),
    );
  }
}
