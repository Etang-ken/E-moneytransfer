import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/home_nav.dart';
import 'package:truelife_mobile/widgets/primary_button.dart';
import 'package:truelife_mobile/widgets/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => new _LogInState();
}

class _LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;

  Map<String, String> formData = {
    'phone': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
  }

  submitForm() {
    if (!formKey.currentState!.validate()) {
      return "form data invalid";
    }
    if (formKey.currentState != null) {
      formKey.currentState!.save();
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 35),
                constraints: BoxConstraints(minHeight: 245),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/top_blue_bg.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_circle_left_rounded)),
                    ),
                    const Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Icon(
                          Icons.home,
                          size: 50,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Login into your Pro4Home account...',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: AppUtils.DarkColor.withOpacity(0.6),
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Stack(
                        children: [
                          TextInputField(
                            placeholderText: 'Email',
                            textInputType: TextInputType.phone,
                            onChanged: (value) {
                              formData['phone'] = value ?? "";
                            },
                            contentPadding:
                                EdgeInsets.only(left: 45, top: 17, bottom: 17),
                          ),
                          Positioned(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 15),
                                child: Icon(
                                  Icons.call_outlined,
                                  color: AppUtils.DarkColor.withOpacity(0.8),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Stack(
                        children: [
                          TextInputField(
                            placeholderText: 'Password',
                            onChanged: (value) {
                              formData['password'] = value ?? "";
                            },
                            hideText: showPassword,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 45, vertical: 17),
                          ),
                          Positioned(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 15),
                                child: Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppUtils.DarkColor.withOpacity(0.8),
                                )),
                          ),
                          Positioned(
                            right: 3,
                            child: Padding(
                                padding: EdgeInsets.only(right: 5, top: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(
                                    showPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 27,
                                    color: AppUtils.DarkColor.withOpacity(0.7),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse('https://example.com'); // Replace with your desired URL
                          
                          _launchInBrowser(url);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Forgot Password ?',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 65,
                      ),
                      PrimaryButton(
                        buttonText: 'Login',
                        onClickBtn: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNav(),),);
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
