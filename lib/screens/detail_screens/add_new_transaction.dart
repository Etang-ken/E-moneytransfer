import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/api/request.dart';
import 'package:elcrypto/provider/transaction.dart';
import 'package:provider/provider.dart';
import 'package:elcrypto/screens/detail_screens/choose_payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:elcrypto/widgets/general_button.dart';
import 'package:elcrypto/widgets/primary_button.dart';
import 'package:elcrypto/widgets/text_field.dart';

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
    "amount_received": ""
  };

  Future<void> saveTransaction() async {
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    setState(() {
      isSavingTransaction = true;
    });
    final response = await APIRequest()
        .postRequest(route: "/transactions/create", data: formData);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      transactionProvider
          .updateTransactionsData(decodedResponse['transactions']);

      setState(() {
        isSavingTransaction = false;
      });
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ChoosePaymentMethod()));
      AppUtils.showSnackBar(
          context, ContentType.success, 'Transaction added successfully.');
    } else {
      setState(() {
        isSavingTransaction = false;
      });
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Network error. Please try again.');
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
                                // Text(
                                //   'Add New Transaction',
                                //   textAlign: TextAlign.center,
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headline3!
                                //       .copyWith(fontWeight: FontWeight.w500),
                                // ),
                                // const SizedBox(height: 20),

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
                                                fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 5),
                                      TextInputField(
                                        placeholderText: '***********2342',
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
                                      const SizedBox(height: 10),
                                      Text(
                                        "Amount",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 5),
                                      TextInputField(
                                        placeholderText: '50000',
                                        textInputType: TextInputType.number,
                                        onChanged: (val) {
                                          formData['amount_send'] = val!;
                                          formData['amount_received'] = val!;
                                        },
                                        inputValidator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Amount is required';
                                          }
                                          if(int.parse(val) < 100) {
                                            return 'Amount must be at least 100.';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      // Text(
                                      //   'Amount to send',
                                      //   textAlign: TextAlign.center,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyText1!
                                      //       .copyWith(
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.w700),
                                      // ),
                                      // const SizedBox(height: 5),
                                      // TextInputField(
                                      //   placeholderText: '50000',
                                      //   textInputType: TextInputType.number,
                                      // ),
                                      const SizedBox(height: 40),
                                      PrimaryButton(
                                        buttonText: 'Save & Continue',
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
}

class SelectPaymentMethod extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
