import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/daily_update/daily_updates.dart';
import 'package:smart_agri/trader_screens/farmers/farmers.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/box_widgets.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

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
                        balanceBox(context, "DEBIT", "80,000", myGreen),
                        balanceBox(context, "CREDIT", "30,000", myRed),
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
                      rowText(
                        context,
                        "New Updates",
                        const DailyUpdates(),
                        "See All",
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('dailyUpdate')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Oops! Something went wrong');
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text("Empty"),
                            );
                          }
                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: dynamicWidth(context, .02),
                              ),
                              child: ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: docs.length > 2 ? 2 : docs.length,
                                itemBuilder: (context, i) {
                                  final data = docs[i].data();
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: dynamicHeight(context, .006),
                                    ),
                                    child: Center(
                                      child: dailyUpdateCard(
                                        context,
                                        data['itemName'],
                                        data['date'],
                                        data['itemPrice'],
                                        data['itemUnit'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      rowText(
                        context,
                        "New Updates",
                        const Farmers(),
                        "See All",
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
