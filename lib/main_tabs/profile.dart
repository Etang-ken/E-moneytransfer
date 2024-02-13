import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppUtils.PrimaryColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile",
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
        body: Container()
    );
  }
}