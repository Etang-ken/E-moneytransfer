import 'package:eltransfer/provider/service.dart';
import 'package:eltransfer/screens/widgets/transaction.dart';
import 'package:eltransfer/services/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';

class ServiceHome extends StatefulWidget {
  @override
  _ServiceHomeState createState() => new _ServiceHomeState();
}

class _ServiceHomeState extends State<ServiceHome> {
  @override
  void initState() {
    Provider.of<ServiceProvider>(context, listen: false)
        .getTransactions(context, "service");
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Digital Services",
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
                    Provider.of<ServiceProvider>(context, listen: false)
                        .getTransactions(context, "service");
                  },
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: model.isLoading
                            ? [const Text('Loading transactions...')]
                            : model.services.isEmpty
                                ? [
                                    Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        features(context),
                                        const Text(
                                          "No purchase found",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text(
                                          "You have not purchased any service yet.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ))
                                  ]
                                : [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        features(context),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Transactions",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  children: model.services
                                                      .map<Widget>(
                                                          (transaction) {
                                                    return GestureDetector(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            transactionCard(
                                                                context,
                                                                transaction[
                                                                    "name"],
                                                                transaction[
                                                                    "amount"],
                                                                transaction[
                                                                    "status"],
                                                                transaction[
                                                                    "date"]),
                                                            const SizedBox(
                                                              height: 10,
                                                            )
                                                          ]),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ServiceDetails(
                                                                    transaction),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            )),
                                      ],
                                    )
                                  ],
                      ),
                    ],
                  ))));
    });
  }
}
