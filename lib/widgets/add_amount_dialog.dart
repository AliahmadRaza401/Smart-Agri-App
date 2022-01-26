// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_agri/services/farmer_services_trader.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class AddAmount extends StatefulWidget {
  final String farmerId, farmerUserName;

  const AddAmount({required this.farmerId, required this.farmerUserName});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  final TextEditingController _cancelReasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final itemWeight = TextEditingController();
  final itemTodayRate = TextEditingController();
  bool loading = false;
  // int hour = 00;
  // int mint = 00;
  // var addTime;
  // var addDate;
  // var currentYear;
  // var currentmonth;
  // var currentDay;
  // var nowDate;
  // var nowTime;

  // @override
  // void initState() {
  //   super.initState();
  //   currentYear = DateTime.now().year;
  //   currentmonth = DateTime.now().month;
  //   currentDay = DateTime.now().day;

  //   DateTime now = DateTime.now();
  //   nowDate = DateFormat.yMMMMd('en_US').format(now);
  //   nowTime = DateFormat.jm().format(now);
  // }

  @override
  Widget build(BuildContext context) {
    // bool loading = Provider.of<HomeProvider>(context).isLoading;

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
                            "Add Balance",
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
                              textInputAction: TextInputAction.next,
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
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
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
                              controller: itemWeight,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: "Item Weight",
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
                              controller: itemTodayRate,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Today Rate of Item",
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
                    SizedBox(
                      height: dynamicHeight(context, .02),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(
                          context,
                          loading == true ? "Adding..." : "ADD",
                          loading == true
                              ? () {}
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    await FarmerServicesTrader.addFarmerAmount(
                                      context,
                                      widget.farmerId,
                                      itemName.text,
                                      itemPrice.text,
                                      itemWeight.text,
                                      itemTodayRate.text,
                                      widget.farmerUserName,
                                    );
                                    setState(() {
                                      loading = true;
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
