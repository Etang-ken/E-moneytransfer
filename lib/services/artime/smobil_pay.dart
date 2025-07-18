import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../provider/service.dart';
import '../../widgets/text_field.dart';

class SmobilPaymentDialog extends StatefulWidget {
  @override
  _SmobilPaymentDialogState createState() => _SmobilPaymentDialogState();
}

class _SmobilPaymentDialogState extends State<SmobilPaymentDialog> {

  void _confirmPayment() {

    if(Provider.of<ServiceProvider>(context, listen: false).formData['payment_nu'].length  >= 9){
        Provider.of<ServiceProvider>(context, listen: false).save(context);
    }else if(Provider.of<ServiceProvider>(context, listen: false).formData['payment_service_id'] == ''){
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Please select payment method');
    }else{
      AppUtils.showSnackBar(
          context, ContentType.failure, 'The Payment number field is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __) {
      return AlertDialog(
        title: const Text('Complete Payment'),
        content: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Select Payment Method",
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  initialValue: model.formData['payment_service_id'],
                  items: model.payment_method,
                  style: TextStyle(fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1.2,
                          color: Color.fromARGB(66, 65, 65, 65),
                        ),
                        borderRadius: BorderRadius.circular(8.0)),
                    suffixIconConstraints:
                    const BoxConstraints(maxWidth: 5),
                    labelStyle:
                    const TextStyle(fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 17),
                  ),
                  onChanged: (val) {
                    setState(() {
                      model.formData['payment_service_id'] = val;
                      for (var plan in model.options) {
                        if(plan['value'].toString() == val.toString()){
                          model.formData['title'] = plan['label'];
                        }
                      }

                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Enter payment number'),
                const SizedBox(height: 5),
                TextInputField(
                  placeholderText: '6 12 34 57 89',
                  textInputType: TextInputType.number,
                  onChanged: (val) {
                    model.formData['payment_nu'] = val!;
                  },
                )
              ],
            ),
            if (model.isLoading) ...[showIsLoading()]
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Close'),
          ),
          if (!model.isLoading) ...[
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
