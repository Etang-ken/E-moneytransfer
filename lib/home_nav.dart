
import 'package:flutter/material.dart';

import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/helper/session_manager.dart';
import 'package:truelife_mobile/main_tabs/clients.dart';
import 'package:truelife_mobile/main_tabs/home.dart';
import 'package:truelife_mobile/main_tabs/profile.dart';
import 'package:truelife_mobile/main_tabs/transactions.dart';

class HomeNav extends StatefulWidget {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkFirstTime();
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  checkFirstTime() async {
    bool isFirstTime = await SessionManager().isFirstTime();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        showOverLay = isFirstTime;
      });
    });
  }

  dismissOverLay() async {
    setState(() => showOverLay = false);
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

    print(token);
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
              onTap: (value) {
                // Respond to item press.
                setState(() => _currentIndex = value);
              },
              items: [
                for (final tabItem in TabNavigationItem.items) tabItem.tab,
              ],
            )),

       if(showOverLay) ...[
         Container(
           width: double.infinity,
           height: double.infinity,
           decoration: BoxDecoration(
               color: Colors.black87.withOpacity(.9)
           ),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                 height: 370,
                 width: mediaQuery.size.width * 0.6,
                 clipBehavior: Clip.antiAlias,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: PageView.builder(
                   controller: _controller,
                   itemCount: 4,
                   onPageChanged: (int i) {
                     setState(() {
                       overLayIndex = i;
                     });
                   },
                   itemBuilder: (ctx, index) => Column(
                     children: [
                       Container(
                         height: 250,
                         width: double.infinity,
                         color: AppUtils.PrimaryLight,
                         child: Stack(
                           alignment: AlignmentDirectional.center,
                           children: [
                             Image.asset('assets/images/overlay-background.png', width: mediaQuery.size.width * .5,),
                             Container(
                               alignment: Alignment.bottomCenter,
                               child: Image.asset('assets/images/overlay-pointer.png', width: 122,),
                             )
                           ],
                         ),
                       ),
                       Expanded(
                         child: Container(
                           width: double.infinity,
                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                           color: AppUtils.PrimaryColor,
                           child: Center(
                             child: Text(overLayOptions[index],
                               style: themeData.textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
               indicators([1,2,3,4].toList(), overLayIndex),
               const SizedBox(height: 25,),
               MaterialButton(
                 onPressed: () => dismissOverLay(),
                 textColor: Colors.white,
                 color: AppUtils.PrimaryColor,
                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                 child: Text("Got it!", style: TextStyle(fontWeight: FontWeight.bold),),
               )
             ],
           ),
         )
       ]
      ],
    );
  }
}

Widget indicators(List items, overLayIndex) {
  return SizedBox(
    height: 62,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return overLayIndex == index ? Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
            ),
          )
              : Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle
              )
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 20,),
        itemCount: items.length),
  );
}

class TabNavigationItem {
  final BottomNavigationBarItem tab;
  final Widget page;

  TabNavigationItem({
    required this.page,
    required this.tab
  });

  static List<TabNavigationItem> get items => [

        TabNavigationItem(
          page: Dashboard(),
          tab: BottomNavigationBarItem(
            label: "Home",
            icon: Padding(
              child: Icon(Icons.home_outlined),
              padding: EdgeInsets.only(top: 5),
            ),
          ),
        ),

        TabNavigationItem(
          page: Transactions(),
          tab: BottomNavigationBarItem(
            label: "Transations",
            icon: Padding(
              child: Icon(Icons.money),
              padding: EdgeInsets.only(top: 5),
            ),
          ),
        ),
    TabNavigationItem(
      page: Clients(),
      tab: BottomNavigationBarItem(
        label: "Clients",
        icon: Padding(
          child:  Icon(Icons.supervised_user_circle_outlined),
          padding: EdgeInsets.only(top: 5),
        ),
      ),
    ),
    TabNavigationItem(
        page: Profile(),
        tab: BottomNavigationBarItem(
          label: "Profile",
          icon: Padding(
            child: Icon(Icons.account_circle_outlined),
            padding: EdgeInsets.only(top: 5),
          ),
        ))
  ];
}

class Forums {
}
