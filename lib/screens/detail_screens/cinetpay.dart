import 'package:cinetpay/cinetpay.dart';
import 'package:elcrypto/api/url.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:flutter/material.dart';

class LaunchCinetpay extends StatefulWidget {
  const LaunchCinetpay({super.key});

  @override
  State<LaunchCinetpay> createState() => _LaunchCinetpayState();
}

class _LaunchCinetpayState extends State<LaunchCinetpay> {
  final String transactionId = DateTime.now().toString();
  IconData? icon;
  Map<String, dynamic>? response;
  Color? color;
  bool show = false;
  String? message;

  @override
  Widget build(BuildContext context) {
    return CinetPayCheckout(
      title: 'Payment Checkout',

      titleStyle: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppUtils.DarkColor,
          ),
      titleBackgroundColor: AppUtils.PrimaryColor,
      configData: <String, dynamic>{
        'apikey': AppUrl.cinetpayApiKey,
        'site_id': int.parse(AppUrl.cinetpaySiteId),
        'notify_url': "${AppUrl.baseUrl}/subscription/cinetpay"
      },
      paymentData: <String, dynamic>{
        'transaction_id': transactionId,
        // 'amount': paymentAmount,
        'amount': '100',
        'currency': 'XAF',
        'channels': 'MOBILE_MONEY',
        'description': 'Payment test',
      },
      waitResponse: (data) {
        if (mounted) {
          setState(() {
            response = data;
            icon = data['status'] == 'ACCEPTED'
                ? Icons.check_circle
                : Icons.mood_bad_rounded;
            color = data['status'] == 'ACCEPTED'
                ? AppUtils.GreenColor
                : AppUtils.RedColor;
            show = true;
          });
        }
        // submitForm({'status': 'ACCEPTED', 'payment_method': 'MTNCM'}, "8928977832");
      },
      onError: (data) {
        if (mounted) {
          setState(() {
            response = data;
            message = response!['description'];
            icon = Icons.warning_rounded;
            color = AppUtils.PrimaryColor;
            show = true;
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
