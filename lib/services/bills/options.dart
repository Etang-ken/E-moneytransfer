import 'package:eltransfer/screens/widgets/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';

import '../../provider/service.dart';
import '../artime/pay.dart';

class ServiceOptions extends StatefulWidget {
  String type;

  ServiceOptions(this.type);

  @override
  _ServiceOptionsState createState() => new _ServiceOptionsState();
}

class _ServiceOptionsState extends State<ServiceOptions> {
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
    // ThemeData theme = Theme.of(context);
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
              Text(widget.type,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white)),
            ],
          ),
        ),
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            // margin: EdgeInsets.only(bottom: 100),
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                onRefresh: () async {

                },
                child: ListView(
                  children: model.bills.map<Widget>((bill) {
                    print(bill);
                    return GestureDetector(
                      onTap: () {
                        model.formData["payment_item_id"] = bill["payItemId"];
                        model.formData["amount"] = bill["amount"].toString();
                        model.formData["title"] = bill["label"];
                        model.formData['type'] = "bill";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayNow(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 13),
                        decoration: BoxDecoration(
                          color: AppUtils.White,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        bill["label"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${bill["amount"].toString()} XAF",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 13,
                                          color: AppUtils.PrimaryColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),

                                  Row(
                                    // spacing: 8,
                                    // runAlignment: WrapAlignment.center,
                                    children: [
                                      IntrinsicWidth(
                                          child: Row(
                                        children: [
                                          Text("Month :",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 11,
                                                    color: AppUtils.DarkColor
                                                        .withOpacity(0.9),
                                                  )),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            bill["date"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 11,
                                                  color: AppUtils.DarkColor
                                                      .withOpacity(0.9),
                                                ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppUtils.SecondaryGray.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ))),
      );
    });
  }
}
