import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/helper/session_manager.dart';
import 'package:emoneytransfer/screens/home.dart';
import 'package:emoneytransfer/screens/settings.dart';
import 'package:emoneytransfer/onboarding/auth/login.dart';

class HomeNav extends StatefulWidget {
  final int navIndex;

  HomeNav({this.navIndex = 0});

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  bool selectFilter = false;
  bool show_filter = false;
  int _currentIndex = 0;
  var token;
  late PageController _controller;
  var overLayIndex = 0;
  bool showOverLay = false;
  final storage = FlutterSecureStorage();

  void getToken() async {
    final hasToken = await storage.read(key: 'authToken');
    setState(() {
      token = hasToken;
    });
    // if (hasToken == null || hasToken.isEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => LogIn()),
    //     );
    //   });
    // } else {
    //   if(!mounted) return;
    //   updateUserProviderFromSharedPreference(context);
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkFirstTime();
  }

  @override
  void initState() {
    super.initState();
    getToken();
    _controller = PageController(initialPage: 0);
    _currentIndex = widget.navIndex;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  checkFirstTime() async {
    bool isFirstTime = await SessionManager().isFirstTime();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  dismissOverLay() async {
    await SessionManager().setFirstTime(false);
  }

  List<String> overLayOptions = [
    "Swipe through profiles to find people you think you would click with!",
    "Swipe right to like the user",
    "Swipe left to unlike the profile",
    "Tap on image to see other profile photos",
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var themeData = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: IndexedStack(
              index: _currentIndex,
              children: [
                for (final tabItem in TabNavigationItem.items) tabItem.page,
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              iconSize: 28,
              elevation: 20,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: AppUtils.PrimaryColor,
              unselectedItemColor: AppUtils.Secondary,
              backgroundColor: Colors.white,
              onTap: (value) {
                // Respond to item press.
                setState(() {
                  _currentIndex = value;
                });
              },
              items: [
                for (final tabItem in TabNavigationItem.items) tabItem.tab,
              ],
            )),
      ],
    );
  }
}

class TabNavigationItem {
  final BottomNavigationBarItem tab;
  final Widget page;

  TabNavigationItem({required this.page, required this.tab});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: const Dashboard(),
          tab: const BottomNavigationBarItem(
            label: "Transations",
            icon: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(Icons.money),
            ),
          ),
        ),
        TabNavigationItem(
            page: const Settings(),
            tab: const BottomNavigationBarItem(
              label: "Settings",
              icon: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Icon(Icons.settings),
              ),
            ))
      ];
}

class Forums {}
