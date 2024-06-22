import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elcrypto/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../../api/url.dart';
import '../../provider/transaction.dart';

class AddPaymentProof extends StatefulWidget {
  dynamic formData;


  AddPaymentProof(this.formData);

  @override
  State<AddPaymentProof> createState() => _AddPaymentProofState(formData);
}

class _AddPaymentProofState extends State<AddPaymentProof> {
  late ImagePicker _imagePicker;
  XFile? _imageFile;

  dynamic formData;


  _AddPaymentProofState(this.formData);

  bool isSavingTransaction = false;

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
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
              "Add Proof of Payment",
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
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 230,
                        width: double.infinity,
                        constraints: BoxConstraints(maxWidth: 400),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppUtils.SecondaryGray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile != null
                            ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                File(_imageFile!.path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Icon(
                          Icons.image,
                          size: 220,
                          color: AppUtils.SecondaryGray.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      buttonText: 'Submit',
                      onClickBtn: () async {
                        setState(() {
                          isSavingTransaction = true;
                        });

                        var uri = Uri.parse("${AppUrl.baseUrl}/transactions/create");
                        var request = http.MultipartRequest('POST', uri);
                        final storage = FlutterSecureStorage();
                        final token = await storage.read(key: 'authToken');
                        if (token != null) {
                          request.headers['Authorization'] = 'Bearer $token';
                          request.headers['Content-type'] = 'application/json';
                          request.headers['Accept'] = 'application/json';
                        }

                        var file = await http.MultipartFile.fromPath('image', _imageFile!.path);
                        request.files.add(file);
                        request.fields.addAll(formData);

                        var streamedResponse = await request.send();
                        var response = await http.Response.fromStream(streamedResponse);
                        if (response.statusCode == 200) {


                          AppUtils.showSnackBar(
                            context,
                            ContentType.success,
                            'Transaction created successfully.',
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Provider.of<TransactionProvider>(context, listen: false).getTransactions();

                        } else {
                          if (!mounted) return;
                          AppUtils.showSnackBar(
                            context,
                            ContentType.failure,
                            'Error saving transaction',
                          );
                        }

                        setState(() {
                          isSavingTransaction = false;
                        });
                      },
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
            if (isSavingTransaction) showIsLoading()
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
