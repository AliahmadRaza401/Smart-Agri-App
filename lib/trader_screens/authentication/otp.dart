import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

final pinController = TextEditingController();
final pinFocusNode = FocusNode();

final _formKey = GlobalKey<FormState>();

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: noColor,
          iconTheme: const IconThemeData(
            color: myGreen,
          ),
          elevation: 0.0,
        ),
        body: Center(
          child: SizedBox(
            width: dynamicWidth(context, .86),
            height: dynamicHeight(context, .84),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: dynamicHeight(context, .2),
                            bottom: dynamicHeight(context, .06),
                          ),
                          child: AutoSizeText(
                            "Enter the 4 digit code sent to your Number",
                            style: TextStyle(
                              color: myGreen,
                              fontSize: dynamicWidth(context, .05),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: pinCode(context),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .04),
                    ),
                    child: button(context, "Verify", () {}),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget pinCode(BuildContext context) {
  final BoxDecoration pinDecoration = BoxDecoration(
    color: myGreen,
    borderRadius: BorderRadius.circular(
      dynamicWidth(context, .02),
    ),
  );

  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, .02),
      horizontal: dynamicWidth(context, .08),
    ),
    child: PinPut(
      fieldsCount: 4,
      withCursor: true,
      textStyle: TextStyle(
        fontSize: dynamicWidth(context, .06),
        color: myGrey,
      ),
      eachFieldWidth: dynamicWidth(context, .12),
      eachFieldHeight: dynamicHeight(context, .08),
      // onSubmit: (String pin) => _showSnackBar(pin),

      focusNode: pinFocusNode,
      controller: pinController,
      submittedFieldDecoration: pinDecoration,
      selectedFieldDecoration: pinDecoration,
      followingFieldDecoration: pinDecoration,
      pinAnimationType: PinAnimationType.fade,
    ),
  );
}
