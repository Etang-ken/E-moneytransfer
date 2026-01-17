import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/request.dart';
import '../../api/url.dart';
import '../../helper/app_utils.dart';
import '../../helper/session_manager.dart';
import '../../paypal/paypal_payment.dart';
import '../../provider/transaction.dart';
import '../../widgets/primary_button.dart';
import 'bank_transfer.dart';
import 'package:http/http.dart' as http;
import '../../api/url.dart';
import 'package:provider/provider.dart';
import 'cinetpay.dart';

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


  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();


  SessionManager ss = SessionManager();

  bool isConverting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
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
                                    text: 'Purchase of ',
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
                                    "${formData['amount_received']} ${formData['to']} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
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
                                    "Wallet ID",
                                    formData['wallet_id'] ??
                                        "-"),
                                transactionTitleAndDetail(
                                    "Payment Method",
                                    formData['payment_method'] ??
                                        "-"),

                                transactionTitleAndDetail(
                                    'Transaction Date',
                                    "Today"),

                                transactionTitleAndDetail(
                                    "Amount Payable",
                                    "${formData['amount_send']} ${formData['from']}"),

                                transactionTitleAndDetail('Amount',
                                    "${formData['amount_received']} ${formData['to']}",
                                    isAmount: true),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    PrimaryButton(
                      buttonText: 'Continue',
                      onClickBtn: () async {
                        if(widget.formData['payment_method'] == "Paypal"){
                          // make PayPal payment
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PaypalPayment(
                                onFinish: (number) async {
                                  if(number != null){
                                    final snackBar = SnackBar(
                                      content: const Text("Payment done Successfully"),
                                      duration: const Duration(seconds: 5),
                                      action: SnackBarAction(
                                        label: 'Close',
                                        onPressed: () {

                                        },
                                      ),
                                    );
                                    _scaffoldKey.currentState?.showSnackBar(snackBar);

                                    setState(() {
                                      isSavingTransaction = true;
                                    });

                                    var uri = Uri.parse("${AppUrl.baseUrl}/transactions/create");
                                    var request = http.MultipartRequest('POST', uri);

                                    final token = await storage.read(key: 'authToken');
                                    if (token != null) {
                                      request.headers['Authorization'] = 'Bearer $token';
                                      request.headers['Content-type'] = 'application/json';
                                      request.headers['Accept'] = 'application/json';
                                    }
                                    formData["method"] = "paypal";
                                    formData["trid"] = number;
                                    request.fields.addAll(formData);
                                    var streamedResponse = await request.send();
                                    var response = await http.Response.fromStream(streamedResponse);
                                    if (response.statusCode == 200) {
                                      AppUtils.showSnackBar(
                                        context,
                                        ContentType.success,
                                        'Transaction created successfully.',
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Provider.of<TransactionProvider>(context, listen: false).getTransactions();

                                    } else {
                                      if (!mounted) return;
                                      AppUtils.showSnackBar(
                                        context,
                                        ContentType.failure,
                                        'Error saving transaction',
                                      );
                                    }

                                    setState(() {
                                      isSavingTransaction = false;
                                    });
                                  }
                                },
                                formData: formData,
                                paymentDetails: widget.paymentDetails,
                              ),
                            ),
                          );
                        }else if(widget.formData['payment_method'] ==  "Bank Transfer"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BankTransfer(formData),
                            ),
                          );
                        }else{
                          SessionManager().getId().then((value) {
                            formData['user_id'] = value;
                            if (formData['from'] == "XAF") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LaunchCinetpay(formData,
                                      int.parse(formData['amount_send'])),
                                ),
                              );
                            } else {
                              convert();
                            }
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
            if (isConverting) showIsLoading(),
            if (isSavingTransaction) showIsLoading()
          ]
        ),
      ),
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
        'payment_method':"momo",
        'from': formData['from'],
        'to': "XAF",
        'payable': formData['amount_send']
      });

      if (response != 'error') {
        dynamic responseBody = response;
        setState(() {
          double total = double.parse(formData['amount_send']) *
              double.parse(responseBody['rate']);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaunchCinetpay(formData, total.toInt()),
            ),
          );

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
                fontWeight: FontWeight.w400,
                color: AppUtils.SecondaryGray),
          ),
         Spacer(),
          Expanded(child: Text(
            textAlign: TextAlign.right,
            detail,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
