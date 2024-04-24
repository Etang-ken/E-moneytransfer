import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/widgets/general_button.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';
import 'package:emoneytransfer/widgets/text_field.dart';

class VerifyPhoneOrEmail extends StatefulWidget {
  @override
  _VerifyPhoneOrEmailState createState() => new _VerifyPhoneOrEmailState();
}

class _VerifyPhoneOrEmailState extends State<VerifyPhoneOrEmail> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool showPassword = true;
  bool showRepeatPassword = true;

  @override
  void initState() {
    super.initState();
  }

  submitForm() {
    if (!formKey.currentState!.validate()) {
      return "form data invalid";
    }
    if (formKey.currentState != null) {
      formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/verification_bg2.png'),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 15),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Image.asset('assets/images/Pro4Home_logo_sm.png'),
                    ))),
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Verify Phone \n Number',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'A verification code has been sent to ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 13, color: AppUtils.SecondaryGray),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '+237 698789899',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppUtils.DarkColor.withOpacity(0.8),
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        TextInputField(
                          placeholderText: 'Enter Verificaion Code',
                          contentPadding:
                              EdgeInsets.only(top: 17, bottom: 17, left: 10),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        PrimaryButton(
                          buttonText: 'Verify Phone',
                          onClickBtn: () {
                            showRegistrationSuccess();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GeneralButton(
                          buttonText: 'Resend Code',
                          btnBgColor: AppUtils.White,
                          btnTextColor: AppUtils.PrimaryColor,
                          borderColor: AppUtils.PrimaryColor,
                          onClickBtn: () {
                            AppUtils.showSnackBar(context, ContentType.success,
                                'Code has been resent');
                          },
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Change to Phone Verification',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: AppUtils.AccentColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          AppUtils.AccentColor.withOpacity(0.5),
                                      decorationThickness: 1.5,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showRegistrationSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              constraints: BoxConstraints(maxHeight: 450),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(children: [
                            Image.asset('assets/icons/icon-checkmark.png'),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Phone Number Verified Successfully',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: AppUtils.DarkColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Your phone number ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color:
                                                AppUtils.DarkColor.withOpacity(
                                                    0.8),
                                          ),
                                    ),
                                    TextSpan(
                                      text: '+237 698789899 ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: AppUtils.DarkColor,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: 'has been successfully verified',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color:
                                                AppUtils.DarkColor.withOpacity(
                                                    0.8),
                                          ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        PrimaryButton(
                          buttonText: 'Proceed to Verify your Email',
                          btnIcon: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                          onClickBtn: () {},
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
