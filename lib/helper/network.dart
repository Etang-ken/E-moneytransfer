import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:elcrypto/helper/session_manager.dart';

final String liveUrl = 'http://pf-home.lehone.net/';
final String baseUrl = 'http://pf-home.lehone.net/';
// final String liveUrl = 'http://172.20.10.2/';
// final String baseUrl = 'http://172.20.10.2/';


class HttpResource {

  Future<dynamic> get(String endpoint) async {
    var url = Uri.parse(liveUrl + endpoint);
    print(url);
    String token = await SessionManager().getToken();
    try {
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      return response;
    } catch (error) {
      return "error";
    }
  }

  Future<void> share(String title, String text, String link) async {
    await FlutterShare.share(
        title: title,
        text: text,
        linkUrl: link,
        chooserTitle: 'Share with ?'
    );
  }


  Widget circleProgressBar() {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
            child: CircularProgressIndicator(
              color: Color(0xff4e8644),
              strokeWidth: 2,
            )));
  }

  Future<dynamic> getNotifications() async {
    final url = Uri.parse(liveUrl + "api/notifications");
    String token = await SessionManager().getToken();
    try {
      var response = await http.post(url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      return json.decode(response.body)["notifications"];
    } catch (error) {
      return "Network";
    }
  }

  Future<bool> deleteAccount() async {
    final url = Uri.parse(liveUrl + "api/delete_account");
    String token = await SessionManager().getToken();
    try {
      var response = await http.post(url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      return true;
    } catch (error) {
      return false;
    }
  }

  Widget noConnection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: const [
          Icon(
            Icons.network_check_outlined,
            size: 60,
            color: Color(0xff4e8644),
          ),
          Text("Check your device internet connection")
        ],
      ),
    );
  }


  Future<dynamic> post({required String endpoint, dynamic data}) async {
    var url = Uri.parse(liveUrl + endpoint);
    String token = await SessionManager().getToken();
    Map<String, String> ;
    try {
      final response = await http.post(url, body: data, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.body);
      if(response.statusCode == 200){
        return  json.decode(response.body);
      }else{
        return 'error';
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      return "error";
    }
  }

  Future<dynamic> auth({required String endpoint, dynamic data}) async {
    var url = Uri.parse(liveUrl + endpoint);
    String token = await SessionManager().getToken();
    Map<String, String> ;
    try {
      final response = await http.post(url, body: data, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.body);
      if(response.statusCode == 200){
        return  json.decode(response.body);
      }else{
        return 'error';
      }
    } catch (error, stackTrace) {
      print(stackTrace);
      return "error";
    }
  }

}
