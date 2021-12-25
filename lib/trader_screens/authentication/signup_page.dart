import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/auth_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/trader_screens/authentication/login.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/image_piker.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/form_fields.dart';
import 'package:smart_agri/widgets/rich_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _image;
  String? imageUrl;

  final _formKey = GlobalKey<FormState>();

  final fName = TextEditingController();
  final lName = TextEditingController();
  final number = TextEditingController();
  final password = TextEditingController();
  final cnic = TextEditingController();
  final cPassword = TextEditingController();
  final signUpEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpEmail.clear();
    password.clear();
    cPassword.clear();
    fName.clear();
    lName.clear();
    number.clear();
    cnic.clear();
  }

  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<AuthProvider>(context).loading;

    return SafeArea(
      child: Container(
        width: dynamicWidth(context, 1),
        height: dynamicHeight(context, 1),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/bg.jpeg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: dynamicWidth(context, 1),
          height: dynamicHeight(context, 1),
          color: myBlack.withOpacity(0.6),
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
                  height: dynamicHeight(context, .88),
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
                        profilePicture(context),
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
                                  "First Name",
                                  fName,
                                  TextInputType.name,
                                  function: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a valid Name';
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
                                  "Last Name",
                                  lName,
                                  TextInputType.name,
                                  function: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a valid Name';
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
                                  "Mobile Number",
                                  number,
                                  TextInputType.phone,
                                  function: (value) {
                                    if (value!.isEmpty || value.length < 10) {
                                      return 'Please enter a valid Number';
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
                                  "CNIC",
                                  cnic,
                                  TextInputType.number,
                                  function: (value) {
                                    if (value!.isEmpty || value.length <= 13) {
                                      return 'Please enter a valid CNIC';
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
                                  "Email",
                                  signUpEmail,
                                  TextInputType.emailAddress,
                                  function: (value) {
                                    if (EmailValidator.validate(value)) {
                                    } else {
                                      return "Enter Valid Email";
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
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: inputTextField(
                                  context,
                                  "Confirm Password",
                                  cPassword,
                                  TextInputType.visiblePassword,
                                  password: true,
                                  function: (value) {
                                    if (value!.isEmpty ||
                                        value.toString() != password.text) {
                                      return 'Password must be Same!';
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
                            loading == true ? "Loading..." : "Sign Up",
                            () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                if (_image != null) {
                                  AuthServices.signUp(
                                    context,
                                    signUpEmail.text,
                                    password.text,
                                    fName.text,
                                    lName.text,
                                    number.text,
                                    cnic.text,
                                    _image,
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return oopsAlert(context,
                                          "Image Required! \n kindly Add your profile image");
                                    },
                                  );
                                }
                              }
                            },
                          ),
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
                                myWhite,
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
        ),
      ),
    );
  }

  Widget profilePicture(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: openFilePicker,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: myGrey,
          child: _image != null
              ? ClipOval(
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                )
              : Icon(
                  Icons.camera_alt,
                ),
        ),
      ),
    );
  }

  Future<void> openFilePicker() async {
    var image = await pickImageFromGalleryOrCamera(context);
    if (image == null) return;

    setState(() => _image = image);
    print('_image: $_image');
  }
}
