import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/daily_update/daily_updates.dart';
import 'package:smart_agri/trader_screens/farmers/farmers.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() {
    _firebaseFirestore.collection('users').doc(user!.uid).get().then(
          (value) => {
            setState(() {
              loggedInUser = UserModel.fromMap(value.data());
            }),
            print(loggedInUser.firstName),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: myWhite,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: dynamicHeight(context, .01),
            ),
            Container(
              height: dynamicHeight(context, .3),
              width: dynamicWidth(context, .96),
              decoration: BoxDecoration(
                color: myGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    dynamicWidth(context, .04),
                  ),
                  topRight: Radius.circular(
                    dynamicWidth(context, .04),
                  ),
                  bottomLeft: Radius.circular(
                    dynamicWidth(context, .1),
                  ),
                  bottomRight: Radius.circular(
                    dynamicWidth(context, .1),
                  ),
                ),
                gradient: const LinearGradient(
                  colors: [
                    myGreen,
                    myLiteGreen,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .01),
                      horizontal: dynamicWidth(context, .06),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SMART AGRI',
                          style: TextStyle(
                            color: myWhite,
                            fontSize: dynamicWidth(context, .066),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .01),
                      horizontal: dynamicWidth(context, .06),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hi ',
                                  style: TextStyle(
                                    color: myWhite,
                                    fontSize: dynamicWidth(context, .05),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/hi.gif',
                                      height: dynamicHeight(context, .02),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              loggedInUser.firstName ?? '',
                              style: TextStyle(
                                color: myWhite,
                                fontSize: dynamicWidth(context, .05),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat.yMMMEd().format(DateTime.now()).toString(),
                          style: TextStyle(
                            color: myWhite,
                            fontSize: dynamicWidth(context, .04),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .01),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: dynamicHeight(context, .12),
                          width: dynamicWidth(context, .4),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "DEBIT",
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, .054),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rs. 80,000",
                                    style: TextStyle(
                                      color: myGreen,
                                      fontSize: dynamicWidth(context, .048),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: dynamicHeight(context, .12),
                          width: dynamicWidth(context, .4),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CREDIT",
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, .054),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rs. 30,000",
                                    style: TextStyle(
                                      color: myRed,
                                      fontSize: dynamicWidth(context, .048),
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
            Expanded(
              child: Container(
                width: dynamicWidth(context, 1),
                height: dynamicHeight(context, .7),
                color: myWhite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: dynamicHeight(context, .04),
                          bottom: dynamicHeight(context, .01),
                          right: dynamicWidth(context, .04),
                          left: dynamicWidth(context, .04),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your Farmers",
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .056),
                                color: myGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AppRoutes.push(context, const Farmers());
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.all(dynamicWidth(context, .02)),
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: dynamicWidth(context, .04),
                                    color: myBlack,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
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
                                                "Ghulam Hussain",
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
                                            height: dynamicHeight(context, .01),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "+92 300 0909091",
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
                                            borderRadius: BorderRadius.circular(
                                              dynamicWidth(context, .02),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: myBlack.withOpacity(0.4),
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
                                            borderRadius: BorderRadius.circular(
                                              dynamicWidth(context, .02),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: myBlack.withOpacity(0.4),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: dynamicHeight(context, .04),
                          bottom: dynamicHeight(context, .01),
                          right: dynamicWidth(context, .04),
                          left: dynamicWidth(context, .04),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New Updates",
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .056),
                                color: myGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AppRoutes.push(context, const DailyUpdates());
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.all(dynamicWidth(context, .02)),
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: dynamicWidth(context, .04),
                                    color: myBlack,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicWidth(context, .01),
                          vertical: dynamicHeight(context, .02),
                        ),
                        child: Container(
                          width: dynamicWidth(context, .4),
                          height: dynamicHeight(context, .12),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "a",
                                    // snapshot.data!.docs[0]
                                    //     .data()[
                                    // 'itemName'] ??
                                    //     "",
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, .056),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "b",
                                    // snapshot.data!.docs[0]
                                    //     .data()['date'] ??
                                    //     "",
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, .036),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "a",
                                      // "Rs. " +
                                      //     snapshot.data!.docs[0]
                                      //         .data()[
                                      //     'itemPrice'] +
                                      //     " per " +
                                      //     snapshot.data!.docs[0]
                                      //         .data()[
                                      //     'itemUnit'],
                                      style: TextStyle(
                                        color: myBlack,
                                        fontSize: dynamicWidth(context, .044),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
