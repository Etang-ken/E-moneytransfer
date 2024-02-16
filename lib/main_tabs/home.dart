import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/home_nav.dart';
import 'package:truelife_mobile/main_tabs/detail_screens/client_invoices.dart';
import 'package:truelife_mobile/main_tabs/notifications.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum BorderLeftOrRight { left, right }

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.White,
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dashboard",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white)),
            NotificationIcon(context: context)
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.only(bottom: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/img-requests-recieved-request1 (1).png'),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeNav(
                                navIndex: 3,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin Name',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              'admin@email.com',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          AppUtils.DarkColor.withOpacity(0.7)),
                            ),
                            // Text(
                            //   '+237 673-827-298',
                            //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            //       fontWeight: FontWeight.w600,
                            //       color: AppUtils.DarkColor.withOpacity(0.4), fontSize: 10),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.person_outline,
                      color: AppUtils.DarkColor.withOpacity(0.7),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                runAlignment: WrapAlignment.center,
                children: [
                  categoryCard('Products', Icons.shopping_cart, 24,
                      borderLRSide: BorderLeftOrRight.right),
                  categoryCard('Clients', Icons.supervised_user_circle, 16,
                      borderLRSide: BorderLeftOrRight.left,
                      navTo: HomeNav(
                        navIndex: 2,
                      )),
                  categoryCard('Invoices', Icons.assignment, 08,
                      borderLRSide: BorderLeftOrRight.right,
                      navTo: ClientInvoices()),
                  categoryCard('Notifications', Icons.notifications, 03,
                      borderLRSide: BorderLeftOrRight.left,
                      navTo: Notifications()),
                  categoryCard('Users', Icons.people, 07,
                      borderLRSide: BorderLeftOrRight.right,
                      width: double.infinity),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryCard(String title, IconData icon, int count,
      {double? width, BorderLeftOrRight? borderLRSide, Widget? navTo}) {
    return GestureDetector(
      onTap: () {
        if (navTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navTo),
          );
        }
      },
      child: Container(
        height: 140,
        constraints: BoxConstraints(
            minWidth: width ?? MediaQuery.of(context).size.width * 0.5),
        decoration: BoxDecoration(
          color: AppUtils.White,
          border: Border(
              top: BorderSide(color: AppUtils.SecondaryGray.withOpacity(0.3)),
              bottom:
                  BorderSide(color: AppUtils.SecondaryGray.withOpacity(0.3)),
              left: borderLRSide == BorderLeftOrRight.left
                  ? BorderSide(color: AppUtils.SecondaryGray.withOpacity(0.3))
                  : BorderSide.none,
              right: borderLRSide == BorderLeftOrRight.right
                  ? BorderSide(color: AppUtils.SecondaryGray.withOpacity(0.3))
                  : BorderSide.none),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppUtils.DarkColor.withOpacity(0.4),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppUtils.DarkColor.withOpacity(0.6),
                  fontWeight: FontWeight.w700),
            ),
            Text(
              '$count',
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppUtils.DarkColor),
            )
          ],
        ),
      ),
    );
  }
}
