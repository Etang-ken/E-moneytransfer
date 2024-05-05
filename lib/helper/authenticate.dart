import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/helper/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../api/request.dart';
import '../home_nav.dart';
import '../models/user.dart';
import '../onboarding/auth/verify_phone.dart';
import 'app_utils.dart';
import 'custom_snack_bar.dart';

class Authenticate {
  onVerifyPhone(BuildContext context, String phone_number, dynamic userData) {
    fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: phone_number,
      codeSent: (verificationId, forceResendingToken) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVerifyPhone(
                  phone_number: phone_number,
                  verificationId: verificationId,
                  user: userData)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
      verificationCompleted: (fb.AuthCredential authCredential) async {
        Navigator.pop(context);
        AppUtils().showProgressDialog(context);
        final response =
            await APIRequest().postRequest(route: '/register', data: userData);
        if (response != 'error') {
          Map user = response['user'];
          String token = response['token'];
          saveUser(user, token);
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeNav()),
              (Route<dynamic> route) => false);
        } else {
          var data = {
            "title": "Something went wrong",
            "message": "Something went wrong",
          };
          Navigator.of(context).pop();
          final snackBar = customSnackBar(
              context: context, type: ContentType.failure, data: data);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      verificationFailed: (authException) {
        Navigator.pop(context);
        print(authException.message ?? "Something went wrong");
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oooopppss..',
            message: authException.message ?? "verification failed",
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
    );
  }

  Authenticate();

  verifyPhone(BuildContext context, String verificationId, String code,
      dynamic userData) {
    fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
    fb.AuthCredential credential = fb.PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);

    auth.signInWithCredential(credential).catchError((error) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oooopppss..',
          message: error.message ?? "Something went wrong",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }).then((value) async {
      Navigator.pop(context);
      AppUtils().showProgressDialog(context);

      final response =
          await APIRequest().postRequest(route: '/register', data: userData);

      if (response != 'error') {
        Map user = response['user'];
        String token = response['token'];
        saveUser(user, token);
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeNav()),
            (Route<dynamic> route) => false);
      } else {
        var data = {
          "title": "Something went wrong",
          "message": "Something went wrong",
        };
        Navigator.of(context).pop();
        final snackBar = customSnackBar(
            context: context, type: ContentType.failure, data: data);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    });
  }
}
