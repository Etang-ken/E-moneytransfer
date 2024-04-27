import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoneytransfer/helper/app_utils.dart';
import 'package:emoneytransfer/widgets/general_button.dart';
import 'package:emoneytransfer/widgets/primary_button.dart';

class AddPaymentProof extends StatefulWidget {
  @override
  State<AddPaymentProof> createState() => _AddPaymentProofState();
}

class _AddPaymentProofState extends State<AddPaymentProof> {
  late ImagePicker _imagePicker;
  XFile? _imageFile;

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
        child: Center(
          child: Container(
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
                    onClickBtn: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Sele));
                    },
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
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
