import 'dart:io';

import 'package:eltransfer/screens/detail_screens/add_payment_proof.dart';
import 'package:eltransfer/screens/detail_screens/bank_transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:eltransfer/widgets/general_button.dart';
import 'package:eltransfer/widgets/primary_button.dart';
import 'package:eltransfer/widgets/text_field.dart';
import 'package:clipboard/clipboard.dart';

class ChoosePaymentMethod extends StatefulWidget {
  dynamic formData;

  ChoosePaymentMethod(this.formData);

  @override
  State<ChoosePaymentMethod> createState() =>
      _ChoosePaymentMethodState(formData);
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  dynamic formData;

  _ChoosePaymentMethodState(this.formData);

  int activePayment = 0;

  void setActivePayment(int val) {
    setState(() {
      activePayment = val;
    });
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('copied.'),
      ),
    );
  }

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
              "Select Payment Method",
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
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: activePayment == 2
                            ? Colors.blue.withOpacity(0.3)
                            : null,
                        border: Border.all(
                            color: AppUtils.SecondaryGray.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setActivePayment(2);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRect(
                                child: SvgPicture.asset(
                                    "assets/icons/icon-magnetic-card.svg"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bank Transfer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  PrimaryButton(
                    buttonText: 'Continue',
                    onClickBtn: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BankTransfer(formData)));
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
