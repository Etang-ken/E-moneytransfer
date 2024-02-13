import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class Institutions extends StatefulWidget {
  const Institutions({super.key});

  @override
  State<Institutions> createState() => _InstitutionsState();
}

class _InstitutionsState extends State<Institutions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppUtils.PrimaryColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Institutions",
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