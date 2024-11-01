import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:elcrypto/api/request.dart';
import 'package:elcrypto/api/url.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elcrypto/helper/validator.dart';
import 'package:elcrypto/home_nav.dart';
import 'package:elcrypto/screens/widgets/notification_icon.dart';
import 'package:elcrypto/provider/user.dart';
import 'package:elcrypto/widgets/primary_button.dart';
import 'package:elcrypto/widgets/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  void updateUserData(BuildContext ctx) async {
    setState(() {
      isLoading = true;
    });
    final hasConnectivity = await hasInternetConnectivity(ctx);
    if (!hasConnectivity) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    var data = {
      'first_name': firstNameController.text,
      'lsat_name': lastNameController.text,
      'email': emailController.text
    };

    final response = await APIRequest()
        .postRequest(route: "/profile/update_profile", data: data);
    if (response == "error") {
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Network error. Please try again.');
    } else {
      final decodedResponse = response;
      if (decodedResponse["success"]) {
        final userData = decodedResponse['user'];
        await updateSharedPreference(userData);

        updateUserProvider(userData, context);

        AppUtils.showSnackBar(
            context, ContentType.success, decodedResponse["message"]);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeNav(),
          ),
          (route) => false,
        );
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, decodedResponse["message"]);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getfirstname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('lastName'));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      getfirstname();

      firstNameController.text = userProvider.userData.firstName ?? '';
      lastNameController.text = userProvider.userData.lastName ?? '';
      emailController.text = userProvider.userData.email ?? '';
      phoneController.text = userProvider.userData.phone ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Consumer<UserProvider>(builder: (_, data, __) {
        final userData = data.userData;
        return Scaffold(
          backgroundColor: AppUtils.SecondaryGrayExtraLight,
          appBar: AppBar(
            backgroundColor: AppUtils.PrimaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: AppUtils.White,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Edit Profile",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                NotificationIcon(context: context)
              ],
            ),
          ),
          body: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone Number *',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              TextInputField(
                                placeholderText: '+237653251366',
                                inputController: phoneController,
                                enabled: false,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Full Names *',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              TextInputField(
                                placeholderText: 'John ...',
                                inputController: firstNameController,
                                inputValidator: (val) {
                                  if (val!.isEmpty) {
                                    return 'First Name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextInputField(
                                placeholderText: 'Doe ...',
                                inputController: lastNameController,
                                inputValidator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Last Name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Email',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              TextInputField(
                                placeholderText: 'admin@email.com ...',
                                textInputType: TextInputType.emailAddress,
                                inputController: emailController,
                                inputValidator: (val) {
                                  if (val!.isNotEmpty) {
                                    if (!isEmailValid(val)) {
                                      return 'Must be a valid email';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),

                            ],
                          ),
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: const BoxDecoration(
                      color: AppUtils.TertiaryExtraLight,
                    ),
                    child: PrimaryButton(
                      buttonText: 'Save Changes',
                      onClickBtn: () {
                        if (_formKey.currentState!.validate()) {
                          updateUserData(context);
                        }
                      },
                    ),
                  ),
                ),
                if (isLoading) showIsLoading()
              ],
            ),
          ),
        );
      }),
    );
  }
}
