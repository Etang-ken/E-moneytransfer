import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/api/request.dart';
import 'package:elcrypto/provider/transaction.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:elcrypto/screens/detail_screens/choose_payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:http/http.dart' as http;
import 'package:elcrypto/widgets/primary_button.dart';
import 'package:elcrypto/widgets/text_field.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../api/url.dart';
import 'confirm_screen.dart';

class AddNewTransaction extends StatefulWidget {
  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSavingTransaction = false;

  final formData = {
    "type": "crypto",
    "wallet_id": "",
    "amount_send": "",
    "amount_received": "",
    "from": "CAD",
    "to": "BTC",
    "rate": "",
    "commission": "",
  };

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'CAD',
      'label': 'CAD',
    },
    {
      'value': 'USD',
      'label': 'USD',
    },
    {
      'value': 'XAF',
      'label': 'XAF',
    },
  ];

  bool isConverting = false;

  Future<void> saveTransaction() async {
    if (formData['amount_send'] != "") {
      await convert();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConfirmScreen(formData)));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                  Text(
                    "Add Transaction",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            body: IntrinsicHeight(
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppUtils.White,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wallet ID",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 5),
                                      TextInputField(
                                        placeholderText: 'paste wallet id',
                                        onChanged: (val) {
                                          formData['wallet_id'] = val!;
                                        },
                                        inputValidator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Wallet ID is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text("Amount",
                                                textAlign: TextAlign.center,
                                                style:
                                                Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6),
                                            GestureDetector(onTap: () {
                                              if (!isConverting) {
                                                convert();
                                              }
                                            },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4, horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppUtils.PrimaryColor,
                                                      borderRadius: BorderRadius
                                                          .circular(5)
                                                  ),
                                                  child: Text(isConverting
                                                      ? "converting ... "
                                                      : 'convert', style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),)),
                                            )
                                          ]),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Amount Payable",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 5),
                                      Stack(
                                        children: [
                                          TextInputField(
                                            textInputType: TextInputType.number,
                                            contentPadding:
                                                const EdgeInsets.only(
                                              right: 45,
                                              top: 17,
                                              bottom: 17,
                                              left: 60,
                                            ),
                                            onChanged: (val) {
                                              formData['amount_send'] = val!;
                                            },
                                            inputValidator: (val) {
                                              if (val!.isEmpty) {
                                                return "Amount is required";
                                              }
                                              if (double.parse(val) < 100) {
                                                return "Amount must be at least 100.";
                                              }
                                              return null;
                                            },
                                          ),
                                          Positioned(
                                              child: Container(
                                            width: 40,
                                            child: SelectFormField(
                                              type: SelectFormFieldType.dropdown,
                                              initialValue: formData['from'],
                                              changeIcon: true,
                                              items: _items,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                              decoration: InputDecoration(
                                                suffixIconConstraints:  BoxConstraints(maxWidth: 5),
                                                suffixIcon: Icon(Icons.keyboard_arrow_down, size: 20),

                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 17),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  )),
                                              onChanged: (val) {
                                                setState(() {
                                                  formData['from'] = val;
                                                });
                                              },
                                            ),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Amount Receivable',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 5),
                                      Stack(
                                        children: [
                                          TextInputField(
                                            inputController:
                                                TextEditingController(
                                                    text: formData[
                                                        'amount_received']),
                                            textInputType: TextInputType.number,
                                            enabled: false,
                                            contentPadding:
                                                const EdgeInsets.only(
                                              right: 45,
                                              top: 17,
                                              bottom: 17,
                                              left: 50,
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            top: 16,
                                            child: Text(
                                              "BTC",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const SizedBox(height: 40),
                                      PrimaryButton(
                                        buttonText: 'View Details',
                                        onClickBtn: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            saveTransaction();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isSavingTransaction) showIsLoading()
      ],
    );
  }

  Future<void> convert() async {
    if (formData['amount_send'] != "") {
      setState(() {
        isConverting = true;
      });
      final response = await APIRequest()
          .postRequest(route: "/transactions/estimate", data: {
        'type': 'momo',
        'from': formData['from'],
        'to': formData['to'],
        'payable': formData['amount_send']
      });

      if (response != "error") {
        dynamic responseBody = response;

        setState(() {
          formData['commission'] = responseBody['commission'];
          formData['amount_received'] = responseBody['receivable'];
          formData['rate'] = responseBody['rate'];
        });
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Network error. Please try again.');
      }
      setState(() {
        isConverting = false;
      });
    } else {
      setState(() {
        isConverting = false;
      });
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Enter amount payable');
    }
  }
}

class SelectPaymentMethod extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
