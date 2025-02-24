import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:emoneytransfer/api/url.dart';
import 'package:emoneytransfer/onboarding/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:emoneytransfer/api/request.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/helper/validator.dart';
import 'package:emoneytransfer/home_nav.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';
import 'package:emoneytransfer/widgets/text_field.dart';
// import 'package:url_launcher/url_launcher.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => new _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  bool isLoading = false;
  bool showInvalidCreds = false;
  final storage = FlutterSecureStorage();

  Map<String, String> formData = {
    'phone': '',
    'password': '',
  };

  void loginUser() async {
    setState(() {
      isLoading = true;
      showInvalidCreds = false;
    });

    final hasConnectivity = await hasInternetConnectivity(context);
    final phone = phoneController.text;
    final password = passwordController.text;
    if (hasConnectivity) {
      final data = {'phone': phone, 'password': password};
      final response =
      await APIRequest().postRequest(route: '/login', data: data);

      if (response == "error") {
        AppUtils.showSnackBar(
            context,
            ContentType.failure,
            'Network error. Please try again.'
        );
      }
      else {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse["success"]) {
          final userData = decodedResponse['user'];
          AppUtils.showSnackBar(
              context,
              ContentType.success,
              decodedResponse["message"]
          );
          await storage.write(
              key: 'authToken', value: decodedResponse['token']);
          await updateSharedPreference(userData);

          updateUserProvider(userData, context);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNav(),
            ),
                (route) => false,
          );
        } else {
          showInvalidCreds = true;
          AppUtils.showSnackBar(
              context,
              ContentType.failure,
              decodedResponse["message"]
          );
        }
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 35),
                      constraints: const BoxConstraints(minHeight: 245),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/top_bg.png',
                              ),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/logo/elcrypto.png',
                                height: 150,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Welcome',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Login into your ElCrypto account...',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  color:
                                  AppUtils.DarkColor.withOpacity(0.6),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Stack(
                              children: [
                                TextInputField(
                                  placeholderText: 'Phone Number *',
                                  inputController: phoneController,
                                  textInputType: TextInputType.number,
                                  onChanged: (value) {},
                                  contentPadding: const EdgeInsets.only(
                                      left: 45, top: 17, bottom: 17),
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Phone Number is Required';
                                    }
                                    return null;
                                  },
                                ),
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Icon(
                                        Icons.call_outlined,
                                        color:
                                        AppUtils.DarkColor.withOpacity(0.8),
                                      )),
                                ),
                              ],
                            ),
                            if (showInvalidCreds)
                              Container(
                                margin: EdgeInsets.only(bottom: 10, top: 5),
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: AppUtils.RedColor,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Invalid Credentials.',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                        fontSize: 11,
                                        color: AppUtils.RedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                TextInputField(
                                  placeholderText: 'Password *',
                                  inputController: passwordController,
                                  onChanged: (value) {},
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Password is Required';
                                    }
                                    if (val.length < 6) {
                                      return 'Password must contain atleast 6 characters.';
                                    }
                                    return null;
                                  },
                                  hideText: showPassword,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 17),
                                ),
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Icon(
                                        Icons.lock_outline_rounded,
                                        color:
                                        AppUtils.DarkColor.withOpacity(0.8),
                                      )),
                                ),
                                Positioned(
                                  right: 3,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, top: 15),
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
                                          color: AppUtils.DarkColor.withOpacity(
                                              0.7),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                final Uri url = Uri.parse(AppUrl.appUrl+"admin/forget-password"); // Replace with your desired URL
                                launchInApp(url);
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'Forgot Password ?',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                            PrimaryButton(
                              buttonText: 'Login',
                              onClickBtn: () {
                                if (_formkey.currentState!.validate()) {
                                  loginUser();
                                  print("Invalid form Data");
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 12),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register()));
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                        fontSize: 12,
                                        color: AppUtils.PrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            if (isLoading) showIsLoading()
          ],
        ),
      ),
    );
  }
}
