import 'package:flutter/material.dart';

class PhoneOTPProvider extends ChangeNotifier {
  final otpCreds = {
    "phoneNumber": "",
    "verificationId": "",
    "userToken": ""
  };

  void updatePhoneNumber(String phoneNumber) {
    otpCreds['phoneNumber'] = phoneNumber;
    notifyListeners();
  }

  void updateVerificationId(String verificationId) {
    otpCreds['verificationId'] = verificationId;
    notifyListeners();
  }
}