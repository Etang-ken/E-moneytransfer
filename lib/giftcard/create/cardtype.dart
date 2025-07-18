
import 'dart:io';

import 'package:elcrypto/giftcard/create/submittsion_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../helper/app_utils.dart';
import '../../provider/service.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';

class CardTypeScreen extends StatefulWidget {

  const CardTypeScreen({
    Key? key
  }) : super(key: key);

  @override
  _CardTypeScreenState createState() => _CardTypeScreenState();
}

class _CardTypeScreenState extends State<CardTypeScreen> {

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    var model = Provider.of<ServiceProvider>(context, listen: false);

    setState(() {
      model.cardImages = pickedFiles;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (_, model, __){
      return Scaffold(
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
                'Select Gift Card Type',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall,
              ),
              const Text(
                'What kind of gift card do you have ?',
              ),
              RadioListTile(
                title: Text('Digital Gift Card'),
                value: 'digital',
                groupValue:  model.formData['type'],
                onChanged: (value) {
                  setState(() {
                    model.formData['type'] = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text('Physical Gift Card'),
                value: 'physical',
                groupValue: model.formData['type'],
                onChanged: (value) {
                  setState(() {
                    model.formData['type'] = value.toString();
                  });
                },
              ),
              if (model.formData['type'] == 'digital') ...[
                const Text(
                  'Enter the instructions required to redeem the giftcard. ',
                ),
                TextInputField(
                  placeholderText: 'Type here',
                  inputController: TextEditingController(text: model.formData['code'] ),
                  maxLines: 5,
                  onChanged: (val) {
                    model.formData['code'] = val!;
                  },
                  inputValidator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter your digital gift card code';
                    }
                    return null;
                  },
                ),

              ],
              if (model.formData['type'] == 'physical') ...[
                PrimaryButton(
                  onClickBtn: _pickImages,
                  buttonText: 'Pick Gift Card Images',
                ),
                SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                    children: model.cardImages.map<Widget>((image) =>
                    Image.file(File(image.path), height: 100)
                ).toList()),
              ],
              SizedBox(height: 20),

              PrimaryButton(
                  buttonText: 'Submit Gift Card',
                  onClickBtn: _validateAndSubmit
              ),
            ],
          ),
        ),
      );
    });
  }

  void _validateAndSubmit() {
    var model = Provider.of<ServiceProvider>(context, listen: false);

    if (model.formData['type'] == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a gift card type')),
      );
      return;
    }

    if (model.formData['type'] == 'digital'
        && model.formData['code'] == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter gift card code')),
      );
      return;
    }

    if (model.formData['type'] == 'physical' && model.cardImages.length < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload front and back images of the gift card')),
      );
      return;
    }

    // Here you would typically send the data to your backend
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmissionConfirmationScreen(),
      ),
    );
  }
}
