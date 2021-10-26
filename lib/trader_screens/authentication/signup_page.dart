import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';

import 'package:smart_agri/trader_screens/authentication/auth_services.dart';
import 'package:smart_agri/trader_screens/authentication/login.dart';
import 'package:smart_agri/utils/config.dart';

import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

final _formKey = GlobalKey<FormState>();

final fName = TextEditingController();
final lName = TextEditingController();
final number = TextEditingController();
final password = TextEditingController();
final cnic = TextEditingController();
final cPassword = TextEditingController();
final mail = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<AuthProvider>(context).loading;

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
            child: SizedBox(
              width: dynamicWidth(context, .86),
              height: dynamicHeight(context, .84),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: dynamicHeight(context, .03),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
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
                              "First Name",
                              fName,
                              TextInputType.name,
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
                              "Last Name",
                              lName,
                              TextInputType.name,
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
                              TextInputType.number,
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
                              "CNIC",
                              cnic,
                              TextInputType.number,
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
                              "Email",
                              mail,
                              TextInputType.name,
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
                              TextInputType.visiblePassword,
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
                              "Confirm Password",
                              cPassword,
                              TextInputType.visiblePassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: button(
                          context, loading == true ? "Loading..." : "Sign Up",
                          () {
                        AuthServices.signUp(context, mail.text, password.text,
                            fName.text, lName.text, number.text, cnic.text);
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        richTextWidget(
                            context,
                            "Already have an account?  ",
                            "Log In",
                            dynamicWidth(context, .04),
                            dynamicWidth(context, .05),
                            const LoginPage(),
                            myBlack,
                            myGreen,
                            false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputTextField(context, obscureText, label, myController, keyBoard,
      {function, function2}) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (function == "") ? () {} : function,
      controller: myController,
      textInputAction: TextInputAction.next,
      keyboardType: keyBoard,
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
        prefixText: label.toString().contains("Number") ? "+92 " : "",
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
