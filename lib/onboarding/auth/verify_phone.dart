import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/onboarding/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../helper/custom_snack_bar.dart';
import '../../helper/session_manager.dart';
import '../../helper/shared_preference.dart';
import '../../home_nav.dart';
import '../../models/user.dart';
import 'login.dart';

class ProfileVerifyPhone extends StatefulWidget {
  static const routeName = "/verify_phone";
  final verificationId;
  final phone_number;
  final user;

  ProfileVerifyPhone(
      {required this.verificationId, this.phone_number, this.user});

  @override
  _ProfileVerifyPhoneState createState() => new _ProfileVerifyPhoneState();
}

class _ProfileVerifyPhoneState extends State<ProfileVerifyPhone> {
  String code = '';

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

  verifyPhone() {
    fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
    fb.AuthCredential credential = fb.PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: code);

    auth.signInWithCredential(credential).catchError((error) {
      Navigator.pop(context);
      var data = {
        "title": "Something went wrong",
        "message": "Request failed, Please try again !!",
      };
      Navigator.of(context).pop();
      final snackBar = customSnackBar(
          context: context, type: ContentType.failure, data: data);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }).then((value) async {
      // Navigator.pop(context);
      // AppUtils().showProgressDialog(context);
      final response = await User.registerUser(widget.user);
      if (response.statusCode == 201) {
        Map data = json.decode(response.body);
        Map user = data['user'];
        String token = data['token'];
        saveUser(user, token);


        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeNav()),
                (Route<dynamic> route) => false);

        final snackBar = customSnackBar(
            context: context, type: ContentType.success, data: data);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 409) {
        Map data = json.decode(response.body);
        final snackBar = customSnackBar(
            context: context, type: ContentType.failure, data: data);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } else if (response.statusCode == 500) {
        Map data = json.decode(response.body);
        final snackBar = customSnackBar(
            context: context, type: ContentType.failure, data: data);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register()));
      } else {
        var data = {
          "title": "Something went wrong",
          "message": "Request failed, Please try again !!",
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

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var phoneHeight = mediaQuery.size.height;
    var phoneWidth = mediaQuery.size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                                verifyPhone();
                              },
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 30.0, vertical: 15)),
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
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ))),
    );
  }
}
