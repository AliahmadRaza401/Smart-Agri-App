// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';

class AddAmount extends StatefulWidget {
  // Function onTap;
  // JobCancelDialogue({required this.onTap});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  final TextEditingController _cancelReasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int hour = 00;
  int mint = 00;
  var addTime;
  var addDate;
  var currentYear;
  var currentmonth;
  var currentDay;
  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year;
    currentmonth = DateTime.now().month;
    currentDay = DateTime.now().day;
  }

  @override
  Widget build(BuildContext context) {
    // bool loading = Provider.of<HomeProvider>(context).isLoading;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 18, right: 19, top: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Add Balance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.only(),
                          child: TextFormField(
                            controller: _cancelReasonController,
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
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(),
                          child: TextFormField(
                            controller: _cancelReasonController,
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
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Column(
                    children: [getDate(), getTime()],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // if (_formKey.currentState!.validate()) {

                          // }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            decoration: BoxDecoration(
                              color: myGreen,
                              border: Border.all(width: 2, color: myYellow),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: myWhite, fontWeight: FontWeight.bold),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppRoutes.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: myYellow),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //     top: -30,
          //     right: -25,
          //     child: Container(
          //         alignment: Alignment.center,
          //         width: 50,
          //         height: 50,
          //         padding: EdgeInsets.all(5),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(50),
          //           color: Colors.yellow,
          //         ),
          //         child: IconButton(
          //           onPressed: () {
          //             AppRoutes.pop(context);
          //           },
          //           icon: Icon(
          //             Icons.close,
          //             color: Colors.black,
          //             size: 25,
          //           ),
          //         ))),
        ],
      ),
    );
  }

  Widget getTime() {
    return TextButton(
      onPressed: () {
        DatePicker.showTime12hPicker(context,
            showTitleActions: true,
            theme: DatePickerTheme(
                headerColor: Colors.orange,
                backgroundColor: Color(0xff1A1A36),
                itemStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
                doneStyle: TextStyle(color: Colors.white, fontSize: 18)),
            onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          print('confirm Time : $date');
          setState(() {
            hour = date.hour;
            mint = date.minute;
            addTime = "${date.hour} : ${date.minute}";
            // endTime = date;
          });
        }, currentTime: DateTime.now());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02),
        width: MediaQuery.of(context).size.width * 0.7,
        // height: MediaQuery.of(context).size.height * 0.06,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("End Time",
                    style: TextStyle(
                        color: Color(0xffff5018),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Icon(
                  Icons.access_time,
                  color: Color(0xffff5018),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(addTime ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getDate() {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(currentYear - 2, currentmonth, currentDay),
              maxTime: DateTime(2025, 1, 7),
              theme: DatePickerTheme(
                  headerColor: Colors.orange,
                  backgroundColor: Color(0xff1A1A36),
                  itemStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 18)),
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm ${date.year}-${date.month}-${date.day}');
            setState(() {
              addDate = "${date.year}-${date.month}-${date.day}";
            });
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02),
          width: MediaQuery.of(context).size.width * 0.7,
          // height: MediaQuery.of(context).size.height * 0.06,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select Date",
                      style: TextStyle(
                          color: Color(0xffff5018),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.calendar_today,
                    color: Color(0xffff5018),
                  )
                ],
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(addDate ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
