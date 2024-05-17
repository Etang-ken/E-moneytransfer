import 'dart:convert';
import 'package:elcrypto/helper/session_manager.dart';
import 'package:elcrypto/screens/detail_screens/add_payment_proof.dart';
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

  bool _showBankDetails = false;

  bool isConverting = false;

  int activePayment = 0;
  final String _textToCopy = "2672-2662-3672-2727";

  void setActivePayment(int val) {
    setState(() {
      activePayment = val;
    });
  }

  void setShowBankDetails() {
    setState(() {
      _showBankDetails = !_showBankDetails;
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
                       setActivePayment(1);
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
                                   Text(
                                     "+237 672349837",
                                     style: Theme.of(context)
                                         .textTheme
                                         .bodyText1!
                                         .copyWith(fontSize: 12),
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
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                     decoration: BoxDecoration(
                         color: activePayment == 2
                             ? Colors.blue.withOpacity(0.3)
                             : null,
                         border: Border.all(
                             color: AppUtils.SecondaryGray.withOpacity(0.4)),
                         borderRadius: BorderRadius.circular(10)),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           '**Please follow these steps:**',
                           style: Theme
                               .of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(
                               fontSize: 13,
                               fontWeight: FontWeight.w600),
                         ),
                         const SizedBox(
                           height: 10,
                         ),
                         Text.rich(
                           TextSpan(
                             children: [
                               TextSpan(
                                 text:
                                 "1. Copy the following bank account number:",
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(fontSize: 13),
                               ),
                               WidgetSpan(
                                   child: Row(
                                     children: [
                                       Text(
                                         "2672-2662-3672-2727",
                                         style: Theme
                                             .of(context)
                                             .textTheme
                                             .bodyText1!
                                             .copyWith(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w700,
                                         ),
                                       ),
                                       const SizedBox(width: 10),
                                       GestureDetector(
                                         onTap: () {
                                           _copyToClipboard("2672-2662-3672-2727");
                                         },
                                         child: Icon(
                                           Icons.copy,
                                           color: AppUtils.Secondary,
                                           size: 17,
                                         ),
                                       )
                                     ],
                                   ))
                             ],
                           ),
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         Text(
                           "2. Open your banking app or visit your bank's website.",
                           style: Theme
                               .of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(fontSize: 13),
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         Text(
                           "3. Initiate a transfer or deposit funds.",
                           style: Theme
                               .of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(fontSize: 13),
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         Text(
                           "4. Paste the copied bank account number into the designated field.",
                           style: Theme
                               .of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(fontSize: 13),
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         Text(
                           "5. Verify the account details (name, bank) before finalizing the deposit.",
                           style: Theme
                               .of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(fontSize: 13),
                         ),
                         const SizedBox(
                           height: 10,
                         ),
                         Text(
                           "**Important:** Ensure you trust the recipient before making any deposit.",
                           style: Theme
                               .of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(
                               fontSize: 13,
                               fontWeight: FontWeight.w600),
                         ),

                         SizedBox(height: 30,),
                         Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Name",
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               Row(children: [
                                 Text(
                                   "Francis Nzebile",
                                   style: Theme
                                       .of(context)
                                       .textTheme
                                       .bodyText1!
                                       .copyWith(
                                     fontSize: 15,
                                   ),
                                 ),
                                 SizedBox(width: 30),
                                 GestureDetector(
                                   onTap: () {
                                     _copyToClipboard("Francis Nzebile");
                                   },
                                   child: Icon(
                                     Icons.copy,
                                     color: AppUtils.Secondary,
                                     size: 17,
                                   ),
                                 )
                               ],)
                             ]),
                         SizedBox(height: 20,),
                         Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Email",
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               Row(children: [
                                 Text(
                                   "nmeneiimoh@gmail.com",
                                   style: Theme
                                       .of(context)
                                       .textTheme
                                       .bodyText1!
                                       .copyWith(
                                     fontSize: 15,
                                   ),
                                 ),
                                 SizedBox(width: 30),
                                 GestureDetector(
                                   onTap: () {
                                     _copyToClipboard("nmeneiimoh@gmail.com");
                                   },
                                   child: Icon(
                                     Icons.copy,
                                     color: AppUtils.Secondary,
                                     size: 17,
                                   ),
                                 )
                               ],)
                             ]),

                         SizedBox(height: 20,),
                         Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Security Question",
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               Row(children: [
                                 Text(
                                   "Why Eltransfer ?",
                                   style: Theme
                                       .of(context)
                                       .textTheme
                                       .bodyText1!
                                       .copyWith(
                                     fontSize: 15,
                                   ),
                                 ),
                                 SizedBox(width: 30),
                                 GestureDetector(
                                   onTap: () {
                                     _copyToClipboard("Why Eltransfer ?");
                                   },
                                   child: Icon(
                                     Icons.copy,
                                     color: AppUtils.Secondary,
                                     size: 17,
                                   ),
                                 )
                               ],)
                             ]),

                         SizedBox(height: 20,),
                         Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Answer",
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               Row(children: [
                                 Text(
                                   "01020304",
                                   style: Theme
                                       .of(context)
                                       .textTheme
                                       .bodyText1!
                                       .copyWith(
                                     fontSize: 15,
                                   ),
                                 ),
                                 SizedBox(width: 30),
                                 GestureDetector(
                                   onTap: () {
                                     _copyToClipboard("01020304");
                                   },
                                   child: Icon(
                                     Icons.copy,
                                     color: AppUtils.Secondary,
                                     size: 17,
                                   ),
                                 )
                               ],)
                             ]),
                       ],
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
                               builder: (context) => AddPaymentProof(formData)));
                     },
                   ),
                   const SizedBox(height: 35),
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

      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);
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
