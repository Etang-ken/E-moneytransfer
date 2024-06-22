import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../helper/app_utils.dart';
import '../../helper/session_manager.dart';
import '../../widgets/primary_button.dart';
import 'choose_payment_method.dart';

class ConfirmScreen extends StatefulWidget {
  dynamic formData;


  ConfirmScreen(this.formData);

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
              "Confirm transaction details",
              style: Theme.of(context)
                  .textTheme
                  .headline4
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
                          style: Theme.of(context).textTheme.headline5!,
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
                                    text: 'Purchase of ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppUtils.DarkColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    "${formData['amount_received']} BTC ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' is about to be initiated ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
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
                                      .headline6!
                                      .copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                transactionTitleAndDetail(
                                    "Wallet ID",
                                    formData['wallet_id'] ??
                                        "-"),

                                transactionTitleAndDetail(
                                    'Transaction Date',
                                    "Today"),
                                // transactionTitleAndDetail('Paymnt Date', 'Paracetamol'),
                                transactionTitleAndDetail('Amount',
                                    "${formData['amount_received']} BTC",
                                    isAmount: true),
                              ],
                            ),
                          ),
                        ),

                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(
                        //       vertical: 10,
                        //       horizontal: 20,
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Text(
                        //           'Conversion Details',
                        //           textAlign: TextAlign.left,
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .headline6!
                        //               .copyWith(
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //         const SizedBox(
                        //           height: 15,
                        //         ),
                        //
                        //         transactionTitleAndDetail(
                        //             "Rate",
                        //             "1 ${formData['from']} -> ${formData['rate']} ${formData['to']}"),
                        //
                        //         transactionTitleAndDetail(
                        //             "Converted",
                        //             "${formData['from']} ${formData['amount_send']}  -> ${formData['to']} ${double.parse(formData['rate']) * double.parse(formData['amount_send'])}"),
                        //
                        //
                        //         transactionTitleAndDetail(
                        //             "Commission",
                        //             "${formData['commission']}%  (${double.parse(formData['rate']) * double.parse(formData['amount_send']) - (1- double.parse(formData['commission'])/100) * double.parse(formData['commission']) * double.parse(formData['amount_send']) } )"),
                        //
                        //
                        //         transactionTitleAndDetail('Net Amount Receivable',
                        //             "${formData['amount_received']} BTC",
                        //             isAmount: true),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    PrimaryButton(
                      buttonText: 'Continue',
                      onClickBtn: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ChoosePaymentMethod(formData)));
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
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppUtils.SecondaryGray),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(child: Text(
            detail,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: isAmount ? 16 : 12,
                fontWeight: FontWeight.w400,
                color: isAmount
                    ? AppUtils.DarkColor.withOpacity(0.7)
                    : AppUtils.SecondaryGray),
          )),
        ],
      ),
    );
  }
}
