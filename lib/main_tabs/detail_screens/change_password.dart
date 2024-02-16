import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/widgets/primary_button.dart';
import 'package:truelife_mobile/widgets/text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool showCurrentPassword = true;
  bool showNewPassword = true;
  bool showRepeatPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.White,
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
                  "Change Password",
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                          'Current Password *',
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
                              placeholderText: 'Enter Current Password...',
                              hideText: showCurrentPassword,
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
                                        showCurrentPassword =
                                            !showCurrentPassword;
                                      });
                                    },
                                    child: Icon(
                                      showCurrentPassword
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
                        const SizedBox(height: 15),
                        Text(
                          'New Password *',
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
                              placeholderText: 'Enter New Password...',
                              hideText: showNewPassword,
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
                                        showNewPassword = !showNewPassword;
                                      });
                                    },
                                    child: Icon(
                                      showNewPassword
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
                        const SizedBox(height: 15),
                        Text(
                          'Repeat Password *',
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
                              placeholderText: 'Repeat New Password...',
                              hideText: showRepeatPassword,
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
                                        showRepeatPassword =
                                            !showRepeatPassword;
                                      });
                                    },
                                    child: Icon(
                                      showRepeatPassword
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
