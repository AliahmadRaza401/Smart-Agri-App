import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class UpdatePasswordDialog extends StatefulWidget {
  final String password;
  final dynamic docsId;

  const UpdatePasswordDialog({required this.password, required this.docsId});

  @override
  State<UpdatePasswordDialog> createState() => _UpdatePasswordDialogState();
}

class _UpdatePasswordDialogState extends State<UpdatePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .04),
        ),
      ),
      backgroundColor: containerBgColor,
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
                          "Update Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .014),
                        ),
                        const Text(
                          "Enter your new Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        TextFormField(
                          controller: password
                            ..text = widget.password.toString(),
                          textInputAction: TextInputAction.next,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Required!';
                            }
                            return null;
                          },
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
                          setState(() {
                            loader = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            await FirebaseFirestore.instance
                                .collection("farmers")
                                .doc(widget.docsId)
                                .update({
                              'password': password.text,
                            });
                            AppRoutes.pop(context);
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

  Widget getDateTime(pressFunction, title, icon, text) {
    return TextButton(
      onPressed: pressFunction,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          boxShadow: [
            BoxShadow(
              color: myBlack.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .02),
        ),
        width: dynamicWidth(context, .7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: myGreen,
                    fontSize: dynamicWidth(context, .044),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  icon,
                  color: myGreen,
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: dynamicWidth(context, .044),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
