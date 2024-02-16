import 'dart:io';

import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/widgets/primary_button.dart';
import 'package:truelife_mobile/widgets/text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
                Text("Edit Profile",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.white),),
              ],
            ),
            NotificationIcon(context: context)
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
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
                    height: 25,
                  ),
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
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(placeholderText: 'John Doe ...'),
                        const SizedBox(height: 10),
                        Text(
                          'Email *',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(
                          placeholderText: 'admin@email.com ...',
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phone Number *',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(
                          placeholderText: '+237 698 938 982 ...',
                          textInputType: TextInputType.phone,
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                color: AppUtils.TertiaryExtraLight,
              ),
              child: PrimaryButton(
                buttonText: 'Save Changes',
                onClickBtn: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
