import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/screens/widgets/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../provider/service.dart';
import '../../services/artime/pay.dart';
import '../../widgets/primary_button.dart';

class NetflixSubscriptionPlans extends StatefulWidget {
  @override
  _NetflixSubscriptionPlansState createState() =>
      new _NetflixSubscriptionPlansState();
}

class _NetflixSubscriptionPlansState extends State<NetflixSubscriptionPlans> {
  @override
  void initState() {
    Provider.of<ServiceProvider>(context, listen: false)
        .formData['service_id'] = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

    return Consumer<ServiceProvider>(builder: (_, model, __) {
      return Scaffold(
          backgroundColor: AppUtils.SecondaryGrayExtraLight,
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
                Text("Activate Netflix",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white)),
              ],
            ),
          ),
          body: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              // margin: EdgeInsets.only(bottom: 100),
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Netflix Subscription Plans",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          SelectFormField(
                            type: SelectFormFieldType.dropdown,
                            initialValue: model.formData['service_id'],
                            items: model.options,
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
                                model.formData['service_id'] = val;
                                for (var plan in model.options) {
                                  if (plan['value'].toString() == val.toString()) {
                                    model.formData['title'] = plan['label'];
                                    model.formData['type'] = "netflix";
                                    model.formData['amount'] =
                                        plan['amount'].toString();
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            buttonText: 'Active',
                            onClickBtn: () {
                              if (model.formData['service_id'] == "") {
                                AppUtils.showSnackBar(
                                    context,
                                    ContentType.failure,
                                    'Please select subscription plan');
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PayNow(),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ))));
    });
  }
}
