import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/netflix/create/personal_info.dart';
import 'package:eltransfer/provider/service.dart';
import 'package:eltransfer/services/bills/create.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';

import '../../netflix/create/plans.dart';
import '../../services/artime/create.dart';
import '../detail_screens/add_new_transaction.dart';

Widget transactionCard(BuildContext context, String transactionType,
    String price, String status, String date) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 1),
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
    decoration: BoxDecoration(
        color: AppUtils.White,
        borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionType,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                  // fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                // spacing: 8,
                // runAlignment: WrapAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.8,
                            color: AppUtils.DarkColor.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: transactionStatusColor(status),
                            size: 8,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            status,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 11,
                              color: AppUtils.DarkColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IntrinsicWidth(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: AppUtils.SecondaryGray,
                            size: 5,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            date,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 11,
                              color: AppUtils.DarkColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                      )),
                  Expanded(child:  Text(
                    '$price ',
                    textAlign: TextAlign.right,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppUtils.DarkColor.withOpacity(0.7),
                    ),
                  ),),

                ],
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget features(BuildContext context) {

  return Consumer<ServiceProvider>(builder: (_, data, __) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("Services",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14))),
          Stack(children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
              decoration: BoxDecoration(
                  color: AppUtils.White,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewTransaction(),
                            ),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 211, 211) , borderRadius:BorderRadius.circular(40) ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.currency_exchange, size: 20),
                              Text("Transfer Money", textAlign: TextAlign.center, style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          data.getServices(context, "4").then((options){
                            if(options.length == 0){
                              AppUtils.showSnackBar(
                                  context, ContentType.failure, 'This service is not available, Please try again later');
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyAirtime("Buy Airtime"),
                                ),
                              );
                            }
                          });

                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 211, 211) , borderRadius:BorderRadius.circular(40) ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_android, size: 20),
                              Text("Buy Airtime", style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      ),




                      GestureDetector(
                        onTap: () {
                          data.getServices(context, "8").then((options){
                            if(options.length == 0){
                              AppUtils.showSnackBar(
                                  context, ContentType.failure, 'This service is not available, Please try again later');
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyService("Water Bills"),
                                ),
                              );
                            }
                          });
                        },
                        child:Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 211, 211) , borderRadius:BorderRadius.circular(40) ),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.water_drop_outlined, size: 20),
                              Text("Water", style: TextStyle( fontSize: 12))
                            ],
                          ),
                        ),
                      ),


                      GestureDetector(
                        onTap: () {
                          data.getServices(context, "2").then((options){
                            if(options.length == 0){
                              AppUtils.showSnackBar(
                                  context, ContentType.failure, 'This service is not available, Please try again later');
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyService("Electricity Bill"),
                                ),
                              );
                            }
                          });


                        },
                        child:Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 211, 211) , borderRadius:BorderRadius.circular(40) ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.electric_bolt, size: 20),
                              Text("Electricity", style: TextStyle( fontSize: 12))
                            ],
                          ),
                        ),
                      ),



                      GestureDetector(
                        onTap: () {
                          data.getServices(context, "10").then((options){
                            if(options.length == 0){
                              AppUtils.showSnackBar(
                                  context, ContentType.failure, 'This service is not available, Please try again later');
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyService("Pay Tax"),
                                ),
                              );
                            }
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 211, 211) , borderRadius:BorderRadius.circular(40) ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on_outlined, size: 20),
                              Text("Pay Tax", style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      ),



                      GestureDetector(
                        onTap: () {
                          data.getServices(context, "netflix").then((options){
                            if(options.length == 0){
                              AppUtils.showSnackBar(
                                  context, ContentType.failure, 'This service is not available, Please try again later');
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalInfo(),
                                ),
                              );
                            }
                          });
                        },
                        child:Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 211, 211) , borderRadius:BorderRadius.circular(40) ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.tv, size: 20),
                              Text("Netflix", style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if(data.isLoading)...[
              showIsLoading()
            ]
          ])
        ]);
  });
}
