import 'dart:io';

import 'package:emoneytransfer/screens/detail_screens/select_payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/widgets/general_button.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';
import 'package:emoneytransfer/widgets/text_field.dart';

class AddNewTransaction extends StatefulWidget {
  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppUtils.White,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: AppUtils.DarkColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add New Transaction',
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
                          "Sender's Info",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sender's Name",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(placeholderText: 'John Doe...'),
                        const SizedBox(height: 10),
                        Text(
                          "Sender's Number",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(
                          placeholderText: '+237 670260611',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 30),
                        Text("Receiver's Info",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6),
                        const SizedBox(height: 10),
                        Text(
                          "Receiver's Name",
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
                          "Receiver's Number",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(
                          placeholderText: '+237 670260611',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Amount',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        TextInputField(
                          placeholderText: '50000',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    buttonText: 'Save & Continue',
                    onClickBtn: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChoosePaymentMethod()));
                    },
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

class SelectPaymentMethod extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
