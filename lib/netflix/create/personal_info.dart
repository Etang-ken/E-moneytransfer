import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/netflix/create/plans.dart';
import 'package:eltransfer/screens/widgets/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../provider/service.dart';
import '../../services/artime/pay.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() =>
      new _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

    return Consumer<ServiceProvider>(builder: (_, model, __) {
      return Scaffold(
          backgroundColor: AppUtils.SecondaryGrayExtraLight,
          appBar: AppBar(
            backgroundColor: AppUtils.PrimaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    )),
                Text("Activate Netflix",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white)),
              ],
            ),
          ),
          body: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              // margin: EdgeInsets.only(bottom: 100),
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Info",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),


                          Text(
                            "Full Name *",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          TextInputField(
                            textInputType: TextInputType.text,
                            placeholderText: "Full Name",
                            contentPadding: const EdgeInsets.only(
                              right: 45,
                              top: 17,
                              bottom: 17,
                              left: 20,
                            ),
                            onChanged: (val) {
                              model.formData['name'] = val!;
                            },
                            inputValidator: (val) {
                              if (val!.isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Email Address*",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          TextInputField(
                            textInputType: TextInputType.text,
                            placeholderText: "Email",
                            contentPadding: const EdgeInsets.only(
                              right: 45,
                              top: 17,
                              bottom: 17,
                              left: 20,
                            ),
                            onChanged: (val) {
                              model.formData['email'] = val!;
                            },
                            inputValidator: (val) {
                              if (val!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Mobile Number *",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          TextInputField(
                            textInputType: TextInputType.text,
                            placeholderText: "6778933733",
                            contentPadding: const EdgeInsets.only(
                              right: 45,
                              top: 17,
                              bottom: 17,
                              left: 20,
                            ),
                            onChanged: (val) {
                              model.formData['mobile'] = val!;
                            },
                            inputValidator: (val) {
                              if (val!.isEmpty) {
                                return "Mobile Number is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Address *",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          TextInputField(
                            textInputType: TextInputType.text,
                            placeholderText: "Molyko - Buea - SW - CM",
                            contentPadding: const EdgeInsets.only(
                              right: 45,
                              top: 17,
                              bottom: 17,
                              left: 20,
                            ),
                            onChanged: (val) {
                              model.formData['address'] = val!;
                            },
                            inputValidator: (val) {
                              if (val!.isEmpty) {
                                return "Your address is required";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 30),
                          PrimaryButton(
                            buttonText: 'Next',
                            onClickBtn: () {
                              if (model.formData['name'] == "" || model.formData['mobile'] == "" || model.formData['address'] == "" || model.formData['email'] == "") {
                                AppUtils.showSnackBar(
                                    context,
                                    ContentType.failure,
                                    'Please enter all fields');
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NetflixSubscriptionPlans(),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ))));
    });
  }
}
