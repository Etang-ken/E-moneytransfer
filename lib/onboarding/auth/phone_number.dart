import 'dart:async';
import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helper/app_utils.dart';
import '../../helper/authenticate.dart';

class ProfilePhoneNumber extends StatefulWidget {
  static const routeName = "/phone";

  final Map? user;

  ProfilePhoneNumber({this.user});

  @override
  _ProfilePhoneNumberState createState() => new _ProfilePhoneNumberState();
}

class _ProfilePhoneNumberState extends State<ProfilePhoneNumber> {
  String phone = '';
  String county_code = "+1";
  dynamic userData;

  @override
  void initState() {
    super.initState();
  }

  onVerifyPhone() async {
    phone = (county_code + phone).trim();
    widget.user!['phone_number'] = phone;
    userData = widget.user;
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
          leading: IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          width: phoneWidth,
          height: phoneHeight,
          alignment: Alignment.center,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.symmetric(horizontal: phoneWidth * 0.05),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Verify your \nphone number",
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: Text(
                          "We’ll send a verification code to confirm it’s you.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(children: [
                        Text(
                          "Phone Number",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ]),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffEAE3E8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        height: 50,
                        child: Row(
                          children: [
                            CountryCodePicker(
                              onChanged: (element) {
                                  county_code = element.dialCode!;
                              },
                              initialSelection: 'US',
                              showCountryOnly: false,
                              // enabled: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                            Expanded(
                                child: TextFormField(
                              onChanged: ((value) => phone = value),
                              style: TextStyle(fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                hintText: "123 456 7890",
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                              ),
                              keyboardType: TextInputType.number,
                            ))
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 40),
                        child: TextButton(
                          onPressed: () {
                            String p = county_code + phone;
                            log("phone number t verify $p");
                            widget.user!['phone'] = p;
                            userData = widget.user;
                            // firebase
                            AppUtils().showProgressDialog(context);
                            Authenticate().onVerifyPhone(
                                context,  p ,  this.userData);
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 70.0, vertical: 10)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                              // alignment: AlignmentGeometry.,

                              backgroundColor:
                                  MaterialStateProperty.all(AppUtils.PrimaryColor)),
                          child: Text(
                            "Send Code",
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
