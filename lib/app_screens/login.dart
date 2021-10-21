import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/app_screens/signup_page.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

import '../config.dart';

final _formKey = GlobalKey<FormState>();

final number = TextEditingController();
final password = TextEditingController();

class LoginPage extends StatefulWidget {
  final dynamic name;

  const LoginPage({Key? key, this.name}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: dynamicWidth(context, .86),
              height: dynamicHeight(context, .7),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: dynamicHeight(context, .1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            color: myGreen,
                            fontSize: dynamicWidth(context, .1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: inputTextField(
                            context,
                            false,
                            "Mobile Number",
                            number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: inputTextField(
                            context,
                            true,
                            "Password",
                            password,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        richTextWidget(
                            context,
                            "Don't have an account?  ",
                            "Sign Up",
                            dynamicWidth(context, .04),
                            dynamicWidth(context, .05),
                            const SignUpPage(),
                            myBlack,
                            myGreen,
                            true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputTextField(context, obscureText, label, myController,
      {function, function2}) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (function == "") ? () {} : function,
      controller: myController,
      textInputAction: TextInputAction.next,
      keyboardType: obscureText == true
          ? TextInputType.visiblePassword
          : TextInputType.phone,
      obscureText: obscureText,
      cursorColor: myGreen,
      cursorWidth: 2.0,
      cursorHeight: dynamicHeight(context, .034),
      decoration: InputDecoration(
        suffixIcon: obscureText == false
            ? null
            : InkWell(
                onTap: function2,
                child: const Icon(
                  Icons.remove_red_eye_rounded,
                  color: myGreen,
                ),
              ),
        contentPadding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .02),
          horizontal: dynamicWidth(context, .03),
        ),
        prefixText: obscureText == false ? "+92 " : "",
        prefixStyle: TextStyle(
          color: myGreen,
          fontSize: dynamicWidth(context, .046),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: myGreen,
          fontSize: dynamicWidth(context, .04),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: myGreen),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: myGreen),
        ),
      ),
    );
  }

  Widget richTextWidget(
      context, text1, text2, size1, size2, page, color1, color2, push) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
              fontSize: size1,
              color: color1,
            ),
          ),
          page == ""
              ? TextSpan(
                  text: text2,
                  style: TextStyle(
                    fontSize: size2,
                    color: color2,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => push == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => page,
                            ),
                          )
                        : Navigator.pop(context),
                  text: text2,
                  style: TextStyle(
                    fontSize: size2,
                    color: color2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }
}
