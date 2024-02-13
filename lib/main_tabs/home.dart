import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Icon(
              Icons.notifications_outlined,
              color: AppUtils.White,
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              runAlignment: WrapAlignment.center,
              children: [
                categoryCard('Products', Icons.shopping_cart_outlined, 24),
                categoryCard(
                    'Clients', Icons.supervised_user_circle_outlined, 16),
                categoryCard('Invoices', Icons.assignment_outlined, 08),
                categoryCard('Notifications', Icons.notifications_outlined, 03),
                categoryCard('Users', Icons.people_outline, 07),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget categoryCard(String title, IconData icon, int count) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 17, 255, 25).withOpacity(0.3),
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 17, 255, 25).withOpacity(0.6),
          Color.fromARGB(255, 17, 255, 25).withOpacity(0.1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        // border: Border.all(width: 3, color: AppUtils.SecondaryGray),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            '$count',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
