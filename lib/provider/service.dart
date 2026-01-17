import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../helper/app_utils.dart';
import 'package:http/http.dart' as http;

class ServiceProvider extends ChangeNotifier {
  List<XFile> cardImages = [];

  dynamic formData = {
    "payment_method": "momo",
    "momo_number": "",
    "momo_name": "",
    "wallet_id": "",
    "amount": "",
    "amount_received": "",
    "type": "",
    "rate": "",
    "code": "",
    "from": "USD",
    "to": "XAF",
  };

  dynamic transactions = [];

  bool isLoading = false;

  Future<void> getTransactions(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try{
      transactions = [];
      final response = await APIRequest().getRequest(route: "/get-sales");


      if (response != "error") {
        transactions = jsonDecode(response.body)["data"];
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Network error. Please try again.');
      }
    }catch(e){

    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> saveService(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    var uri = Uri.parse("${AppUrl.baseUrl}/sell-giftcard");

    var request = http.MultipartRequest('POST', uri);
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'authToken');
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
    }

    Map<String, String> data = {};

    data['image_count'] = cardImages.length.toString();
    data['percentage'] = formData['rate'].toString();
    data['payment_method'] = formData['payment_method'];

    data['type'] = formData['type'].toString();
    data['amount'] = "${formData['amount']}";
    data['amount_payable'] = "${double.parse(formData['amount_received']) * double.parse(formData['rate'])/100}";


    Map<String, String> method = {};
    method["from"] =  formData['from'];
    method["to"] =  formData['to'];
    if (formData['payment_method'] == "momo") {
      method['momo_name'] = formData['momo_name'].toString();
      method['momo_number'] = formData['momo_number'].toString();
    } else {
      method['wallet_id'] = formData['wallet_id'].toString();
    }

    data['receivable_payload'] = jsonEncode(method);

    for (int i = 0; i < cardImages.length; i++) {
      var file = await http.MultipartFile.fromPath(
          'image$i', cardImages[i]!.path);
      request.files.add(file);
    }

    request.fields.addAll(data);
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);
      if (response.statusCode == 200) {
        dynamic body = jsonDecode(response.body);
        if(body['success']){
          AppUtils.showSnackBar(
            context,
            ContentType.success,
            'Transaction created successfully.',
          );

          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);


          formData = {
            "payment_method": "momo",
            "momo_number": "",
            "momo_name": "",
            "wallet_id": "",
            "amount": "",
            "amount_received": "",
            "type": "",
            "rate": "",
            "code": "",
            "from": "USD",
            "to": "XAF",
          };

          cardImages = [];
          getTransactions(context);
        }else{
          AppUtils.showSnackBar(
            context,
            ContentType.failure,
            body['message'],
          );
        }
      } else {
        AppUtils.showSnackBar(
          context,
          ContentType.failure,
          'Error saving transaction',
        );
      }
    }catch(e){
      AppUtils.showSnackBar(
        context,
        ContentType.failure,
        'Network error',
      );
    }
    isLoading = true;
    notifyListeners();
  }

  Future<String> convert(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final response = await APIRequest().postRequest(
        route: "/transactions/estimate",
        data: {
          'type': 'momo',
          'from': "XAF",
          'to': "BTC",
          'payable': formData['amount']
        });

    String amount = "";
    if (response != "error") {
      amount = response['receivable'];
    } else {
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Network error. Please try again.');
    }

    isLoading = false;
    notifyListeners();

    return amount;
  }

  void setLoading(bool bool) {
    isLoading = bool;
    notifyListeners();
  }

  void clear() {
    formData['wallet_id'] = '';
    formData['momo_name'] = '';
    formData['momo_number'] = '';
    notifyListeners();
  }
}
