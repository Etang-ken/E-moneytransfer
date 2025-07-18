import 'package:eltransfer/helper/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/service.dart';

class BtcPaymentDialog extends StatefulWidget {
  final String btcAddress;
  final String amount;

  const BtcPaymentDialog(
      {Key? key, required this.btcAddress, required this.amount})
      : super(key: key);

  @override
  _BtcPaymentDialogState createState() => _BtcPaymentDialogState();
}

class _BtcPaymentDialogState extends State<BtcPaymentDialog> {
  void copyToClipboard(String val) {
    Clipboard.setData(ClipboardData(text: val));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('BTC Address Copied to Clipboard')),
    );
  }

  void _confirmPayment() {
    Provider.of<ServiceProvider>(context, listen: false).save(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __) {
      model.formData['amount_btc'] = widget.amount;
      model.formData['payment_method'] = "btc";
      return AlertDialog(
        title: const Text('Complete BTC Payment'),
        content: Stack(children: [Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please send ${widget.amount} BTC to:'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.btcAddress,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: (){
                    copyToClipboard(widget.btcAddress);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.amount,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: (){
                    copyToClipboard(widget.amount);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Important:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Open your BTC wallet\n'
                  '2. Paste the address above\n'
                  '3. Send the exact amount\n'
                  '4. Click "Confirm Payment" after sending',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Once the payment is complete, Click "Continue" to submit the transaction. We will verify the transaction and process your request in no time',
              style: TextStyle(color: Colors.orange),
            )
          ],
        ),
          if(model.isLoading)...[
           showIsLoading()
          ]
        ],),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Close'),
          ),
          if(!model.isLoading)...[
            ElevatedButton(
              onPressed: _confirmPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: null,
              ),
              child: Text('Continue'),
            ),
          ]
        ],
      );
    });
  }
}
