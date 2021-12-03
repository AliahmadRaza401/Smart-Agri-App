import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  String itemCategory = "", selectedUnit = "";
  List<String> dropdownList = <String>[
    "Select Category",
    'Fertilizers',
    'Pesticides',
    'Seed',
    'Cash',
  ];
  List<String> unitList = <String>[
    "Select Unit",
    'ML',
    'Grams',
    'KG',
    'Rs.',
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
                          "Make a Request",
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
                                value: selectedUnit == ""
                                    ? unitList[0]
                                    : selectedUnit,
                                iconSize: 24,
                                elevation: 9,
                                onChanged: (String? value) async {
                                  setState(
                                    () {
                                      selectedUnit = value.toString();
                                    },
                                  );
                                },
                                hint: const Text("Select Unit"),
                                style: TextStyle(
                                  color: myGreen,
                                  fontSize: dynamicWidth(context, .04),
                                ),
                                // borderRadius: BorderRadius.circular(15),
                                items: unitList.map<DropdownMenuItem<String>>(
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
                      button(context, "ADD", () {
                        if (_formKey.currentState!.validate()) {}
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
