import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:eltransfer/screens/widgets/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';

class NetflixDetails extends StatefulWidget {
  dynamic detail;

  NetflixDetails(this.detail);

  @override
  _NetflixDetailsState createState() => new _NetflixDetailsState();
}

class _NetflixDetailsState extends State<NetflixDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String status = 'success';

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

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
            Text("Netflix Subscription",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  constraints: const BoxConstraints(minHeight: 300),
                  decoration: BoxDecoration(
                    color: AppUtils.White,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.detail['title'],
                        style: Theme.of(context).textTheme.headlineMedium!,
                      ),
                      const SizedBox(
                        height: 6,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              transactionTitleAndDetail(context,
                                  "Name", widget.detail['name']??""),

                              transactionTitleAndDetail(context,
                                  "Email", widget.detail['email']??""),
                              transactionTitleAndDetail(context,
                                  "Address", widget.detail['address']??""),
                              transactionTitleAndDetail(context,
                                  "Mobile", widget.detail['mobile']??""),

                              const SizedBox(
                                height: 15,
                              ),
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
                              transactionTitleAndDetail(context,
                                  "Status", widget.detail['status'], status: true),

                              transactionTitleAndDetail(context,
                                  "Amount", widget.detail['amount'], status: false),
                              transactionTitleAndDetail(context,
                                  "Payment Method", widget.detail['payment_method'], status: false),

                              transactionTitleAndDetail(context,
                                  "Date", widget.detail['date'], status: false),


                              if(widget.detail['status'] == "completed")...[
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Login Credentials',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                                transactionTitleAndDetail(context,
                                    "Email", widget.detail["login_email"], status: false),

                                transactionTitleAndDetail(context,
                                    "Password", widget.detail["login_password"], status: false),
                              ],

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

}
