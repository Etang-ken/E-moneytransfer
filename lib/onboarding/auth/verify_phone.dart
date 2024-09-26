import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../api/request.dart';
import '../../helper/app_utils.dart';
import '../../helper/custom_snack_bar.dart';
import '../../helper/session_manager.dart';
import '../../helper/shared_preference.dart';
import '../../home_nav.dart';

class ProfileVerifyPhone extends StatefulWidget {
  static const routeName = "/verify_phone";
  final verificationId;
  final phone_number;
  final user;
  final storage = FlutterSecureStorage();

  ProfileVerifyPhone(
      {required this.verificationId, this.phone_number, this.user});

  @override
  _ProfileVerifyPhoneState createState() => new _ProfileVerifyPhoneState(user);
}

class _ProfileVerifyPhoneState extends State<ProfileVerifyPhone> {
  String code = '';

  dynamic user;

  _ProfileVerifyPhoneState(this.user);

  late bool isFirstTime;
  late bool profile_status;

  @override
  void initState() {
    super.initState();
    SessionManager ss = SessionManager();
    Future<bool> isFirst = ss.isFirstTime();
    isFirst.then((data) {
      isFirstTime = data;
    });

    Future<bool> profileStatus = ss.getProfileStatus();
    profileStatus.then((data) {
      profile_status = data;
    });
  }

  verifyPhone(BuildContext context) {
    setState(() {
      isLoading = true;
    });

    fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
    fb.AuthCredential credential = fb.PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: code);

    auth.signInWithCredential(credential).catchError((error) {


      var data = {
        "title": "error",
        "message": error.message,
      };

      final snackBar = customSnackBar(
          context: context, type: ContentType.failure, data: data);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      setState(() {
        isLoading = false;
      });

    }).then((value) async {
      final response =
          await APIRequest().postRequest(route: '/register', data: user);
      if (response != 'error') {

        if (response['success']) {
          await storage.write(
              key: 'authToken', value: response['token']);
          await updateSharedPreference(response['user']);

          updateUserProvider(response['user'], context);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNav(),
            ),
                (route) => false,
          );
        } else {
          var data = {
            "title": "Something went wrong",
            "message": response['message'],
          };

          final snackBar = customSnackBar(
              context: context, type: ContentType.failure, data: data);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

        }
      } else {
        var data = {
          "title": "Something went wrong",
          "message": "Something went wrong",
        };

        final snackBar = customSnackBar(
            context: context, type: ContentType.failure, data: data);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var phoneHeight = mediaQuery.size.height;
    var phoneWidth = mediaQuery.size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
              ),
              body: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  width: phoneWidth,
                  height: phoneHeight,
                  alignment: Alignment.center,
                  child: Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: phoneWidth,
                        padding:
                        EdgeInsets.symmetric(horizontal: phoneWidth * 0.05),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Verify Phone Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Enter the 6 - digit verification code we sent to phone number ${widget.phone_number}',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 30),
                              PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: AppUtils.PrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                obscureText: false,
                                blinkWhenObscuring: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    selectedColor: AppUtils.PrimaryColor,
                                    inactiveColor: AppUtils.PrimaryColor,
                                    activeColor: AppUtils.PrimaryColor),
                                animationDuration: Duration(milliseconds: 300),
                                keyboardType: TextInputType.number,
                                onCompleted: (v) {},
                                onChanged: (value) {
                                  code = value;
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: phoneWidth * 0.1),
                                child: TextButton(
                                  onPressed: () {
                                    verifyPhone(context);
                                  },
                                  style: ButtonStyle(
                                      padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 30.0,
                                              vertical: 10)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          )),
                                      // alignment: AlignmentGeometry.,

                                      backgroundColor: MaterialStateProperty.all(
                                          AppUtils.PrimaryColor)),
                                  child: Text(
                                    "Verify",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ))
          ),
          if (isLoading) showIsLoading()
        ],
      ),
    );
  }
}
