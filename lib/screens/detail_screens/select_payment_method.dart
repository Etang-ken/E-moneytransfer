import 'dart:io';
import 'package:eltransfer/screens/detail_screens/bank_transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:eltransfer/helper/app_utils.dart';
import 'package:eltransfer/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../api/url.dart';
import '../../paypal/paypal_payment.dart';
import '../../provider/transaction.dart';

class ChoosePaymentMethod extends StatefulWidget {
  dynamic formData;
  dynamic paymentDetails;

  ChoosePaymentMethod(this.formData, this.paymentDetails);

  @override
  State<ChoosePaymentMethod> createState() =>
      _ChoosePaymentMethodState(formData);
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  dynamic formData;

  _ChoosePaymentMethodState(this.formData);

  int activePayment = 0;

  bool isConverting = false;

  bool isSavingTransaction = false;

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

  GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

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
              "Select Payment Method",
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
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
                    GestureDetector(
                      onTap: () {
                        // make PayPal payment
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {
                                if (number != null) {
                                  final snackBar = SnackBar(
                                    content:
                                        const Text("Payment done Successfully"),
                                    duration: const Duration(seconds: 5),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  );
                                  _scaffoldKey.currentState
                                      ?.showSnackBar(snackBar);

                                  setState(() {
                                    isSavingTransaction = true;
                                  });

                                  var uri = Uri.parse(
                                      "${AppUrl.baseUrl}/transactions/create");
                                  var request =
                                      http.MultipartRequest('POST', uri);

                                  final token =
                                      await storage.read(key: 'authToken');
                                  if (token != null) {
                                    request.headers['Authorization'] =
                                        'Bearer $token';
                                    request.headers['Content-type'] =
                                        'application/json';
                                    request.headers['Accept'] =
                                        'application/json';
                                  }
                                  formData["method"] = "paypal";
                                  formData["trid"] = number;
                                  request.fields.addAll(formData);
                                  var streamedResponse = await request.send();
                                  var response = await http.Response.fromStream(
                                      streamedResponse);
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
                                    Provider.of<TransactionProvider>(context,
                                            listen: false)
                                        .getTransactions();
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
                              child: Image.asset(
                                  "assets/images/paypal-mark-color.png",
                                  height: 50,
                                  width: 50),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Paypal",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                          ],
                        ),
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
            if (isConverting) showIsLoading(),
            if (isSavingTransaction) showIsLoading()
          ],
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
