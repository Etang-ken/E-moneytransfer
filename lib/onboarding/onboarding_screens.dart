import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:elcrypto/onboarding/auth/login.dart';
import '../models/onbording_model.dart';

class OnboardingScreens extends StatefulWidget {
  @override
  _OnboardingScreensState createState() => new _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  var currentIndex = 0;
  var previousIndex = 0;

  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

    return Scaffold(
        body: Container(
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      child: PageView.builder(
        controller: _controller,
        itemCount: content.length,
        onPageChanged: (int i) {
          setState(() {
            previousIndex = currentIndex;
            currentIndex = i;
          });
        },
        itemBuilder: (context, i) => Container(
            child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              // constraints: BoxConstraints(minHeight: 350),
              child: Image.asset(
                content[i].image,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            if (currentIndex == 2)
              SizedBox(
                height: 30,
              ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildDot(currentIndex == 0, currentIndex > 0),
                    const SizedBox(
                      width: 10,
                    ),
                    buildDot(currentIndex == 1, currentIndex > 1),
                    const SizedBox(
                      width: 10,
                    ),
                    buildDot(currentIndex == 2, currentIndex > 2),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.topCenter,
              width: double.infinity,
              // height: phoneHeight * 0.1,
              child: Column(
                children: [
                  Text(
                    content[i].title,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          height: 1.2,
                          color: AppUtils.PrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    content[i].description,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppUtils.Secondary),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  children: [
                    MaterialButton(
                        minWidth: double.infinity,
                        elevation: 0,
                        color: AppUtils.YellowColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          // if (currentIndex == content.length - 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
                          // } else {
                          //   _controller.nextPage(
                          //       duration: const Duration(milliseconds: 100),
                          //       curve: Curves.easeIn);
                          // }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    SizedBox(height: 12),
                    MaterialButton(
                        minWidth: double.infinity,
                        elevation: 0,
                        color: AppUtils.White,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppUtils.PrimaryColor,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          if (currentIndex == content.length - 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
                          } else {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppUtils.PrimaryColor,
                                    ),
                              ),
                            )
                          ],
                        )),
                    SizedBox(height: 80),
                  ],
                )),
          ],
        )),
      ),
    ));
  }

  Widget buildDot(bool isActive, bool passed) {
    return Container(
        height: 9,
        width: isActive ? 50 : 9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppUtils.PrimaryColor),
            color: isActive || passed
                ? Theme.of(context).primaryColor
                : Colors.white));
  }
}
