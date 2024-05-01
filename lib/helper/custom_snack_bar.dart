import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:elcrypto/helper/app_utils.dart';

customSnackBar(
    {required BuildContext context,
    required dynamic data,
    required ContentType type}) {
  ContentType test = type;

  final snackBar = SnackBar(
      elevation: 100,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Color(0x00F8FCFF),
      duration: Duration(seconds: 5),
      content: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 234, 239, 243),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  test == ContentType.failure
                      ? Icons.cancel
                      : (test == ContentType.warning)
                          ? Icons.info
                          : Icons.check_circle,
                  color: test == ContentType.failure
                      ? AppUtils.RedColor
                      : (test == ContentType.warning)
                          ? AppUtils.YellowColor
                          : AppUtils.PrimaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  data['message'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w400),
                  maxLines: 5,
                )),
              ],
            )),
      ));

  return snackBar;
}
