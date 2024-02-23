import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:truelife_mobile/api/url.dart';

class APIRequest {
  postRequest(
      {required String route, required Map<String, dynamic> data}) async {
    String url = "${AppUrl.baseUrl}$route";
    Map<String, String>? headers = await _header();
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: headers,
    );
    print(url);
    // If the server returns a 200 OK response, you can print the response body
    return response;
  }

  Future<dynamic> getRequest({required String route}) async {
    String url = "${AppUrl.baseUrl}$route";
    Map<String, String>? headers = await _header();
    final result = await http.get(Uri.parse(url), headers: headers);
    return result;
  }

  _header() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'authToken');
    if (token == null) {
      return {'Content-type': 'application/json', 'Accept': 'application/json'};
    } else {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
  }
}
