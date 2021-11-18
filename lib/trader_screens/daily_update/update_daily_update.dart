import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class UpdateDailyUpdate extends StatefulWidget {
  final String docsId, itemName, price, unit, category;

  const UpdateDailyUpdate({
    Key? key,
    required this.docsId,
    required this.itemName,
    required this.price,
    required this.unit,
    required this.category,
  }) : super(key: key);

  @override
  _UpdateDailyUpdateState createState() => _UpdateDailyUpdateState();
}

class _UpdateDailyUpdateState extends State<UpdateDailyUpdate> {
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final itemUnit = TextEditingController();
  dynamic itemCategory = "";

  List<String> dropdownList = <String>[
    'Crops',
    'Fertilizers',
    'Sprays',
    'Cash',
  ];

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
                          controller: itemName,
                          // ..text = widget.itemName.toString(),
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
                          // ..text = widget.price.toString(),
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
                          // ..text = widget.unit.toString(),
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
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(context, "UPDATE", () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseServices.updateDailyItemToDB(
                              context,
                              widget.docsId,
                              itemName.text,
                              itemPrice.text,
                              itemUnit.text);
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
