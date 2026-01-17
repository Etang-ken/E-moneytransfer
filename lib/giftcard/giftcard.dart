import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/app_utils.dart';
import '../provider/service.dart';
import '../screens/widgets/transaction.dart';
import 'details.dart';

class GiftcardSales extends StatefulWidget {
  @override
  _GiftcardSalesState createState() => new _GiftcardSalesState();
}

class _GiftcardSalesState extends State<GiftcardSales> {

  @override
  void initState() {
    Provider.of<ServiceProvider>(context, listen: false).getTransactions(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Consumer<ServiceProvider>(builder: (_, model, __)
    {
      return Scaffold(
        backgroundColor: AppUtils.SecondaryGrayExtraLight,
        appBar: AppBar(
          backgroundColor: AppUtils.PrimaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Gift Card Sales",
                  style: Theme
                      .of(context)
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
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: RefreshIndicator(
                onRefresh: () async {
                  Provider.of<ServiceProvider>(context, listen: false)
                      .getTransactions(context);
                },

                child: ListView(
                  children: [
                    Column(
                      children: model.isLoading
                          ? [const Text('Loading transactions...')]
                          : model.transactions.isEmpty
                          ? [
                        Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                features(context),
                                const Text(
                                  "No purchase found",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  "You have not purchased any service yet.",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),

                              ],))
                      ]
                          : [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            features(context),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Transactions",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: model.transactions.map<Widget>((
                                          transaction) {
                                        return  GestureDetector(child: transactionCard(context,
                                            "Gift card sales of ${transaction['receivable_payload']['from']??""} ${transaction['amount']}","",
                                            transaction['status'], transaction['created_at'].substring(0,10)), onTap: (){
                                          print(transaction);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => GiftcardDetails(transaction),
                                                ),
                                              );
                                        });
                                      }).toList(),)
                                  ],)),

                          ],)
                      ],
                    ),
                  ],
                ))),

      );
    });
  }



}
