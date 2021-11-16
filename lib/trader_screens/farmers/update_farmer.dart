import 'package:flutter/material.dart';
import 'package:smart_agri/services/farmer_services.dart';
import 'package:smart_agri/trader_screens/farmers/farmer_form.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/form_fields.dart';

final _formKey = GlobalKey<FormState>();
final farmerFName = TextEditingController();
final farmerLName = TextEditingController();
final userName = TextEditingController();
final farmerPassword = TextEditingController();
final farmerNumber = TextEditingController();
final farmerCnic = TextEditingController();

class UpdateFarmer extends StatefulWidget {
  final String userName, fName, lName, mNumber, fCNIC, password, docsID;

  const UpdateFarmer({
    Key? key,
    required this.userName,
    required this.fName,
    required this.lName,
    required this.mNumber,
    required this.fCNIC,
    required this.password,
    required this.docsID,
  }) : super(key: key);

  @override
  _UpdateFarmerState createState() => _UpdateFarmerState();
}

class _UpdateFarmerState extends State<UpdateFarmer> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .04),
        ),
      ),
      backgroundColor: greenLite,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Form(
            key: _formKey,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, .04),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: dynamicHeight(context, .03),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Update Farmer",
                              style: TextStyle(
                                color: myGreen,
                                fontSize: dynamicWidth(context, .07),
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
                                "UserName",
                                userName..text = widget.userName.toString(),
                                TextInputType.name,
                                auth: false,
                                function: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid Username';
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
                                "First Name",
                                farmerFName..text = widget.fName.toString(),
                                TextInputType.name,
                                auth: false,
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
                                farmerLName..text = widget.lName.toString(),
                                TextInputType.name,
                                auth: false,
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
                                farmerNumber..text = widget.mNumber.toString(),
                                TextInputType.phone,
                                auth: false,
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
                                farmerCnic..text = widget.fCNIC.toString(),
                                TextInputType.number,
                                auth: false,
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
                                "Password",
                                farmerPassword
                                  ..text = widget.password.toString(),
                                TextInputType.visiblePassword,
                                password: true,
                                auth: false,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button(context, "UPDATE", () {
                            if (_formKey.currentState!.validate()) {
                              FarmerServices.updateFarmerToDB(
                                context,
                                widget.docsID,
                                userName.text,
                                farmerPassword.text,
                                farmerFName.text,
                                farmerLName.text,
                                farmerNumber.text,
                                farmerCnic.text,
                              );
                            }
                          },
                              width: dynamicWidth(context, .3),
                              height: dynamicHeight(context, .056),
                              fontSize: dynamicWidth(context, .042),
                              color: myWhite,
                              btnColor: myGreen),
                          button(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
