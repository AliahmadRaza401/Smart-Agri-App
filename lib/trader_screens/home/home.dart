import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/daily_update/add_daily_update.dart';
import 'package:smart_agri/trader_screens/daily_update/daily_updates.dart';
import 'package:smart_agri/trader_screens/farmers/farmer_details.dart';
import 'package:smart_agri/trader_screens/farmers/farmer_form.dart';
import 'package:smart_agri/trader_screens/farmers/farmers.dart';
import 'package:smart_agri/utils/app_route.dart';
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
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
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
                                      height: dynamicHeight(context, .03),
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
                color: noColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      rowText(
                        context,
                        "Recent Updates",
                        const DailyUpdates(),
                        "See All",
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('dailyUpdate')
                            .where("traderId", isEqualTo: user!.uid)
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Oops! Something went wrong');
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            if (docs.isEmpty) {
                              return noDataError(
                                context,
                                "assets/dailyUpdatesCartoon.png",
                                const AddDailyUpdate(),
                                dynamicHeight(context, .18),
                              );
                            } else {
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
                                          "",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      rowText(
                        context,
                        "Recent Farmer",
                        const Farmers(),
                        "See All",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: dynamicHeight(context, .002),
                          horizontal: dynamicWidth(context, .04),
                        ),
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('farmers')
                              .where("traderId", isEqualTo: user!.uid)
                              .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Oops! Something went wrong');
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData) {
                              final docs = snapshot.data!.docs;
                              if (docs.isEmpty) {
                                return noDataError(
                                  context,
                                  "assets/farmerCartoon.png",
                                  const FarmerForm(),
                                  dynamicHeight(context, .18),
                                );
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: docs.length > 2 ? 2 : docs.length,
                                  itemBuilder: (_, i) {
                                    final data = docs[i].data();
                                    return InkWell(
                                      onTap: () {
                                        AppRoutes.push(
                                          context,
                                          FarmerDetails(
                                            userName: data['userName'],
                                            fName: data['firstName'],
                                            lName: data['lastName'],
                                            mNumber: data['mobileNumber'],
                                            fCNIC: data['cnic'],
                                            password: data['password'],
                                            farmerId: docs[i].id,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              dynamicHeight(context, .014),
                                          horizontal:
                                              dynamicWidth(context, .00),
                                        ),
                                        child: farmerCard(
                                          context,
                                          data['userName'],
                                          data['mobileNumber'],
                                          "80,000",
                                          "30,000",
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
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
