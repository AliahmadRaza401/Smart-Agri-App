// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_agri/farmer_screens/farmer_daily_updates.dart';
import 'package:smart_agri/services/auth_services.dart';
import 'package:smart_agri/services/fcm_services.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/local_notification.dart';
import 'package:smart_agri/widgets/add_update_dialog.dart';
import 'package:smart_agri/widgets/box_widgets.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

class FarmerHomeScreen extends StatefulWidget {
  final dynamic farmerId;

  const FarmerHomeScreen({Key? key, this.farmerId}) : super(key: key);

  @override
  _FarmerHomeScreenState createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  dynamic farmerName, traderId, leneHen = "", deneHen = "";

  @override
  void initState() {
    super.initState();
    getFarmerData();
    FCMServices.fcmGetTokenandSubscribe('farmer');
    fcmListen();
  }

  fcmListen() async {
    print("famrer fcm listen________________________!");
    var spID = await AuthServices.getUniqueFarmerID();
    print('spID: $spID');
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('event: ${event.data}');
      print("Noti ID: ${event.data['id']}");
      print('spID: $spID');
      if (event.data['id'].toString() == spID.toString()) {
        print("Notification Home match__________!");

        LocalNotificationsService.instance.showChatNotifcation(
            title: '${event.notification!.title}',
            body: '${event.notification!.body}');

        FirebaseMessaging.onMessageOpenedApp.listen((message) {});
      } else {
        print("Notification Not match_____________!");
      }
    });
  }

  getFarmerData() {
    FirebaseFirestore.instance
        .collection("farmers")
        .doc(widget.farmerId)
        .get()
        .then(
          (value) => {
            setState(
              () {
                farmerName = value.data()!["firstName"];
                traderId = value.data()!["traderId"];
                leneHen = value.data()!["leneHen"];
                deneHen = value.data()!["deneHen"];
              },
            ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    print("farmerID Build wali: ${widget.farmerId}");
    return Scaffold(
      backgroundColor: myGrey,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: dynamicHeight(context, .01),
            ),
            Center(
              child: Container(
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
                                farmerName ?? '',
                                style: TextStyle(
                                  color: myWhite,
                                  fontSize: dynamicWidth(context, .05),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            DateFormat.yMMMEd()
                                .format(DateTime.now())
                                .toString(),
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
                          balanceBox(context, "Yet To Receive",
                              leneHen.toStringAsFixed(0), myGreen),
                          balanceBox(context, "Yet To Give",
                              deneHen.toStringAsFixed(0), myRed),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        FarmerDailyUpdates(
                          farmerId: widget.farmerId,
                          traderId: traderId,
                        ),
                        "See All",
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('dailyUpdate')
                            .where("traderId", isEqualTo: traderId)
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
                                const AddUpdate(),
                                dynamicHeight(context, .18),
                                farmer: true,
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: dynamicWidth(context, .02),
                                ),
                                child: ListView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: docs.length,
                                  itemBuilder: (context, i) {
                                    final data = docs[i].data();
                                    DateTime date = DateTime.now();
                                    if (data['createdAt'] != null) {
                                      DateTime postDate =
                                          data['createdAt'].toDate();
                                      final diff =
                                          date.difference(postDate).inMinutes;
                                      if (diff <= 1) {
                                        LocalNotificationsService.instance
                                            .showChatNotifcation(
                                                title: "New Post",
                                                body:
                                                    "Trader Upload new post in daily item");
                                      }
                                    }

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: dynamicHeight(context, .01),
                                        horizontal: dynamicWidth(context, .04),
                                      ),
                                      child: dailyUpdateCard(
                                        context,
                                        data['itemName'],
                                        data['date'],
                                        data['itemPrice'],
                                        data['itemUnit'],
                                        data['category'],
                                        data['image']['url'],
                                        data['description'],
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
