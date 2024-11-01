import 'dart:async';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:elcrypto/paypal/paypal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../api/url.dart';

class PaypalPayment extends StatefulWidget {
  final dynamic formData;

  final dynamic paymentDetails;

  final Function onFinish;

  const PaypalPayment({super.key, required this.onFinish, required this.formData , required this.paymentDetails});

  @override
  State<PaypalPayment> createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {

  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  PaypalServices services = PaypalServices();


// You may alter the default value to whatever you like.
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = '${AppUrl.appUrl}api/paypal/callback';
  String cancelURL = '${AppUrl.appUrl}api/paypal/back';

  var key = GlobalKey<NavigatorState>();

  late BuildContext context;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();



    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken(widget.paymentDetails["id"],widget.paymentDetails["secret"],widget.paymentDetails["url"]);

        final transactions = getOrderParams();
        final res =
        await services.createPaypalPayment(transactions, accessToken, widget.paymentDetails["url"]);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];

            _controller..loadRequest(Uri.parse(checkoutUrl!));
          });
        }
      } catch (ex) {
        final snackBar = SnackBar(
          content: Text(ex.toString()),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code for undoing the alteration.
            },
          ),
        );
        _scaffoldKey.currentState?.showSnackBar(snackBar);

      }
    });

    itemName = "Buy Crypto";
    itemPrice = widget.formData['amount_send'];

    totalAmount = widget.formData['amount_send'];
    subTotalAmount = widget.formData['amount_send'];

    defaultCurrency = {
      "symbol": "${widget.formData['from']} ",
      "decimalDigits": 2,
      "symbolBeforeTheNumber": true,
      "currency": widget.formData['from']
    };

    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features



    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.contains(returnURL)) {
                final uri = Uri.parse(request.url);
                final payerID = uri.queryParameters['PayerID'];
                if (payerID != null) {
                  services
                      .executePayment(executeUrl, payerID, accessToken)
                      .then((id) {
                    Navigator.pop(context);
                    widget.onFinish!(id);
                  });
                } else {
                  key?.currentState?.pop();
                }
                key?.currentState?.pop();
              }
              if (request.url.contains(cancelURL)) {
                key?.currentState?.pop();
              }
              return NavigationDecision.navigate;
            }

        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );


    _controller = controller;
  }

// item name, price and quantity here
  String itemName = '';
  String itemPrice = '';
  int quantity = 1;

  String totalAmount = '';
  String subTotalAmount = '';

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];

    // Checkout Invoice Specifics

    String shippingCost = '0';
    int shippingDiscountCost = 0;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext rcontext) {
    context = rcontext;

    if (checkoutUrl != null) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppUtils.PrimaryColor,
          title:  Text(
            "Elcrypto",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white),
          ),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios, color: Colors.white,),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebViewWidget(
          controller: _controller,
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          foregroundColor: AppUtils.PrimaryColor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {

                key?.currentState?.pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }



}
