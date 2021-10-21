import 'package:flutter/material.dart';
import 'package:smart_agri/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

import 'login.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: dynamicWidth(context, 1),
          height: dynamicHeight(context, 1),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/login_bg.jpeg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: dynamicWidth(context, 1),
            height: dynamicHeight(context, 1),
            color: myBlack.withOpacity(0.5),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, .12),
                  ),
                  child: Text(
                    "Well Come to\nSmart Agri",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: dynamicWidth(context, .08),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: dynamicHeight(context, .3),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, .02),
                  ),
                  child: button(context, "Login as Trader",
                      page: const LoginPage()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, .02),
                  ),
                  child: button(context, "Login as Farmer"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
