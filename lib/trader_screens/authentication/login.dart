import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/auth_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/trader_screens/authentication/signup_page.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/farmer_bottom_nav.dart';
import 'package:smart_agri/widgets/form_fields.dart';
import 'package:smart_agri/widgets/rich_text.dart';

class LoginPage extends StatefulWidget {
  final dynamic name;

  const LoginPage({Key? key, this.name}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final fUsername = TextEditingController();

  // loginCheck() async {
  //   dynamic check, id;
  //   await FirebaseFirestore.instance
  //       .collection("farmers")
  //       .get()
  //       .then((querySnapshot) {
  //     for (var result in querySnapshot.docs) {
  //       if (result.data()["userName"].toString() == fUsername.text.toString() &&
  //           result.data()["password"].toString() == password.text.toString()) {
  //         id = result.reference.id;
  //         check = true;
  //         break;
  //       } else {
  //         check = false;
  //       }
  //     }
  //     if (check == true) {
  //       AppRoutes.push(
  //         context,
  //         FarmerBottomNav(
  //           farmerId: id,
  //         ),
  //       );
  //     } else if (check == false) {
  //       Fluttertoast.showToast(
  //         msg: "Invalid UserName or Password\nTry Again!!",
  //         backgroundColor: myGreen,
  //         textColor: myWhite,
  //         gravity: ToastGravity.CENTER,
  //       );
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    print('name: ${widget.name}');
    var loading = Provider.of<AuthProvider>(context).loading;
    return SafeArea(
      child: Container(
        width: dynamicWidth(context, 1),
        height: dynamicHeight(context, 1),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/bg.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: dynamicWidth(context, 1),
          height: dynamicHeight(context, 1),
          color: myBlack.withOpacity(0.7),
          child: Scaffold(
            backgroundColor: noColor,
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
                  height: dynamicHeight(context, .7),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: dynamicHeight(context, .04),
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
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: inputTextField(
                                  context,
                                  widget.name == "trader"
                                      ? "Email"
                                      : "UserName",
                                  widget.name == "trader" ? email : fUsername,
                                  widget.name == "trader"
                                      ? TextInputType.emailAddress
                                      : TextInputType.name,
                                  function: widget.name == "trader"
                                      ? (value) {
                                          if (EmailValidator.validate(value)) {
                                          } else {
                                            return "Enter Valid Email";
                                          }
                                          return null;
                                        }
                                      : (value) {
                                          if (value.toString().isNotEmpty) {
                                          } else {
                                            return "Enter Valid UserName";
                                          }
                                          return null;
                                        },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: inputTextField(
                                  context,
                                  "Password",
                                  password,
                                  TextInputType.visiblePassword,
                                  password: true,
                                  function: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Password must have 6 characters';
                                    }
                                    return null;
                                  },
                                  function2: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
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
                            context,
                            loading == true ? "Loading..." : "Login",
                            () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                print("Role ${widget.name}");
                                widget.name == "trader"
                                    ? AuthServices.signIn(
                                        context,
                                        email.text,
                                        password.text,
                                      )
                                    : AppRoutes.push(
                                        context,
                                        const FarmerBottomNav(),
                                      );
                                // : loginCheck();
                              }
                            },
                          ),
                        ),
                        widget.name == "trader"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  richTextWidget(
                                    context,
                                    "Don't have an account?  ",
                                    "Sign Up",
                                    dynamicWidth(context, .04),
                                    dynamicWidth(context, .05),
                                    const SignUpPage(),
                                    myWhite,
                                    myGreen,
                                    true,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
