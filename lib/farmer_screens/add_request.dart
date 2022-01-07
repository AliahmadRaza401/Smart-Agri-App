import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/farmer_screens/services/farmer_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class AddRequest extends StatefulWidget {
  final dynamic farmerId, traderId, farmerImage, farmerName, farmerNumber;

  const AddRequest(
      {Key? key,
      this.farmerId,
      this.traderId,
      this.farmerImage,
      this.farmerName,
      this.farmerNumber})
      : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemQuantity = TextEditingController();
  String itemCategory = "", selectedType = "", unit = "";
  List<String> dropdownList = <String>[
    "Select Category",
    'Fertilizers',
    'Pesticides',
    'Seed',
    'Cash',
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
                                        unit = "Per Bag";
                                      } else if (itemCategory == "Seed") {
                                        unit = "Kg";
                                      } else if (itemCategory == "Pesticides") {
                                        unit = "Acres";
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
                        itemCategory == "Cash"
                            ? SizedBox()
                            : TextFormField(
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
                        TextFormField(
                          controller: itemQuantity,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: itemCategory == "Cash"
                                ? "Cash Amount"
                                : "item Quantity",
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
                      button(context, loading ? "Adding..." : "ADD", () async {
                        if (_formKey.currentState!.validate()) {
                          await FarmerServices.sendRequest(
                            context,
                            widget.farmerId,
                            widget.traderId,
                            widget.farmerName,
                            widget.farmerImage,
                            widget.farmerNumber,
                            itemCategory == "Cash" ? "Cash" : itemName.text,
                            itemCategory,
                            itemCategory == "Pesticides" ? selectedType : "",
                            unit,
                            itemQuantity.text,
                          );
                        }
                      },
                          width: dynamicWidth(context, .3),
                          height: dynamicHeight(context, .056),
                          fontSize: dynamicWidth(context, .042),
                          color: myWhite,
                          btnColor: myGreen),
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
