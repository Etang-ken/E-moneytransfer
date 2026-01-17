import 'package:elcrypto/screens/detail_screens/confirm_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/helper/app_utils.dart';
import '../../api/request.dart';

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

  bool isConverting = false;

  bool isSavingTransaction = false;

  int activePayment = 0;

  late BuildContext context ;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext rcontext) {
    context = rcontext;
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
                    GestureDetector(
                      onTap: () async {
                        setState(()  {
                          activePayment = 0;
                          formData["payment_method"] = "Mobile Money";
                        });
                        await convert();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: activePayment == 0
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
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(()  {
                          activePayment = 1;
                          formData["payment_method"] = "Bank Transfer";
                        });
                        await convert();
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
                                  "assets/images/bank_transfer.jpeg",
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
                                  "Bank Transfer",
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
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(()  {
                          activePayment = 2;
                          formData["payment_method"] = "Paypal";
                        });
                        await convert();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: activePayment == 2
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

  dynamic paymentDetails = [];
  Future<void> convert() async {
    if (formData['amount_send'] != "") {
      setState(() {
        isConverting = true;
      });
      final response = await APIRequest()
          .postRequest(route: "/transactions/estimate", data: {
        'type': 'elcrypto',
        'payment_method':activePayment == 0?"momo":"others",
        'from': formData['from'],
        'to': formData["to"],
        'payable': formData['amount_send']
      });

      formData['commission'] = response['commission'];
      formData['amount_received'] = response['receivable'];
      formData['email'] = response['email'];
      formData['rate'] = response['rate'];
      paymentDetails = response['paypal'];

      if (response != 'error') {
        dynamic responseBody = response;
        setState(() {
          double total = double.parse(formData['amount_send']) *
              double.parse(responseBody['rate']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmScreen(formData, paymentDetails),
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
}
