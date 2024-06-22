import 'dart:convert';
import 'package:elcrypto/helper/session_manager.dart';
import 'package:elcrypto/screens/detail_screens/add_payment_proof.dart';
import 'package:elcrypto/screens/detail_screens/bank_transfer.dart';
import 'package:elcrypto/screens/detail_screens/cinetpay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:elcrypto/widgets/primary_button.dart';
import '../../api/request.dart';

class ChoosePaymentMethod extends StatefulWidget {
  dynamic formData;


  ChoosePaymentMethod(this.formData);

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState(formData);
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {

  dynamic formData;


  _ChoosePaymentMethodState(this.formData);

  bool isConverting = false;

  int activePayment = 0;

  @override
  void initState() {
    super.initState();
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
              "Select Payment Method",
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
                   GestureDetector(
                     onTap: () {
                       SessionManager().getId().then((value){
                         formData['user_id'] = value;
                         if(formData['from'] == "XAF"){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => LaunchCinetpay(formData, int.parse(formData['amount_send'])),
                             ),
                           );
                         }else{
                           convert();
                         }
                       });
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
                                         .bodyText2!
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
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => BankTransfer(formData),
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
                             child: Image.asset("assets/images/bank_transfer.jpeg", height: 50,width: 50),

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
                                         .bodyText2!
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
           if (isConverting) showIsLoading()
         ],
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
        'from': formData['from'],
        'to': "XAF",
        'payable': formData['amount_send']
      });

      if (response != 'error') {
        dynamic responseBody = response;
        setState(() {
         double total = double.parse( formData['amount_send']) * double.parse(responseBody['rate']);
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
}

class SelectPaymentMethod extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
