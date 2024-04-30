import 'dart:io';

import 'package:eltransfer/screens/detail_screens/add_payment_proof.dart';
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
  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  bool _showBankDetails = false;
  int activePayment = 0;
  final String _textToCopy = "2672-2662-3672-2727";

  void setActivePayment(int val) {
    setState(() {
      activePayment = val;
    });
  }

  void setShowBankDetails() {
    setState(() {
      _showBankDetails = !_showBankDetails;
    });
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account Number copied to clipboard!'),
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
                  GestureDetector(
                    onTap: () {
                      setActivePayment(1);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          color: activePayment == 1
                              ? Colors.blue.withOpacity(0.3)
                              : null,
                          border: Border.all(
                              color: AppUtils.SecondaryGray.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRect(
                            child: Image.asset("assets/images/mtn-momo.png"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MTN MobileMoney",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "+237 672349837",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                            setShowBankDetails();
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
                                  Text(
                                    "*********837",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: _showBankDetails ? 300 : 0,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '**To make a deposit, please follow these steps:**',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "1. Copy the following bank account number:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        WidgetSpan(
                                            child: Row(
                                          children: [
                                            Text(
                                              "2672-2662-3672-2727",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                _copyToClipboard();
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                color: AppUtils.Secondary,
                                                size: 17,
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "2. Open your banking app or visit your bank's website.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "3. Initiate a transfer or deposit funds.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "4. Paste the copied bank account number into the designated field.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "5. Verify the account details (name, bank) before finalizing the deposit.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "**Important:** Ensure you trust the recipient before making any deposit.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPaymentProof()));
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
