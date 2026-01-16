import 'package:dotted_line/dotted_line.dart';
import 'package:eltransfer/provider/service.dart';
import 'package:eltransfer/services/artime/smobil_pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';

import '../../helper/session_manager.dart';
import '../../screens/detail_screens/cinetpay.dart';
import '../../widgets/primary_button.dart';
import 'btn.dart';

class PayNow extends StatefulWidget {
  dynamic formData = [];

  @override
  _PayNowState createState() => new _PayNowState();
}

class _PayNowState extends State<PayNow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __) {
      return Scaffold(
        backgroundColor: AppUtils.SecondaryGrayExtraLight,
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
              Text(model.formData["title"]!,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white)),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                // margin: EdgeInsets.only(bottom: 100),
                height: MediaQuery.of(context).size.height,
                child: RefreshIndicator(
                    onRefresh: () async {},
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (model.formData['type'] ==
                                        "netflix") ...[
                                      Text(
                                        'Personal Info',
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
                                          "Name", model.formData['name'] ?? ""),
                                      transactionTitleAndDetail("Mobile",
                                          model.formData['mobile'] ?? ""),
                                      transactionTitleAndDetail("Email",
                                          model.formData['email'] ?? ""),
                                      transactionTitleAndDetail("Address",
                                          model.formData['address'] ?? ""),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
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
                                        "Title", model.formData['title'] ?? ""),
                                    transactionTitleAndDetail(
                                        "Type", model.formData['type'] ?? ""),
                                    transactionTitleAndDetail("Amount",
                                        model.formData['amount'] ?? ""),
                                    if (model.formData['service_nu'] != "") ...[
                                      transactionTitleAndDetail(
                                          "Service Number",
                                          model.formData['service_nu'] ?? ""),
                                    ],
                                    const SizedBox(height: 20),
                                    if (model.formData['type'] == "netflix") ...[
                                      Row(children: [
                                        Expanded(
                                            child: PrimaryButton(
                                          buttonText: 'Mobile Money',
                                          btnIcon: Icon(Icons.send_to_mobile),
                                          iconPosition: IconPosition.left,
                                          onClickBtn: () {
                                            SessionManager()
                                                .getId()
                                                .then((value) {
                                              model.formData['user_id'] = value;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LaunchCinetpay(
                                                          model.formData,
                                                          int.parse(
                                                              model.formData[
                                                                  'amount'])),
                                                ),
                                              );
                                            });
                                          },
                                        )),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: PrimaryButton(
                                          bgColor: Color(0xffcc9939),
                                          buttonText: 'Bitcoin',
                                          btnIcon: Icon(Icons.currency_bitcoin),
                                          iconPosition: IconPosition.left,
                                          onClickBtn: () async {
                                            model
                                                .convert(context)
                                                .then((value) async {
                                              if (value != "") {
                                                await showDialog<bool>(
                                                  context: context,
                                                  builder: (context) =>
                                                      BtcPaymentDialog(
                                                    btcAddress: model
                                                        .formData["wallet"]!,
                                                    amount: value,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                        ))
                                      ]),
                                    ]else ...[
                                      PrimaryButton(
                                        bgColor: Color(0xffcc9939),
                                        buttonText: 'Pay Now',
                                        btnIcon: Icon(Icons.payments_rounded),
                                        iconPosition: IconPosition.left,
                                        onClickBtn: () async {
                                          model
                                              .convert(context)
                                              .then((value) async {
                                            if (value != "") {
                                              await showDialog<bool>(
                                                context: context,
                                                builder: (context) =>
                                                    SmobilPaymentDialog(),
                                              );
                                            }
                                          });
                                        },
                                      )
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))),
            if (model.isLoading) ...[showIsLoading()]
          ],
        ),
      );
    });
  }

  Widget transactionTitleAndDetail(String title, String detail,
      {String? paymentStatus, bool isAmount = false, bool status = false}) {
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                color: status
                    ? (detail == "done" ? Color(0xff00ff00) : Color(0xffff0000))
                    : Colors.transparent),
            child: Text(
              detail,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: isAmount ? 16 : 12,
                  fontWeight: FontWeight.w700,
                  color: status
                      ? Color(0xffffffff)
                      : (isAmount
                          ? AppUtils.DarkColor.withOpacity(0.7)
                          : AppUtils.SecondaryGray)),
            ),
          )
        ],
      ),
    );
  }
}
