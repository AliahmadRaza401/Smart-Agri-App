import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/trader_screens/farmers/farmer_details.dart';
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
  void initState() {
    super.initState();
  }

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
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('farmers').snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError)
                  return Text('Oops! Something went wrong');
                if (!snapshot.hasData) return Center(child: Text("Empty"));
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      return InkWell(
                        onTap: () {
                          AppRoutes.push(
                            context,
                            FarmerDetails(
                              userName: data['userName'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .014),
                            horizontal: dynamicWidth(context, .04),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: dynamicWidth(context, .82),
                                height: dynamicHeight(context, .2),
                                decoration: BoxDecoration(
                                  color: myYellow,
                                  borderRadius: BorderRadius.circular(
                                    dynamicWidth(context, .03),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: myBlack.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(
                                  dynamicWidth(context, .03),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  data['firstName'] ?? "",
                                                  style: TextStyle(
                                                    color: myBlack,
                                                    fontSize: dynamicWidth(
                                                        context, .05),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  dynamicHeight(context, .01),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  data['mobileNumber'] ?? "",
                                                  style: TextStyle(
                                                    color: myBlack,
                                                    fontSize: dynamicWidth(
                                                        context, .04),
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
                                        vertical: dynamicHeight(context, .012),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: dynamicHeight(context, .07),
                                            width: dynamicWidth(context, .27),
                                            decoration: BoxDecoration(
                                              color: myWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                dynamicWidth(context, .02),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      myBlack.withOpacity(0.4),
                                                  spreadRadius: 1,
                                                  blurRadius: 6,
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
                                            height: dynamicHeight(context, .07),
                                            width: dynamicWidth(context, .27),
                                            decoration: BoxDecoration(
                                              color: myWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                dynamicWidth(context, .02),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      myBlack.withOpacity(0.4),
                                                  spreadRadius: 1,
                                                  blurRadius: 6,
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
                        ),
                      );
                    },
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
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