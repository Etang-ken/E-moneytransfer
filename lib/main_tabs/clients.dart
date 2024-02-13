import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppUtils.PrimaryColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Clients",
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