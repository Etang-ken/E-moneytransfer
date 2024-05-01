import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:emoneytransfer/api/url.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/home_nav.dart';
import 'package:emoneytransfer/screens/detail_screens/change_password.dart';
import 'package:emoneytransfer/screens/detail_screens/edit_profile.dart';
import 'package:emoneytransfer/screens/widgets/notification_icon.dart';
import 'package:emoneytransfer/provider/user.dart';
import 'package:emoneytransfer/widgets/general_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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

  Future<void> _saveImage() async {
    if (_imageFile != null) {
      setState(() {
        isLoading = true;
      });

      var uri = Uri.parse("${AppUrl.baseUrl}/profile/save_profile_image");
      var request = http.MultipartRequest('POST', uri);
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'authToken');

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-type'] = 'application/json';
        request.headers['Accept'] = 'application/json';
      }

      var file = await http.MultipartFile.fromPath('profile', _imageFile!.path);
      request.files.add(file);
      print(_imageFile!.path);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);
        await updateSharedPreference(user['user']);

        setState(() {
          isLoading = false;
        });

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => HomeNav(
                  navIndex: 1,
                )),
          ),
        );
        AppUtils.showSnackBar(
          context,
          ContentType.success,
          'Profile picture updated successfully.',
        );
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.body);
        if (!mounted) return;
        AppUtils.showSnackBar(
          context,
          ContentType.failure,
          'Error changing profile picture',
        );
      }
      setState(() {
        isLoading = false;
      });
    } else {
      AppUtils.showSnackBar(context, ContentType.failure,
          'No image has been uploaded, please upload one.');
    }
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, data, __) {
      final userData = data.userData;
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppUtils.SecondaryGrayExtraLight,
            appBar: AppBar(
              backgroundColor: AppUtils.PrimaryColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Settings",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.white),
                  ),
                  NotificationIcon(context: context)
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppUtils.White,
                              image: _imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(
                                        File(_imageFile!.path),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : userData.profileUrl == ''
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/user-profile-avatar@3x-1.png'),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(
                                              userData.profileUrl ?? ''),
                                          fit: BoxFit.fill),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Center(
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppUtils.White,
                                  ),
                                  child: const Icon(Icons.edit_outlined,
                                      color: AppUtils.PrimaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      userData.name ?? '',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    IntrinsicWidth(
                      child: GeneralButton(
                        buttonText: 'Change Profile Photo',
                        btnTextColor: AppUtils.PrimaryColor,
                        borderColor: AppUtils.PrimaryColor,
                        btnBgColor: AppUtils.White,
                        iconPosition: IconPosition.left,
                        btnIcon: const Icon(Icons.insert_photo),
                        onClickBtn: _saveImage,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    Column(
                      children: [
                        // profileModificationLink(
                        //     'Profile', Icons.person_outlined,
                        //     navTo: const EditProfile()),
                        profileModificationLink(
                            'Edit Profile', Icons.edit_outlined,
                            navTo: const EditProfile()),
                        profileModificationLink(
                            'Change Password', Icons.lock_outline,
                            navTo: const ChangePassword()),
                        profileModificationLink(
                            'Contact Us', Icons.phone_outlined,
                            browseTo: "https://google.com"),
                        profileModificationLink('FAQs', Icons.help_outline,
                            browseTo: "https://google.com"),
                        profileModificationLink(
                            'Privacy Policy', Icons.privacy_tip_outlined,
                            browseTo: "https://google.com"),
                        profileModificationLink(
                            'Terms and Conditions', Icons.description_outlined,
                            browseTo: "https://google.com"),
                        profileModificationLink('Logout', Icons.logout,
                            onClick: () async{
                          await appLogOut(context);
                            }),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) showIsLoading()
        ],
      );
    });
  }

  Widget profileModificationLink(
    String title,
    IconData icon, {
    Widget? navTo,
    String? browseTo,
        VoidCallback? onClick
  }) {
    return GestureDetector(
      onTap: () {
        if (navTo != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => navTo),
          );
        }
        if (browseTo != null) {
          final Uri url = Uri.parse(browseTo);

          launchInApp(url);
        }
        if(onClick != null) {
          onClick();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppUtils.White,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppUtils.PrimaryColor,
                  size: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
