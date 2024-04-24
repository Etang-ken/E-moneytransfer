import 'package:flutter/material.dart';
import 'package:emoneytransfer/helper/app_utils.dart';

class NotificationIcon extends StatefulWidget {
  final BuildContext context;

  NotificationIcon({required this.context});
  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Clicked!!!');
        showDialog(
            context: context,
            // barrierDismissible: true,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return NotificationDialog();
              // return Container(
              //   height: 60,
              //   width: 100,
              //   color: Colors.white,
              // );
            });
      },
      child: Container(
        width: 40,
        height: 40,
        child: Stack(
          children: [
            Positioned(
              // bottom: 0,
              child: Center(
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppUtils.White,
                ),
              ),
            ),
            Positioned(
              // bottom: 30,
              top: 3,
              right: 5,
              child: Container(
                height: 17,
                // width: 17,
                constraints: const BoxConstraints(minWidth: 17),
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppUtils.RedColor,
                    borderRadius: BorderRadius.circular(19)),
                child: Text(
                  '02',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: AppUtils.White,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicHeight(
        child: Container(
            constraints: BoxConstraints(minHeight: 200, maxWidth: 250),
            margin: EdgeInsets.only(top: 40, right: 35),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 10,),
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                         notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                         notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                        notificationItem(context, 'New Product request has been orderer', '2 hours ago'),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget notificationItem(BuildContext context, String message, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
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
                      .copyWith(fontSize: 13),
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 10,
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
