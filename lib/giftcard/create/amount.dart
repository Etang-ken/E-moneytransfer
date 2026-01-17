import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../api/request.dart';
import '../../helper/app_utils.dart';
import '../../provider/service.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';
import 'cardtype.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AmountScreenState createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {

  bool isConverting = false;

  var model = null;

  @override
  void initState() {
    model = Provider.of<ServiceProvider>(context, listen: false);
    super.initState();
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'CAD',
      'label': 'CAD',
    },
    {
      'value': 'USD',
      'label': 'USD',
    },
    {
      'value': 'XAF',
      'label': 'XAF',
    },
  ];

  final List<Map<String, dynamic>> _crypto = [
    {
      'value': 'XAF',
      'label': 'XAF',
    },
    {
      'value': 'BTC',
      'label': 'Bitcoin',
    },
    {
      'value': 'ETH',
      'label': 'Ethereum',
    },
    {
      'value': 'BNB',
      'label': 'BNB',
    },
    {
      'value': 'SOL',
      'label': 'Solana',
    },
    {
      'value': 'XRP',
      'label': 'XRP',
    },
    {
      'value': 'TON',
      'label': 'Toncoin',
    },
    {
      'value': 'DOGE',
      'label': 'Dogecoin',
    },
    {
      'value': 'ADA',
      'label': 'Cardano',
    },
    {
      'value': 'USDT',
      'label': 'Tether',
    },
    {
      'value': 'USDC',
      'label': 'USD Coin',
    },
    {
      'value': 'XRP',
      'label': 'XRP',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __) {
      return Stack(children: [
        Scaffold(
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
                Text("Sell Gift Card",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white)),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  'How much do you want to sell ?',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    TextInputField(
                      textInputType: TextInputType.number,
                      contentPadding: const EdgeInsets.only(
                        right: 45,
                        top: 17,
                        bottom: 17,
                        left: 60,
                      ),
                      onChanged: (val) {
                        model.formData['amount'] = val!;
                      },
                      inputValidator: (val) {
                        if (val!.isEmpty) {
                          return "Amount is required";
                        }
                        return null;
                      },
                    ),
                    Positioned(
                        child: Container(
                      width: 40,
                      child: SelectFormField(
                        type: SelectFormFieldType.dropdown,
                        initialValue: model.formData['from'],
                        changeIcon: true,
                        items: _items,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                            suffixIconConstraints: BoxConstraints(maxWidth: 5),
                            suffixIcon:
                                Icon(Icons.keyboard_arrow_down, size: 20),
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 17),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                        onChanged: (val) {
                          setState(() {
                            model.formData['amount_received'] = "";
                            model.formData['from'] = val;
                          });
                        },
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Amount Receivable',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Stack(
                  children: [
                    TextInputField(
                      inputController: TextEditingController(
                          text: model.formData['amount_received'].toString()),
                      textInputType: TextInputType.number,
                      enabled: false,
                      contentPadding: const EdgeInsets.only(
                        right: 45,
                        top: 17,
                        bottom: 17,
                        left: 120,
                      ),
                    ),
                    Positioned(
                        left: 5,
                        child: SizedBox(
                          width: 80,
                          child: SelectFormField(
                            type: SelectFormFieldType.dropdown,
                            initialValue: model.formData['to'],
                            changeIcon: true,
                            enabled: model.formData['payment_method'] == "btc",
                            items: _crypto,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                                suffixIconConstraints:
                                    BoxConstraints(maxWidth: 5),
                                suffixIcon:
                                    Icon(Icons.keyboard_arrow_down, size: 20),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 17),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                            onChanged: (val) {
                              setState(() {
                                model.formData['amount_received'] = "";
                                model.formData['to'] = val;
                              });
                            },
                          ),
                        )),
                    Positioned(
                        right: 0,
                        bottom: 2,
                        child: SizedBox(
                            child: PrimaryButton(
                          buttonText: 'Check',
                          onClickBtn: () {
                            convert();
                          },
                        ))),
                  ],
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  buttonText: 'Next',
                  onClickBtn: model.formData['amount'] != "" && model.formData['amount_received'] != ""
                      ? () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardTypeScreen(),
                            ),
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
        if (isConverting) showIsLoading(),
      ]);
    });
  }

  Future<void> convert() async {
    if (model.formData['amount'] != "") {
      setState(() {
        isConverting = true;
      });
      final response = await APIRequest()
          .postRequest(route: "/transactions/estimate", data: {
        'type': 'momo',
        'amount': model.formData['amount'],
        'from': model.formData['from'],
        'to': model.formData['to'],
      });


      setState(() {
        isConverting = false;
      });

      if (response != 'error') {
        dynamic responseBody = response;

        model.formData['amount_received'] = (((100-double.parse(response['commission']))/100 )* double.parse(response['rate'])*double.parse(model.formData['amount'])).toString();

        model.formData['rate'] = (100 - double.parse(response['commission'])).toString();

        if (!responseBody["success"]) {
          AppUtils.showSnackBar(
              context, ContentType.failure, responseBody["message"]);
        } else {
          //here
        }
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
          context, ContentType.failure, 'Enter amount on card');
    }
  }
}
