import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left,
                color: AppUtils.White,
                size: 30,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "Notifications",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Container(
        // constraints: BoxConstraints(minHeight: 200, maxWidth: 250),
        height: MediaQuery.of(context).size.height,
        // margin: EdgeInsets.only(top: 40, right: 35),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            color: AppUtils.White,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: AppUtils.SecondaryGray.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 0.5)
            ]),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10,),
            
              Column(
                children: [
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                  notificationItem(context,
                      'New Product request has been orderer', '2 hours ago'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationItem(BuildContext context, String message, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppUtils.SecondaryGray.withOpacity(
              0.5,
            ),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.receipt,
            size: 35,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  // softWrap: true,
                  maxLines: 2,

                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 11,
                        color: AppUtils.SecondaryGray.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
