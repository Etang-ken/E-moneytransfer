import 'package:eltransfer/helper/app_utils.dart';
import 'package:eltransfer/screens/widgets/notification_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.SecondaryGrayExtraLight,
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  "FAQs",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            NotificationIcon(context: context)
          ],
        ),
      ),
    );
  }
}
