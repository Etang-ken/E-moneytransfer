import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eltransfer/screens/widgets/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../provider/service.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';
import 'options.dart';

class BuyService extends StatefulWidget {
  String title;

  BuyService(this.title);

  @override
  _BuyServiceState createState() => new _BuyServiceState();
}

class _BuyServiceState extends State<BuyService> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ServiceProvider>(builder: (_, model, __) {

      model.formData['service_id'] = model.options[0]["value"].toString();

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
              Text(widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white)),
            ],
          ),
        ),
        body: Stack(children: [
          Container(
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
                          Row(children: [
                            SizedBox(
                                width: 80,
                                child: Image.network(model.options[0]["image"],
                                    width: 80)),
                            const SizedBox(width: 20),
                            Text(
                              model.options[0]["label"],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          const SizedBox(height: 30),
                          Text(
                            "Service Number",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          TextInputField(
                            placeholderText: "",
                            textInputType: TextInputType.number,
                            onChanged: (val) {
                              model.formData['service_nu'] = val!;
                            },
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            buttonText: 'Fetch Bills',
                            onClickBtn: () {
                              print(model.formData['service_nu']);
                              if (model.formData['service_nu'] == "") {
                                AppUtils.showSnackBar(
                                    context, ContentType.failure,
                                    'The service number field is required');
                              }else {
                                model.getBills(context, model.formData['service_id']!, model.formData['service_nu']!).then((bills) {
                                  if(bills.length == 0){

                                  }else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ServiceOptions(model.options[0]["label"].toString()),
                                      ),
                                    );
                                  }
                                });
                              }

                            },
                          )
                        ],
                      )
                    ],
                  ),)),
          if(model.isLoading)...[
            showIsLoading()
          ]
        ],),
      );
    });
  }
}
