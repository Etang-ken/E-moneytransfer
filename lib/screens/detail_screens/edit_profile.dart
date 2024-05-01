import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:emoneytransfer/api/request.dart';
import 'package:emoneytransfer/api/url.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoneytransfer/helper/validator.dart';
import 'package:emoneytransfer/home_nav.dart';
import 'package:emoneytransfer/screens/widgets/notification_icon.dart';
import 'package:emoneytransfer/provider/user.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';
import 'package:emoneytransfer/widgets/text_field.dart';
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
  late ImagePicker _imagePicker;
  XFile? _imageFile;
  bool isLoading = false;

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedImage;
    });
  }

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
    if (_imageFile != null) {
      var uri = Uri.parse(
          "${AppUrl.baseUrl}/user/update"); // Replace with your API endpoint
      var request = http.MultipartRequest('POST', uri);
      request.fields['first_name'] = firstNameController.text;
      request.fields['last_name'] = lastNameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['email'] = emailController.text;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'authToken');

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-type'] = 'application/json';
        request.headers['Accept'] = 'application/json';
      }

      var file = await http.MultipartFile.fromPath('image', _imageFile!.path);
      request.files.add(file);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);
        await updateSharedPreference(user['user']);
        updateUserProvider(user['user'], context);
        print(user['user']);

        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: ((context) => HomeNav(
                  navIndex: 3,
                )),
          ),
        );
        AppUtils.showSnackBar(
            ctx, ContentType.success, 'Profile updated successfully.');
      } else {
        setState(() {
          isLoading = false;
        });

        print("result: ${response.body}");
        AppUtils.showSnackBar(
            ctx, ContentType.failure, 'Network Error, please try again.');
      }
    } else {
      var data = {
        'first_name': firstNameController.text,
        'lsat_name': lastNameController.text,
        'phone': phoneController.text,
        'email': emailController.text
      };
      final currentContext = ctx;
      final result =
          await APIRequest().postRequest(route: "/user/update", data: data);
      if (result.statusCode == 200) {
        var user = jsonDecode(result.body);
        await updateSharedPreference(user['user']);
        if (!mounted) return;
        updateUserProvider(user['user'], context);
        setState(() {
          isLoading = false;
        });

        if (!mounted) return;
        Navigator.push(
          currentContext,
          MaterialPageRoute(
            builder: ((context) => HomeNav(
                  navIndex: 3,
                )),
          ),
        );
        AppUtils.showSnackBar(
          ctx,
          ContentType.success,
          'Profile updated successfully.',
        );
      } else {
        print(result.body);
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        AppUtils.showSnackBar(
          ctx,
          ContentType.failure,
          'Network Error, please try again.',
        );
      }
    }
  }

  Future<void> getfirstname() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('lastName'));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermission();

      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      getfirstname();

      firstNameController.text = userProvider.userData.firstName ?? '';
      lastNameController.text = userProvider.userData.lastName ?? '';
      emailController.text = userProvider.userData.email ?? '';
      phoneController.text = userProvider.userData.phone ?? '';
    });
  }
  Future<void> requestPermission() async {
    var status = await Permission.photos.request();
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
                          .headline4
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
                          constraints: const BoxConstraints(minHeight: 400),
                          decoration: BoxDecoration(
                              color: AppUtils.White,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Names *',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
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
                                    .bodyText1!
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
                              Text(
                                'Phone Number *',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              TextInputField(
                                placeholderText: '+237 698 938 982 ...',
                                textInputType: TextInputType.phone,
                                inputController: phoneController,
                                inputValidator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Phone Number is required';
                                  }
                                  if (val.length < 9) {
                                    return 'Phone must contain atleast 9 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 115),
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
