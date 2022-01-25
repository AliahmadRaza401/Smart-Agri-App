import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/botton_nav.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/motion_toast.dart';

class EditTraderProfile extends StatefulWidget {
  final String firstName, secondName, mobileNumber, cnic;

  const EditTraderProfile({
    Key? key,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.cnic,
  }) : super(key: key);

  @override
  _EditTraderProfileState createState() => _EditTraderProfileState();
}

class _EditTraderProfileState extends State<EditTraderProfile> {
  final _formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final mobileNumber = TextEditingController();
  final cnic = TextEditingController();
  final password = TextEditingController();
  bool loader = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .04),
        ),
      ),
      backgroundColor: myWhite,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, .04),
                      vertical: dynamicHeight(context, .04),
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Update Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        Row(
                          children: const [
                            Text(
                              "Enter your new First Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: firstName
                            ..text = widget.firstName.toString(),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First Name can't be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        Row(
                          children: const [
                            Text(
                              "Enter your new Second Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: secondName
                            ..text = widget.secondName.toString(),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Second Name can't be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        Row(
                          children: const [
                            Text(
                              "Enter your new CNIC",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: cnic..text = widget.cnic.toString(),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty || value.length <= 12) {
                              return 'Please enter a valid CNIC';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        Row(
                          children: const [
                            Text(
                              "Enter your new Mobile Number",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: mobileNumber
                            ..text = widget.mobileNumber.toString(),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Please enter a valid Number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        Row(
                          children: const [
                            Text(
                              "Enter your new Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: password,
                          textInputAction: TextInputAction.next,
                          // validator: (value) {
                          //   if (value!.length < 6) {
                          //     return 'Password must have 6 characters';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(
                        context,
                        loader == false ? "Update" : "Updating...",
                        () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loader = true;
                            });

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user!.uid)
                                .update({
                              'firstName': firstName.text,
                              'secondName': secondName.text,
                              'mobileNumber': mobileNumber.text,
                              'cnic': cnic.text,
                            }).then((value) async {
                              if (password.text.toString() != "" ||
                                  password.text.length >= 6) {
                                await user?.updatePassword(password.text);

                                AppRoutes.push(context, const BottomNav());

                                MyMotionToast.success(
                                  context,
                                  "Success",
                                  "Profile Update Success!",
                                );
                              } else {
                                setState(() {
                                  loader = false;
                                });
                                MyMotionToast.error(
                                  context,
                                  "Error",
                                  "Password is less than 6",
                                );
                              }
                            }).catchError((e) {
                              AppRoutes.pop(context);
                              MyMotionToast.success(
                                context,
                                "Oops!",
                                "Some thing wrong please try again later",
                              );
                            });
                          }
                        },
                        width: dynamicWidth(context, .3),
                        height: dynamicHeight(context, .056),
                        fontSize: dynamicWidth(context, .042),
                        color: myWhite,
                        btnColor: myGreen,
                      ),
                      cancelButton(
                        context,
                        "Cancel",
                        () {
                          AppRoutes.pop(context);
                        },
                        width: dynamicWidth(context, .3),
                        height: dynamicHeight(context, .056),
                        fontSize: dynamicWidth(context, .042),
                        color: myBlack,
                        btnColor: myWhite,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
