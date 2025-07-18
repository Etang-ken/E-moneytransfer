import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/request.dart';
import '../../helper/app_utils.dart';
import '../../provider/service.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';
import 'amount.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  bool isConverting = false;
  var model = null;

  @override
  void initState() {
    model = Provider.of<ServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __)
    {
      return Stack(
        children: [
          Scaffold(
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
                  Text("Sell Gift Card",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.white)),
                ],
              ),
            ),
            body:

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Select Payment Method',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  const Text(
                    'How will you like to receive your payment?',
                  ),
                  SizedBox(height: 20),
                  RadioListTile(
                    title: const Text('Mobile Money (MoMo)'),
                    value: 'momo',
                    groupValue:  model.formData['payment_method'],
                    onChanged: (value) {
                      setState(() {
                        model.formData['payment_method'] = 'momo';
                        model.formData['to'] = 'XAF';
                        model.clear();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Bitcoin (BTC)'),
                    value: 'btc',
                    groupValue:  model.formData['payment_method'],
                    onChanged: (value) {
                      setState(() {
                        model.formData['payment_method'] = 'btc';
                        model.formData['to'] = 'BTC';
                        model.clear();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter your payment details',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  SizedBox(height: 10),
                  if ( model.formData['payment_method'] == 'momo') ...[

                    TextInputField(
                      inputController : TextEditingController(text:model.formData['momo_number']),
                      placeholderText: 'MoMo Number',
                      onChanged: (val) {
                        model.formData['momo_number'] = val.toString();
                      },
                      inputValidator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter your MoMo number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextInputField(
                      inputController : TextEditingController(text:model.formData['momo_name']),
                      placeholderText: 'MoMo Name',
                      onChanged: (val) {
                        model.formData['momo_name'] = val!;
                      },
                      inputValidator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter the name on MoMo account';
                        }
                        return null;
                      },
                    ),
                  ],
                  if ( model.formData['payment_method'] == 'btc') ...[
                    TextInputField(
                      inputController : TextEditingController(text:model.formData['wallet_id']),
                      placeholderText: 'BTC Wallet Address',
                      onChanged: (val) {
                        model.formData['wallet_id'] = val!;
                      },
                      inputValidator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter your Bitcoin wallet address';
                        }
                        return null;
                      },
                    ),
                  ],
                  SizedBox(height: 20),
                  PrimaryButton(
                    buttonText: 'Next',
                    onClickBtn: model.formData['payment_method'] != ""
                        ? () {
                      if (model.formData['payment_method'] == 'momo') {
                        print(model.formData);
                        if ( model.formData['momo_number'] == "" ||  model.formData['momo_name'] == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all MoMo details')),
                          );
                          return;
                        }
                      } else if (model.formData['payment_method'] == 'btc') {
                        print(model.formData);
                        if ( model.formData['wallet_id'] == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                Text('Please enter BTC wallet address')),
                          );
                          return;
                        }
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AmountScreen(),
                        ),
                      );
                    }
                        : null,
                  ),
                ],
              ),
            ),
          ),
          if (isConverting) showIsLoading(),
        ]);
    });
  }
}
