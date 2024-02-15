import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:truelife_mobile/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //print('User granted permission: ${settings.authorizationStatus}');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xff0488DD), // navigation bar color
    statusBarColor: Color(0xff0488DD), // status bar color
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const SplashScreen(),
      routes: {},
    );
  }
}
