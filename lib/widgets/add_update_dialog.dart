// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smart_agri/services/farmer_services.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class AddUpdate extends StatefulWidget {
  // final String farmerId;

  // AddUpdate({required this.farmerId});

  @override
  State<AddUpdate> createState() => _AddUpdateState();
}

class _AddUpdateState extends State<AddUpdate> {
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final itemUnit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool loading = Provider.of<HomeProvider>(context).isLoading;

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
          Container(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Add Today Update",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: dynamicHeight(context, .02),
                          ),
                          Container(
                            margin: EdgeInsets.only(),
                            child: TextFormField(
                              controller: itemName,
                              decoration: InputDecoration(
                                hintText: "item Name",
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Required!';
                                }
                                return null;
                              },
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                          SizedBox(
                            height: dynamicHeight(context, .02),
                          ),
                          Container(
                            margin: EdgeInsets.only(),
                            child: TextFormField(
                              controller: itemPrice,
                              decoration: InputDecoration(
                                hintText: "Price",
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Required!';
                                }
                                return null;
                              },
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                          SizedBox(
                            height: dynamicHeight(context, .02),
                          ),
                          Container(
                            margin: EdgeInsets.only(),
                            child: TextFormField(
                              controller: itemPrice,
                              decoration: InputDecoration(
                                hintText: "Unit",
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Required!';
                                }
                                return null;
                              },
                              onChanged: (_) => setState(() {}),
                            ),
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
                        button(context, "ADD", () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseServices.addDailyItemToDB(
                              context,
                              itemName.text,
                              itemPrice.text,
                              itemUnit.text,
                            );
                          }
                        },
                            width: dynamicWidth(context, .3),
                            height: dynamicHeight(context, .056),
                            fontSize: dynamicWidth(context, .042),
                            color: myWhite,
                            btnColor: myGreen
                            ),
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
                    SizedBox(
                      height: dynamicHeight(context, .02),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
