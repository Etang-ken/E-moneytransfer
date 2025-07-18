import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../api/request.dart';
import '../helper/app_utils.dart';

class ServiceProvider extends ChangeNotifier {
  dynamic formData = {
    "name": "",
    "email": "",
    "address": "",
    "mobile": "",
    "service_id": "",
    "title": "",
    "wallet": "",
    "service_nu": "",
    'payment_nu': "",
    "amount_btc": "",
    "payment_method": "",
    "payment_service_id":"",
    "type": "",
    "amount": "",
    "payment_item_id": "",
    "merchant": "",
  };

  List<Map<String, dynamic>> payment_method = [];

  List<Map<String, dynamic>> options = [];

  List<Map<String, dynamic>> bills = [];

  dynamic netflix = [];

  dynamic services = [];

  bool isLoading = false;

  Future<void> getTransactions(BuildContext context, String type) async {
    isLoading = true;
    isLoading = true;
    notifyListeners();

    if (type == "netflix") {
      netflix = [];
      final response =
          await APIRequest().getRequest(route: "/get-subscription");
      if (response != "error") {
        netflix = jsonDecode(response.body)["transactions"];
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Network error. Please try again.');
      }
    } else {
      services = [];
      final response =
          await APIRequest().getRequest(route: "/service-transactions");
      if (response != "error") {
        services = jsonDecode(response.body)["transactions"];
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Network error. Please try again.');
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> saveService(BuildContext context) async {
    dynamic response = await APIRequest().postRequest(route: "/topup", data: {
      'amount': formData["amount"],
      'service_no': formData["service_nu"],
      'type':formData['type'],
      'service_id': formData["service_id"],
      'payment_service_id': formData["payment_service_id"],
      'payment_nu': formData["payment_nu"],
      'amountLocalCur': formData["amount"],
      'payItemId': formData["payment_item_id"]
    });

    if (response != "error") {
      if (response['status']) {
        AppUtils.showSnackBar(
            context, ContentType.success, "Request created successfully");
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, response['message']);
      }

      getTransactions(context, "bill");
      if(formData['type'] == "bill"){
        Navigator.pop(context);
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Network error. Please try again.');
    }

    isLoading = false;
    notifyListeners();

    return false;
  }

  Future<bool> saveNetflix(BuildContext context) async {
    final response =
        await APIRequest().postRequest(route: "/save-subscription", data: {
      'subscription_id': formData["service_id"],
      'name': formData["name"],
      'email': formData["service_id"],
      'address': formData["address"],
      'mobile': formData["mobile"],
      'payment_method': formData["payment_method"]
    });

    if (response != "error") {
      if (response['success']) {
        AppUtils.showSnackBar(
            context, ContentType.success, "Request created successfully");

        getTransactions(context, "netflix");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      } else {
        AppUtils.showSnackBar(
          context,
          ContentType.failure,
          response['message'],
        );
      }
    } else {
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Network error. Please try again.');
    }

    isLoading = false;
    notifyListeners();

    return false;

  }

  void checkStatus(String type) {
    isLoading = true;

    isLoading = false;
    notifyListeners();
  }

  Future<dynamic> getServices(BuildContext context, String type) async {
    isLoading = true;
    notifyListeners();
    options = [];

    if (type == "netflix") {
      final response =
          await APIRequest().getRequest(route: "/get-subscription-plans");
      if (response != "error") {
        formData["wallet"] = jsonDecode(response.body)["btc"];
        options = jsonDecode(response.body)["services"]
            .map<Map<String, dynamic>>((data) {
          return {
            'value': data['id'],
            'amount': data['amount'],
            'label': data['name'] + " (${data['amount'].toString()})",
          };
        }).toList();
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Network error. Please try again.');
      }
    } else {
      final response = await APIRequest()
          .getRequest(route: "/digital-services?type=" + type);
      if (response != "error") {
        formData["wallet"] = jsonDecode(response.body)["btc"];
        options = jsonDecode(response.body)["services"]
            .map<Map<String, dynamic>>((data) {
          return {
            'value': data['id'],
            'image': data['image'],
            'label': data['name'],
          };
        }).toList();
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Network error. Please try again.');
      }
    }

    isLoading = false;
    notifyListeners();

    return options;
  }

  Future<dynamic> getBills(
      BuildContext context, String service_id, String service_no) async {
    isLoading = true;
    notifyListeners();
    bills = [];

    final response = await APIRequest().getRequest(
        route: "/get-bills?service_id=${service_id}&service_no=${service_no}");

    print(jsonDecode(response.body));

    if (response != "error") {
      if (jsonDecode(response.body)["status"]) {
        bills = jsonDecode(response.body)["bills"]
            .map<Map<String, dynamic>>((data) {
          return {
            'type': data['billType'],
            'label': data['payItemDescr'],
            'payItemId': data['payItemId'],
            'amount': data['amountLocalCur'],
            'date': "${data['billMonth']}/${data['billYear']}"
          };
        }).toList();

        if (bills.length == 0) {
          AppUtils.showSnackBar(context, ContentType.failure,
              'No pending bills are available for this service number');
        }
      } else {
        AppUtils.showSnackBar(
            context, ContentType.failure, "Unexpected technical error");
      }
    } else {
      AppUtils.showSnackBar(
          context, ContentType.failure, 'Network error. Please try again.');
    }

    isLoading = false;
    notifyListeners();

    return bills;
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
        payment_method = response['payment_method']
            .map<Map<String, dynamic>>((data) {
          return {
            'value': data['id'],
            'image': data['image'],
            'label': data['name'],
          };
        }).toList();

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

  Future<void> save(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    bool success = false;
    if (formData['type'] == "netflix") {
      success = await saveNetflix(context);
    } else {
      success = await saveService(context);
    }

   if(success){
     formData = {
       "service_id": "",
       "title": "",
       "wallet": "",
       "service_nu": "",
       "payment_nu": "",
       "amount_btc": "",
       "payment_method": "",
       'name': "",
       'email': "",
       'address': "",
       'mobile': "",
       "type": "",
       "payment_service_id":"",
       "amount": "",
       "payment_item_id": "",
       "merchant": "",
     };
   }
  }
}
