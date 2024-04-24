import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/widgets/general_button.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';
import 'package:emoneytransfer/widgets/text_field.dart';

class AddNewClient extends StatefulWidget {
  final BuildContext ctx;

  AddNewClient({required this.ctx});

  @override
  State<AddNewClient> createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  bool showPassword = true;
  late ImagePicker _clientImagePicker;
  XFile? _clientImageFile;

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await _clientImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _clientImageFile = pickedImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _clientImagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: IntrinsicHeight(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: BoxDecoration(
              color: AppUtils.White,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person,
                              color: AppUtils.DarkColor,
                            ),
                            const SizedBox(width: 13),
                            Text(
                              'Add New Client',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Name',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(placeholderText: 'PHS ...'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: _clientImageFile != null
                                      ? DecorationImage(
                                          image: FileImage(
                                              File(_clientImageFile!.path)),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image: AssetImage('assets/images/user-profile-avatar@3x-1.png'),
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('Choose Image', style: Theme.of(context).textTheme.bodyText1,)
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text('Client Admin Details',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6),
                        const SizedBox(height: 10),
                        Text(
                          'UserName',
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
                          'Email',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(placeholderText: 'admin@email.com ...', textInputType: TextInputType.emailAddress,),
                        const SizedBox(height: 10),
                        Text(
                          'Password',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        Stack(
                          children: [
                            TextInputField(
                              placeholderText: 'Password',
                              hideText: showPassword,
                              contentPadding: const EdgeInsets.only(
                                  right: 45, top: 17, bottom: 17, left: 12),
                            ),
                            Positioned(
                              right: 3,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, top: 15),
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
                                      size: 25,
                                      color:
                                          AppUtils.DarkColor.withOpacity(0.8),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          buttonText: 'Add Client',
                          onClickBtn: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GeneralButton(
                          buttonText: 'Close',
                          btnBgColor: AppUtils.SecondaryGray.withOpacity(0.2),
                          borderColor: AppUtils.SecondaryGrayExtraLight,
                          btnTextColor: AppUtils.DarkColor,
                          onClickBtn: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
