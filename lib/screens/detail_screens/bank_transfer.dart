import 'dart:convert';
import 'dart:math';
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

class BankTransfer extends StatefulWidget {
  dynamic formData;


  BankTransfer(this.formData);

  @override
  State<BankTransfer> createState() => _BankTransferState(formData);
}

class _BankTransferState extends State<BankTransfer> {

  dynamic formData;


  _BankTransferState(this.formData);

  bool _showBankDetails = false;

  bool isConverting = false;

  int activePayment = 0;

  String _textToCopy = "";


  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('copied'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _textToCopy = "${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(1000)}";
    });
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
              "Bank Transfer",
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
                   Column(
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
                               "1. Copy the following code :",
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
                                      _textToCopy,
                                       style: Theme
                                           .of(context)
                                           .textTheme
                                           .bodyText1!
                                           .copyWith(
                                         fontSize: 15,
                                         fontWeight: FontWeight.w700,
                                       ),
                                     ),
                                     Expanded(child: Container()),
                                     GestureDetector(
                                       onTap: () {
                                         _copyToClipboard(_textToCopy);
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
                       Text(
                         "This unique message code allows ELCrypto to match deposits to user's account. You must include this code in the comment/message/note field of your Bank-Transfer transaction to avoid delay.",
                         style: Theme
                             .of(context)
                             .textTheme
                             .bodyText1!
                             .copyWith(fontSize: 13, color: Colors.red),
                       ),

                       Text(
                         "Deposits sent from a bank account that does not match the name on your ELcrypto Account will require manual approval and, in some cases will be rejected",
                         style: Theme
                             .of(context)
                             .textTheme
                             .bodyText1!
                             .copyWith(fontSize: 13, color: Colors.red),
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
                         "4. Paste the copied code into the designated field (comment/message/note).",
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
                               "Amount",
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
                                 formData['from']+" "+formData['amount_send'],
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(
                                   fontSize: 15,
                                 ),
                               ),
                               Expanded(child:  SizedBox(width: 30),),
                               GestureDetector(
                                 onTap: () {
                                   _copyToClipboard(formData['amount_send']);
                                 },
                                 child: Icon(
                                   Icons.copy,
                                   color: AppUtils.Secondary,
                                   size: 17,
                                 ),
                               )
                             ],)
                           ]),
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
                              Expanded(child:  SizedBox(width: 30),),
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
                                 formData["email"],
                                 style: Theme
                                     .of(context)
                                     .textTheme
                                     .bodyText1!
                                     .copyWith(
                                   fontSize: 15,
                                 ),
                               ),
                               Expanded(child:  SizedBox(width: 30),),
                               GestureDetector(
                                 onTap: () {
                                   _copyToClipboard(  formData["email"]);
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
                               Expanded(child:  SizedBox(width: 30),),
                               GestureDetector(
                                 onTap: () {
                                   _copyToClipboard("Why Elcrypto ?");
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
                               Expanded(child:  SizedBox(width: 30),),
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
                   const SizedBox(
                     height: 50,
                   ),
                   PrimaryButton(
                     buttonText: 'Continue',
                     onClickBtn: () {
                       formData["trid"] = _textToCopy;
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
}

class SelectPaymentMethod extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
