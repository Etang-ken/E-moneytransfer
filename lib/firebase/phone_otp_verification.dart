import 'dart:convert';

import 'package:elcrypto/provider/phone_otp.dart';
import 'package:elcrypto/provider/phone_otp.dart';
import 'package:elcrypto/provider/phone_otp.dart';
import 'package:elcrypto/provider/phone_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final storage = FlutterSecureStorage();

class OtpVerification extends ChangeNotifier {
  sendOtp(
    BuildContext context,
    String phone_number,
  ) async {
    PhoneOTPProvider _otpProvider =
        Provider.of<PhoneOTPProvider>(context, listen: false);
    await auth.verifyPhoneNumber(
      phoneNumber: phone_number,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        _otpProvider.updatePhoneNumber(phone_number);
        final response = await auth.signInWithCredential(phoneAuthCredential);
        print("otp response: $response");
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print("e.code: ${e}");
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _otpProvider.updateVerificationId(verificationId);
        _otpProvider.updatePhoneNumber(phone_number);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => VerifyNumber(
        //             verifyType: verificationType,
        //           )),
        // );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp(String code, BuildContext context) async {
    PhoneOTPProvider _otpProvider =
        Provider.of<PhoneOTPProvider>(context, listen: false);
    try {
      print(
          "current credential ${_otpProvider.otpCreds['verificationId']} code $code");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _otpProvider.otpCreds['verificationId']!,
          smsCode: code.trim());

      await auth.signInWithCredential(credential);
      return 200;
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        // Display an error message to the user indicating that the OTP is incorrect.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Incorrect OTP'),
              content:
                  Text('The OTP you entered is incorrect. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle other errors as needed.
        // You can display a generic error message or take other actions.
      }
      return 500;
      // You can display an error message to the user or perform other actions.
    }
  }
}
