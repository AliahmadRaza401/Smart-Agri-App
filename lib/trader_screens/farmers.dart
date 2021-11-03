import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

import 'farmer_form.dart';

class Farmers extends StatefulWidget {
  const Farmers({Key? key}) : super(key: key);

  @override
  _FarmersState createState() => _FarmersState();
}

class _FarmersState extends State<Farmers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farmers",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .06),
              bottom: dynamicHeight(context, .01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "All Farmers",
                  style: TextStyle(
                    color: myGreen,
                    fontSize: dynamicWidth(context, .06),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .014),
                      horizontal: dynamicWidth(context, .04),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: dynamicWidth(context, .84),
                          height: dynamicHeight(context, .22),
                          decoration: BoxDecoration(
                            color: myYellow,
                            borderRadius: BorderRadius.circular(
                              dynamicWidth(context, .03),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: myYellow.withOpacity(0.4),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(
                            dynamicWidth(context, .04),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: dynamicWidth(context, .08),
                                    backgroundColor: myWhite,
                                    child: Icon(
                                      Icons.person,
                                      size: dynamicWidth(context, .1),
                                      color: myGreen,
                                    ),
                                  ),
                                  SizedBox(
                                    width: dynamicWidth(context, .04),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Ghulam Hussain",
                                            style: TextStyle(
                                              color: myBlack,
                                              fontSize:
                                                  dynamicWidth(context, .05),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: dynamicHeight(context, .01),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "+92 300 0909091",
                                            style: TextStyle(
                                              color: myBlack,
                                              fontSize:
                                                  dynamicWidth(context, .04),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: dynamicHeight(context, .01),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: dynamicHeight(context, .08),
                                      width: dynamicWidth(context, .28),
                                      decoration: BoxDecoration(
                                        color: myWhite,
                                        borderRadius: BorderRadius.circular(
                                          dynamicWidth(context, .02),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: myWhite.withOpacity(0.4),
                                            spreadRadius: 4,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "DEBIT",
                                                style: TextStyle(
                                                  color: myBlack,
                                                  fontSize: dynamicWidth(
                                                      context, .04),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Rs. 80,000",
                                                style: TextStyle(
                                                  color: myGreen,
                                                  fontSize: dynamicWidth(
                                                      context, .038),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: dynamicHeight(context, .08),
                                      width: dynamicWidth(context, .28),
                                      decoration: BoxDecoration(
                                        color: myWhite,
                                        borderRadius: BorderRadius.circular(
                                          dynamicWidth(context, .02),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: myWhite.withOpacity(0.4),
                                            spreadRadius: 4,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "CREDIT",
                                                style: TextStyle(
                                                  color: myBlack,
                                                  fontSize: dynamicWidth(
                                                      context, .04),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Rs. 30,000",
                                                style: TextStyle(
                                                  color: myRed,
                                                  fontSize: dynamicWidth(
                                                      context, .038),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: dynamicHeight(context, .02),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppRoutes.push(context, const FarmerForm());
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Farmer',
          style: TextStyle(
            color: myWhite,
            fontSize: dynamicWidth(context, .04),
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
        ),
        icon: const Icon(
          Icons.add,
          color: myWhite,
        ),
      ),
    );
  }
}
