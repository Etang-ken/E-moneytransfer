import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'custom_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AppUtils {
  static const Color PrimaryColor = Color(0xff019F01);
  static Color PrimaryLight = Color(0xffEAE3E8);
  static Color GreenColor = Color(0xff019F01);
  static Color YellowColor = Color(0xffFF9719);
  static const Color AccentColor = Color(0xFFFF6908);
  static const Color DarkColor = Color(0xFF212121);
  static const Color PaleGreenColor = Color(0xFF33CCAA);
  static const Color RedColor = Color(0xFFEC0000);
  static const Color SecondaryGray = Color(0xFF868686);
  static const Color PalePink = Color.fromRGBO(252, 228, 236, 1);
  static const Color TertiaryExtraLight = Color.fromARGB(255, 222, 244, 253);
  static Color Secondary = Color(0xFF696969);
  static Color SecondaryGrayExtraLight = Color(0xFFE4E4E4);
  static Color White = Color(0xFFFFFFFF);

  static showSnackBar(BuildContext context, ContentType type, String message) {
    final snackBar = customSnackBar(
        context: context, data: {"message": message}, type: type);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showToast(Color color, String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  // final SessionManager ss = new SessionManager();
  showProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).backgroundColor,
                    color: Color(0xffFEDD1F),
                    strokeWidth: 4,
                    // value: 0.4,
                  ),
                ),
              ));
        });
  }

  showFilterDialog(BuildContext context, widget) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Center(
            child: AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select filters to apply',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              content: widget,
              // actions: [
              //   TextButton(
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       child: Text(
              //         "Done",
              //         style: Theme.of(context).textTheme.headline4,
              //       )),
              // ],
            ),
          );
        });
  }
}
