import 'package:connectivity/connectivity.dart';
import 'package:emoneytransfer/onboarding/auth/login.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emoneytransfer/provider/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

final storage = FlutterSecureStorage();

class AppUtils {
  static const Color PrimaryColor = Color(0xFF008100);
  static Color PrimaryLight = Color(0xffEAE3E8);
  static Color GreenColor = Color(0xff019F01);
  static Color YellowColor = Color(0xffFF9719);
  static const Color AccentColor = Color(0xFFFF6908);
  static const Color DarkColor = Color(0xFF212121);
  static const Color PaleGreenColor = Color(0xFF33CCAA);
  static const Color RedColor = Color(0xFFEC0000);
  static const Color SecondaryGray = Color(0xFF868686);
  static const Color PalePink = Color.fromRGBO(252, 228, 236, 1);
  static const Color TertiaryExtraLight = Color.fromARGB(255, 231, 255, 234);
  static Color Secondary = Color(0xFF696969);
  static Color SecondaryGrayExtraLight = Color.fromARGB(255, 245, 245, 245);
  static Color White = Color(0xFFFFFFFF);

  static showSnackBar(BuildContext context, ContentType type, String message) {
    final snackBar = customSnackBar(
        context: context, data: {"message": message}, type: type);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showToast(Color color, String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  // final SessionManager ss = new SessionManager();
  showProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).backgroundColor,
                    color: Color(0xffFEDD1F),
                    strokeWidth: 4,
                    // value: 0.4,
                  ),
                ),
              ));
        });
  }

  showFilterDialog(BuildContext context, widget) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select filters to apply',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            content: widget,
          ),
        );
      },
    );
  }
}

Future<void> launchInApp(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppBrowserView,
  )) {
    throw Exception('Could not launch $url');
  }
}

Widget showIsLoading() {
  return Positioned.fill(
    child: Container(
      decoration: BoxDecoration(
        color: AppUtils.DarkColor.withOpacity(0.5),
      ),
      child: Center(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppUtils.PrimaryColor),
          ),
        ),
      ),
    ),
  );
}

Future<void> updateSharedPreference(dynamic data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', isNullStringValue(data['name']));
  prefs.setString('email', isNullStringValue(data['email']));
  prefs.setString('phone', isNullStringValue(data['phone']));
  prefs.setInt('admin', isNullIntValue(data['admin']));
  prefs.setString('profileUrl', isNullStringValue(data['profile']));
  prefs.setString('firstName', isNullStringValue(data['first_name']));
  prefs.setString('lastName', isNullStringValue(data['last_name']));
  prefs.setInt('id', isNullIntValue(data['id']));
}

Future<void> updateUserProvider(dynamic userData, BuildContext context) async {
  final UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);
  final data = {
    'id': userData['id'] ?? 0,
    'name': userData['name'] ?? '',
    'admin': userData['admin'] ?? 0,
    'email': userData['email'] ?? '',
    'phone': userData['phone'] ?? '',
    'firstName': userData['first_name'] ?? '',
    'lastName': userData['last_name'] ?? '',
    'profileUrl': userData['profile'] ?? ''
  };
  userProvider.updateUserData(data);
}

Future<void> updateUserProviderFromSharedPreference(
    BuildContext context) async {
  final UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final data = {
    'id': prefs.getInt('id') ?? 0,
    'name': prefs.getString('name') ?? '',
    'admin': prefs.getInt('admin') ?? 0,
    'email': prefs.getString('email') ?? '',
    'phone': prefs.getString('phone') ?? '',
    'firstName': prefs.getString('firstName') ?? '',
    'lastName': prefs.getString('lastName') ?? '',
    'profileUrl': prefs.getString('profileUrl') ?? ''
  };
  userProvider.updateUserData(data);
}

int isNullIntValue(val) {
  if (val == null) {
    return 0;
  } else {
    return val;
  }
}

String isNullStringValue(val) {
  if (val == null) {
    return '';
  } else {
    return val;
  }
}

Future<bool> hasInternetConnectivity(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    AppUtils.showSnackBar(
      context,
      ContentType.failure,
      'No internet connection. Please check your network.',
    );
    return false;
  } else {
    return true;
  }
}

String textCapitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

double calculateTotalItemPrice(List<dynamic> items) {
  if (items.isEmpty) {
    return 0.0;
  }

  double total = 0.0;

  for (Map<String, dynamic> item in items) {
    double price = (item['price'] ?? 0.0).toDouble();
    int quantity = item['quantity'] ?? 0;
    total += price * quantity;
  }

  return total;
}

int calculateTotalItemQuantity(List<dynamic> items) {
  if (items.isEmpty) {
    return 0;
  }

  int total = 0;

  for (Map<String, dynamic> item in items) {
    int quantity = item['quantity'] ?? 0;
    total += quantity;
  }

  return total;
}

double calculateSingleItemPrice(item) {
  double total = 0.0;
  double price = (item['price'] ?? 0.0).toDouble();
  int quantity = item['quantity'] ?? 0;
  total += price * quantity;
  return total;
}

String formatDateWithSlash(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr);
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  return "$day/$month/${dateTime.year}";
}

String formatDateWithHyphen(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr);
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  return "$day-$month-${dateTime.year}";
}

Color transactionStatusColor(String status) {
  String newStatus = status.toLowerCase();
  if (newStatus == 'completed') {
    return AppUtils.GreenColor;
  } else if (newStatus == 'processing') {
    return Colors.blue[200]!;
  } else if (newStatus == 'pending') {
    return AppUtils.YellowColor;
  } else if (newStatus == 'delivered') {
    return Colors.blue;
  } else {
    return AppUtils.RedColor;
  }
}

Future<void> appLogOut(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await storage.deleteAll();
  await prefs.clear();
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => LogIn()));
}
