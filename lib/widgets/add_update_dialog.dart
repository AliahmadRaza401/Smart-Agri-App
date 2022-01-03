import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/dailyupdate_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
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
  File? _image;
  String itemCategory = "", selectedType = "", unit = "";
  List<String> dropdownList = <String>[
    "Select Category",
    'Fertilizers',
    'Pesticides',
    'Seed',
  ];
  List<String> typeList = <String>[
    "Select Type",
    'Liquid',
    'Solid',
  ];

  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<AuthProvider>(context).loading;

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
                                      if (itemCategory == "Fertilizers") {
                                        unit = "No. of Bags";
                                      } else if (itemCategory == "Seed") {
                                        unit = "Kg";
                                      } else if (itemCategory == "Cash") {
                                        unit = "Rs.";
                                      } else if (itemCategory ==
                                          "Select Category") {
                                        unit = "";
                                      }
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
                        itemCategory == "Pesticides"
                            ? Padding(
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
                                      value: selectedType == ""
                                          ? typeList[0]
                                          : selectedType,
                                      iconSize: 24,
                                      elevation: 9,
                                      onChanged: (String? value) async {
                                        setState(
                                          () {
                                            selectedType = value.toString();
                                            if (selectedType == "Liquid") {
                                              unit = "ML";
                                            } else if (selectedType ==
                                                "Solid") {
                                              unit = "Grams";
                                            } else if (selectedType ==
                                                "Select Type") {
                                              unit = "";
                                            }
                                          },
                                        );
                                      },
                                      hint: const Text("Select Type"),
                                      style: TextStyle(
                                        color: myGreen,
                                        fontSize: dynamicWidth(context, .04),
                                      ),
                                      items: typeList
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
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: dynamicHeight(context, .01),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Unit : $unit",
                                style: TextStyle(
                                  fontSize: dynamicWidth(context, .04),
                                ),
                              ),
                            ],
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
                        loading ? "Adding..." : "ADD",
                        () {
                          if (_formKey.currentState!.validate()) {
                            if (_image != null) {
                              if (itemCategory != "") {
                                DailyUpdateServices.addDailyItemToDB(
                                  context,
                                  itemName.text,
                                  itemPrice.text,
                                  unit,
                                  itemCategory,
                                  itemCategory == "Pesticides"
                                      ? selectedType
                                      : "",
                                  _image,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return oopsAlert(
                                        context, "Fill All Fields");
                                  },
                                );
                              }
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

  }
}
