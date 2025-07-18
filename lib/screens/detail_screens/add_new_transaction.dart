import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/screens/detail_screens/confirm_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:eltransfer/widgets/primary_button.dart';
import 'package:eltransfer/widgets/text_field.dart';
import 'package:flutter/services.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../api/request.dart';

class AddNewTransaction extends StatefulWidget {
  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic paymentDetails = [];
  final formData = {
    "type": "momo",
    "name": "",
    "phone": "",
    "from": "CAD",
    "to": "XAF",
    "rate": "",
    "commission": "",
    "method": "momo",
    "receiver_name": "",
    "bank_name": "",
    "receiver_phone": "",
    "amount_send": "",
    "amount_received": ""
  };

  final List<Map<String, dynamic>> _methods = [
    {
      'value': 'momo',
      'label': 'MTN Mobile Money',
    },
    {
      'value': 'omomo',
      'label': 'Orange Mobile Money',
    },
    {
      'value': 'bank',
      'label': 'Bank Transfer',
    },
  ];

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
      if (!isConverting) {
        await convert();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmScreen(formData, paymentDetails)));
      }
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
                        .headlineLarge
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Receiver's Info",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(height: 30),
                                Text(
                                  "Payment Method",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  child: SelectFormField(
                                    type: SelectFormFieldType.dropdown,
                                    initialValue: formData['method'],
                                    items: _methods,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 1.2,
                                            color:
                                                Color.fromARGB(66, 65, 65, 65),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      suffixIconConstraints:
                                          BoxConstraints(maxWidth: 5),
                                      suffixIcon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 17),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        formData['method'] = val;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  formData["method"] != "bank"
                                      ? "Receiver's Name"
                                      : "Account Name",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                TextInputField(
                                  placeholderText: 'John Doe ...',
                                  onChanged: (val) {
                                    formData['receiver_name'] = val!;
                                  },
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return "${formData["method"] != "bank" ? "Receiver's Name" : "Account Name"} is required";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  formData["method"] != "bank"
                                      ? "Receiver's Number"
                                      : "Account Number",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                TextInputField(
                                  placeholderText: formData["method"] != "bank"
                                      ? '+237 672346634'
                                      : "",
                                  textInputType: formData["method"] != "bank"
                                      ? TextInputType.number
                                      : TextInputType.text,
                                  onChanged: (val) {
                                    formData['receiver_phone'] = val!;
                                  },
                                  inputValidator: (val) {
                                    if (val!.isEmpty) {
                                      return "${formData["method"] != "bank" ? "Receiver's Number" : "Account Number"} is required";
                                    }
                                    return null;
                                  },
                                ),
                                if (formData["method"] == "bank") ...[
                                  const SizedBox(height: 15),
                                  Text(
                                    "Bank Name",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 5),
                                  TextInputField(
                                    placeholderText: "Enter bank name",
                                    textInputType: TextInputType.text,
                                    onChanged: (val) {
                                      formData['bank'] = val!;
                                    },
                                    inputValidator: (val) {
                                      if (val!.isEmpty) {
                                        return "Bank name is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                                const SizedBox(height: 40),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Amount",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      GestureDetector(
                                        onTap: () {
                                          if (!isConverting) {
                                            convert();
                                          }
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: AppUtils.PrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              isConverting
                                                  ? "converting ... "
                                                  : 'convert',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            )),
                                      )
                                    ]),
                                const SizedBox(height: 10),
                                Text(
                                  'Amount payable',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                Stack(
                                  children: [
                                    TextInputField(
                                      textInputType: TextInputType.number,
                                      contentPadding: const EdgeInsets.only(
                                        right: 45,
                                        top: 17,
                                        bottom: 17,
                                        left: 80,
                                      ),
                                      onChanged: (val) {
                                        formData['amount_send'] = val!;
                                        if(formData['rate'] != ""){
                                          formData['amount_received'] = (double.parse(formData['rate'].toString()) * double.parse(formData['amount_send'].toString())).toString();
                                        }
                                      },
                                      inputValidator: (val) {
                                        if (val!.isEmpty) {
                                          return "Amount is required";
                                        }
                                        return null;
                                      },
                                    ),
                                    Positioned(
                                        child: Container(
                                      width: 60,
                                      child: SelectFormField(
                                        type: SelectFormFieldType.dropdown,
                                        initialValue: formData['from'],
                                        items: _items,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                        decoration: InputDecoration(
                                            suffixIconConstraints:
                                                BoxConstraints(maxWidth: 5),
                                            suffixIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 20),
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.w400),
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
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                Stack(
                                  children: [
                                    TextInputField(
                                      inputController: TextEditingController(
                                          text: formData['amount_received']),
                                      textInputType: TextInputType.number,
                                      enabled: false,
                                      contentPadding: const EdgeInsets.only(
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
                                        "XAF",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text(
                                    "1 ${formData['from']} = ${formData['rate']} ${formData['to']}",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                          PrimaryButton(
                            buttonText: 'View Details',
                            onClickBtn: () {
                              if (_formKey.currentState!.validate()) {
                                checkLimit();
                              }
                            },
                          ),
                          const SizedBox(height: 35),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isConverting) showIsLoading(),
      ],
    );
  }

  Future<void> convert() async {
    setState(() {
      isConverting = true;
    });
    if (formData['amount_send'] != "") {
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
          formData['email'] = responseBody['email'];
          formData['commission'] = responseBody['commission'];
          formData['amount_received'] = (double.parse(responseBody['rate'].toString()) * double.parse(formData['amount_send'].toString())).toString();
          formData['rate'] = responseBody['rate'];
          paymentDetails = responseBody['paypal'];
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

  Future<void> checkLimit() async {
    if (formData['amount_send'] != "") {
      setState(() {
        isConverting = true;
      });
      final response =
          await APIRequest().postRequest(route: "/transactions/check", data: {
        'type': "momo",
        'amount': formData['amount_send'],
        'currency': formData['from'],
      });

      setState(() {
        isConverting = false;
      });

      if (response != 'error') {
        dynamic responseBody = response;
        print(responseBody);
        if (!responseBody["success"]) {
          AppUtils.showSnackBar(
              context, ContentType.failure, responseBody["message"]);
        } else {
          setState(() {
            saveTransaction();
          });
        }
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
