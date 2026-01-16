import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/services/artime/pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../provider/service.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';
import '../bills/cameroon_validator.dart';

class BuyAirtime extends StatefulWidget {
  String title;

  BuyAirtime(this.title);

  @override
  _BuyAirtimeState createState() => new _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {


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
    return Consumer<ServiceProvider>(builder: (_, model, __)
    {
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
              Text(widget.title,
                  style: Theme
                      .of(context)
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
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Service",
                          textAlign: TextAlign.center,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        SelectFormField(
                          type: SelectFormFieldType.dropdown,
                          initialValue: model.formData['service_id'],
                          items: model.options,
                          style: TextStyle(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.2,
                                  color: Color.fromARGB(66, 65, 65, 65),
                                ),
                                borderRadius: BorderRadius.circular(8.0)),
                            suffixIconConstraints:
                            const BoxConstraints(maxWidth: 5),
                            labelStyle:
                            const TextStyle(fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 17),
                          ),
                          onChanged: (val) {
                            setState(() {
                              model.formData['service_id'] = val;
                              for (var plan in model.options) {
                                if(plan['value'].toString() == val.toString()){
                                  model.formData['title'] = plan['label'];
                                }
                              }

                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone Number",
                                      textAlign: TextAlign.center,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextInputField(
                                      placeholderText: '6 12 34 57 89',
                                      textInputType: TextInputType.number,
                                      onChanged: (val) {
                                        model.formData['service_nu'] = val!;
                                      },
                                    )
                                  ],
                                )),
                            SizedBox(width: 20),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Amount (XAF)",
                                      textAlign: TextAlign.center,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextInputField(
                                      placeholderText: '500',
                                      textInputType: TextInputType.number,
                                      onChanged: (val) {
                                        model.formData['amount'] = val!;
                                      },
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          buttonText: 'Buy Now',
                          onClickBtn: () {

                               print(model.formData['title'].split(' ').first);


                            if (model.formData['amount'] == "" ||
                                model.formData['amount']! == "0") {
                              AppUtils.showSnackBar(
                                  context, ContentType.failure,
                                  'The amount field is required');
                            } else if (model.formData['service_id'] == "") {
                              AppUtils.showSnackBar(
                                  context, ContentType.failure,
                                  'The service field is required');
                            }else if (!CameroonPhoneValidator.isValidCameroonPhoneNumber(
                                model.formData['service_nu'], provider : model.formData['title'].split(' ').first
                            )) {
                            AppUtils.showSnackBar(
                            context, ContentType.failure,
                             "The phone number is not a valid ${model.formData['title'].split(' ').first} number");
                            }else{
                              model.formData['type'] = "topup";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PayNow(),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    )
                  ],
                ))),
      );
    });
  }
}
