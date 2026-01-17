import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/app_utils.dart';
import '../../provider/service.dart';
import '../../widgets/primary_button.dart';

class SubmissionConfirmationScreen extends StatefulWidget {

  const SubmissionConfirmationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SubmissionConfirmationScreenState createState() => _SubmissionConfirmationScreenState();
}


class _SubmissionConfirmationScreenState extends State<SubmissionConfirmationScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __)
    {
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
                    style: Theme
                        .of(context)
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
                  'Submission Details',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall,
                ),
                SizedBox(height: 20),
                Text('Payment Method: ${model.formData['payment_method']}'),
                SizedBox(height: 5),
                if (model.formData['payment_method'] == 'momo')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Momo Name: ${model.formData['momo_name']}'),
                      SizedBox(height: 5),
                      Text('Momo Number: ${model.formData['momo_number']}'),
                    ],),
                if (model.formData['payment_method'] == 'btc')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Wallet_id: ${model.formData['wallet_id']}'),
                    ],),
                SizedBox(height: 5),
                Text('Gift Card Amount: ${model.formData['from']}  ${model.formData['amount']}'),
                SizedBox(height: 5),
                Text('Receivable Amount: ${model.formData['to']} ${(double.parse(model.formData['amount_received']) * double.parse(model.formData['rate'])/100).toString()}'),
                SizedBox(height: 5),
                Text('Card Type: ${model.formData['type']}'),
                SizedBox(height: 5),
                if (model.formData['type'] == 'digital') Text('Instructions: ${model.formData['code']}'),
                if (model.formData['type'] == 'physical') Text(
                    'Images Uploaded: ${model.cardImages?.length ?? 0}'),
                SizedBox(height: 20),

                PrimaryButton(
                    buttonText: 'Confirm Submission',
                    onClickBtn:  () {
                      model.saveService(context);
                    }
                )
              ],
            ),
          ),
        ),
        if(model.isLoading)...[
          showIsLoading()
        ]
      ],);
    });
  }
}
