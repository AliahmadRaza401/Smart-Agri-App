import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_agri/services/dailyupdate_services.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/image_piker.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

import 'essential_widgets.dart';

class AddUpdate extends StatefulWidget {
  const AddUpdate({Key? key}) : super(key: key);

  @override
  State<AddUpdate> createState() => _AddUpdateState();
}

class _AddUpdateState extends State<AddUpdate> {
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final itemUnit = TextEditingController();
  String itemCategory = "";
  File? _image;
  List<String> dropdownList = <String>[
    'Crops',
    'Fertilizers',
    'Sprays',
    'Cash',
  ];

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
                            fontSize: dynamicWidth(context, .046),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        profilePicture(context),
                        TextFormField(
                          controller: itemName,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
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
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        TextFormField(
                          controller: itemPrice,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
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
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        TextFormField(
                          controller: itemUnit,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: Container(
                            width: dynamicWidth(context, .9),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: .4,
                                  color: myBlack,
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemCategory == ""
                                    ? dropdownList[0]
                                    : itemCategory,
                                iconSize: 24,
                                elevation: 9,
                                onChanged: (String? value) async {
                                  setState(
                                    () {
                                      itemCategory = value.toString();
                                    },
                                  );
                                },
                                hint: const Text("Select Category"),
                                style: TextStyle(
                                  color: myGreen,
                                  fontSize: dynamicWidth(context, .04),
                                ),
                                // borderRadius: BorderRadius.circular(15),
                                items: dropdownList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
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
                      button(
                        context,
                        "ADD",
                        () {
                          if (_formKey.currentState!.validate()) {
                            if (_image != null) {
                              DailyUpdateServices.addDailyItemToDB(
                                context,
                                itemName.text,
                                itemPrice.text,
                                itemUnit.text,
                                itemCategory,
                                _image,
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return oopsAlert(context, "Add image");
                                },
                              );
                            }
                          }
                        },
                        width: dynamicWidth(context, .3),
                        height: dynamicHeight(context, .056),
                        fontSize: dynamicWidth(context, .042),
                        color: myWhite,
                        btnColor: myGreen,
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
        ],
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
