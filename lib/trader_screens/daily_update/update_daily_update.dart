import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/services/dailyupdate_services.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class UpdateDailyUpdate extends StatefulWidget {
  final String docsId, itemName, price, unit, category, desc;

  const UpdateDailyUpdate({
    Key? key,
    required this.docsId,
    required this.itemName,
    required this.price,
    required this.unit,
    required this.category,
    required this.desc,
  }) : super(key: key);

  @override
  _UpdateDailyUpdateState createState() => _UpdateDailyUpdateState();
}

class _UpdateDailyUpdateState extends State<UpdateDailyUpdate> {
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final itemUnit = TextEditingController();
  final itemDesc = TextEditingController();

  dynamic itemCategory = "";

  List<String> dropdownList = <String>[
    'Fertilizers',
    'Pesticides',
    'Seed',
    'Cash',
  ];

  @override
  Widget build(BuildContext context) {
    print("chaa ${widget.category}");
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
                      vertical: dynamicHeight(context, .02),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Update Today Update",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .046),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        TextFormField(
                          controller: itemName
                            ..text = widget.itemName.toString(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: "item Name",
                          ),
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
                        TextFormField(
                          controller: itemPrice..text = widget.price.toString(),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: "Price",
                          ),
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
                        TextFormField(
                          controller: itemUnit..text = widget.unit.toString(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: "Unit",
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Required!';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: DropdownSearch(
                            mode: Mode.DIALOG,
                            showSearchBox: true,
                            showClearButton: true,
                            items: dropdownList,
                            label: "Category",
                            hint: "Select Category",
                            selectedItem: widget.category,
                            onChanged: (value) {
                              setState(
                                () {
                                  itemCategory = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        TextFormField(
                          controller: itemDesc..text = widget.desc.toString(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: "Item Description",
                          ),
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
                        "UPDATE",
                        () {
                          if (_formKey.currentState!.validate()) {
                            DailyUpdateServices.updateDailyItemToDB(
                              context,
                              widget.docsId,
                              itemName.text.toLowerCase(),
                              itemPrice.text,
                              itemUnit.text,
                              itemCategory == ""
                                  ? widget.category
                                  : itemCategory,
                              itemDesc.text,
                            );
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
