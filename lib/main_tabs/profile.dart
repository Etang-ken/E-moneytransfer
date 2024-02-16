import 'dart:io';

import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/main_tabs/detail_screens/change_password.dart';
import 'package:truelife_mobile/main_tabs/detail_screens/edit_profile.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/widgets/general_button.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ImagePicker _imagePicker;
  XFile? _imageFile;

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.SecondaryGrayExtraLight,
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white),),
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
                            : const DecorationImage(
                                image: AssetImage(
                                    'assets/images/user-profile-avatar@3x-1.png'),
                                fit: BoxFit.cover,
                              ),
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
                'Admin Name',
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
                  onClickBtn: _pickImage,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              
              Column(
                children: [
                  profileModificationLink('Edit Profile', Icons.edit, navTo: const EditProfile()),
                  profileModificationLink(
                      'Change Password', Icons.lock_outline, navTo: const ChangePassword()),
                ],
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileModificationLink(String title, IconData icon, {Widget? navTo}) {
    return GestureDetector(
      onTap: () {
        if (navTo != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => navTo),
          );
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
