import 'dart:convert';
import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:eltransfer/helper/session_manager.dart';
import 'package:eltransfer/screens/detail_screens/select_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:eltransfer/widgets/primary_button.dart';

class ConfirmScreen extends StatefulWidget {
  dynamic formData;
  dynamic paymentDetails;

  ConfirmScreen(this.formData, this.paymentDetails);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState(formData);
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  bool isSavingTransaction = false;

  dynamic formData;

  _ConfirmScreenState(this.formData);

  late ImagePicker _imagePicker;
  XFile? _imageFile;

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedImage;
    });
  }

  SessionManager ss = SessionManager();

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
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
              "Transaction Details",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppUtils.White,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Transaction Details',
                          style: Theme.of(context).textTheme.headlineMedium!,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          constraints:
                          const BoxConstraints(minWidth: 250),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Transfer of ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppUtils.DarkColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    "XAF ${formData['amount_received']} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'to ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppUtils.DarkColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  TextSpan(
                                    text:  formData['receiver_name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppUtils.DarkColor
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' is about to be initiated ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppUtils.DarkColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 15,
                              decoration: BoxDecoration(
                                  color:
                                  AppUtils.SecondaryGrayExtraLight,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight:
                                      Radius.circular(15))),
                            ),
                            Expanded(
                              child: DottedLine(
                                lineThickness: 2,
                                dashLength: 5,
                                dashColor:
                                AppUtils.SecondaryGray.withOpacity(
                                    0.7),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 15,
                              decoration: BoxDecoration(
                                  color:
                                  AppUtils.SecondaryGrayExtraLight,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Transaction Details',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                transactionTitleAndDetail(
                                    formData["method"] != "bank"?"Receiver's Name":"Account Name",
                                    formData['receiver_name'] ??
                                        "-"),

                                transactionTitleAndDetail(
                                    formData["method"] != "bank"?"Receiver's Phone":"Account Number",
                                    formData['receiver_phone'] ??
                                        "-"),
                                if(formData["method"] != "momo")...[
                                  transactionTitleAndDetail(
                                      "Bank Name",
                                      formData['bank'] ??
                                          "-")
                                ],
                                transactionTitleAndDetail(
                                    'Transaction Date',
                                    "Today"),
                                // transactionTitleAndDetail('Paymnt Date', 'Paracetamol'),
                                transactionTitleAndDetail('Amount',
                                    "XAF ${formData['amount_received']}",
                                    isAmount: true),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      buttonText: 'Submit',
                      onClickBtn: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ChoosePaymentMethod(formData, widget.paymentDetails)));
                      },
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
            if (isSavingTransaction) showIsLoading()
          ]
        ),
      ),
    );
  }

  Widget transactionTitleAndDetail(String title, String detail,
      {String? paymentStatus, bool isAmount = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppUtils.SecondaryGray),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            detail,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: isAmount ? 16 : 12,
                fontWeight: FontWeight.w700,
                color: isAmount
                    ? AppUtils.DarkColor.withOpacity(0.7)
                    : AppUtils.SecondaryGray),
          ),
        ],
      ),
    );
  }
}
