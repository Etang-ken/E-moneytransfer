import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/onboarding/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:elcrypto/helper/validator.dart';
import 'package:elcrypto/widgets/primary_button.dart';
import 'package:elcrypto/widgets/text_field.dart';

import '../../api/request.dart';
import '../../helper/custom_snack_bar.dart';
import '../../home_nav.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool hidePassword = true;
  bool isLoading = false;
  bool phoneNumberTaken = false;
  bool showPasswordsUnmatched = false;
  final storage = FlutterSecureStorage();

  Map<String, String> formData = {
    'phone': '',
    'password': '',
  };

  void registerUser(BuildContext context) async {
    setState(() {
      showPasswordsUnmatched = false;
    });

    setState(() {
      isLoading = true;
    });
    final hasConnectivity = await hasInternetConnectivity(context);
    final email = emailController.text;
    final password = passwordController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    if (hasConnectivity) {
      final data = {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName
      };

      final response =
      await APIRequest().postRequest(route: '/register', data: data);
      setState(() {
        isLoading = false;
      });
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
        Navigator.of(context).pop();
        final snackBar = customSnackBar(
            context: context, type: ContentType.failure, data: data);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      setState(() {
        isLoading = false;
        showPasswordsUnmatched = true;
      });
    }
    setState(() {});
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
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              AppUtils.PrimaryColor.withOpacity(0.6),
                              AppUtils.White
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
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
                                  .bodyMedium!
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
                                    formData['email'] = value ?? "";
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
                                      return 'Password must contain at least 6 characters.';
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
                            const SizedBox(
                              height: 65,
                            ),
                            PrimaryButton(
                              buttonText: 'Register',
                              onClickBtn: () {
                                if (_formkey.currentState!.validate()) {
                                  print('All Good');
                                  registerUser(context);
                                } else {
                                  print("Invalid form Data");
                                 }
                              }
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
                                      .bodyMedium!
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
                                          .bodyMedium!
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
