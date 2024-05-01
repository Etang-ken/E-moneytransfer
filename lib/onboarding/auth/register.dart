import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:emoneytransfer/onboarding/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:emoneytransfer/api/request.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/helper/validator.dart';
import 'package:emoneytransfer/home_nav.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';
import 'package:emoneytransfer/widgets/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool hidePassword = true;
  bool hideRepeatPassword = true;
  bool isLoading = false;
  bool phoneNumberTaken = false;
  bool showPasswordsUnmatched = false;
  final storage = FlutterSecureStorage();

  Map<String, String> formData = {
    'phone': '',
    'password': '',
  };

  void registerUser() async {
    setState(() {
      isLoading = true;
      showPasswordsUnmatched = false;
    });

    final hasConnectivity = await hasInternetConnectivity(context);
    final email = emailController.text;
    final password = passwordController.text;
    final repeatPassword = repeatPasswordController.text;
    final phoneNumber = phoneController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    if (password == repeatPassword) {
      if (hasConnectivity) {
        final data = {
          'email': email,
          'phone': phoneNumber,
          'password': password,
          'first_name': firstName,
          'last_name': lastName
        };
        final response =
            await APIRequest().postRequest(route: '/register', data: data);
        final decodedResponse = jsonDecode(response.body);
        print(decodedResponse);
        if (response.statusCode == 200) {
          final userData = decodedResponse['user'];
          setState(() {
            isLoading = false;
          });
          await storage.write(
              key: 'authToken', value: decodedResponse['token']);
          await updateSharedPreference(userData);
          if (!mounted) return;
          updateUserProvider(userData, context);
          print('Successful Registration');
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNav(),
            ),
            (route) => false,
          );
        } else if (response.statusCode == 409) {
          setState(() {
            isLoading = false;
          });
          if (!mounted) return;
          AppUtils.showSnackBar(
            context,
            ContentType.failure,
            'This phone Number has taken, please enter a different phone number.',
          );
          print('Failed login');
          print('user: $decodedResponse');
        } else {
          setState(() {
            isLoading = false;
          });
          if (!mounted) return;
          AppUtils.showSnackBar(
            context,
            ContentType.failure,
            'Network error. Please try again.',
          );
          print('Failed login');
          print('user: $response');
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        showPasswordsUnmatched = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
                            'assets/images/logo/eltransfer.png',
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Create your ElCrypto account...',
                              style: Theme.of(context)
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
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                TextInputField(
                                  placeholderText: 'Phone Number *',
                                  inputController: phoneController,
                                  textInputType: TextInputType.number,
                                  onChanged: (value) {
                                    formData['phone'] = value ?? "";
                                  },
                                  contentPadding: const EdgeInsets.only(
                                      left: 45, top: 17, bottom: 17),
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Phone is Required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
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
                            if (phoneNumberTaken)
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
                                      'Phone number has been taken.',
                                      style: Theme.of(context)
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
                                  placeholderText: 'First Name *',
                                  inputController: firstNameController,
                                  textInputType: TextInputType.emailAddress,
                                  onChanged: (value) {},
                                  contentPadding: const EdgeInsets.only(
                                      left: 45, top: 17, bottom: 17),
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return 'First name is Required';
                                    }
                                    return null;
                                  },
                                ),
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Icon(
                                        Icons.person_2_outlined,
                                        color:
                                            AppUtils.DarkColor.withOpacity(0.8),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                TextInputField(
                                  placeholderText: 'Last Name *',
                                  inputController: lastNameController,
                                  textInputType: TextInputType.emailAddress,
                                  onChanged: (value) {},
                                  contentPadding: const EdgeInsets.only(
                                      left: 45, top: 17, bottom: 17),
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Last Name is Required';
                                    }
                                    return null;
                                  },
                                ),
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Icon(
                                        Icons.person_outline,
                                        color:
                                            AppUtils.DarkColor.withOpacity(0.8),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                TextInputField(
                                  placeholderText: 'Email',
                                  inputController: emailController,
                                  textInputType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    formData['phone'] = value ?? "";
                                  },
                                  contentPadding: const EdgeInsets.only(
                                      left: 45, top: 17, bottom: 17),
                                  inputValidator: (val) {
                                    if (val!.isNotEmpty) {
                                      if (!isEmailValid(val)) {
                                        return 'Invalid email format.';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color:
                                            AppUtils.DarkColor.withOpacity(0.8),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                TextInputField(
                                  placeholderText: 'Password *',
                                  inputController: passwordController,
                                  onChanged: (value) {
                                    formData['password'] = value ?? "";
                                  },
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Password is Required';
                                    }
                                    if (val.length < 6) {
                                      return 'Password must contain atleast 6 characters.';
                                    }
                                    return null;
                                  },
                                  hideText: hidePassword,
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
                                            hidePassword = !hidePassword;
                                          });
                                        },
                                        child: Icon(
                                          hidePassword
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
                            Stack(
                              children: [
                                TextInputField(
                                    placeholderText: 'Repeat Password *',
                                    inputController: repeatPasswordController,
                                    onChanged: (value) {
                                      formData['password'] = value ?? "";
                                    },
                                    inputValidator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Repeat Password is Required';
                                      }
                                      if (val.length < 6) {
                                        return 'Repeat Password must contain atleast 6 characters.';
                                      }
                                      return null;
                                    },
                                    hideText: hideRepeatPassword,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 45, vertical: 17)),
                                Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Icon(Icons.lock_outline_rounded,
                                          color: AppUtils.DarkColor.withOpacity(
                                              0.8))),
                                ),
                                Positioned(
                                  right: 3,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hideRepeatPassword =
                                                !hideRepeatPassword;
                                          });
                                        },
                                        child: Icon(
                                          hideRepeatPassword
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
                            if (showPasswordsUnmatched)
                              Text(
                                'Passwords do not match.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                      color: AppUtils.RedColor,
                                    ),
                              ),
                            const SizedBox(
                              height: 65,
                            ),
                            PrimaryButton(
                              buttonText: 'Register',
                              onClickBtn: () {
                                if (_formkey.currentState!.validate()) {
                                  print('All Good');
                                  registerUser();
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => HomeNav(),
                                  //   ),
                                  //   (route) => false,
                                  // );
                                } else {
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
                                  "Already have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 12),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => LogIn()));
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: Theme.of(context)
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
