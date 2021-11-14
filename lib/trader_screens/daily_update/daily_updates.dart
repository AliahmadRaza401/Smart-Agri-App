import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/trader_screens/daily_update/add_daily_update.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/box_widgets.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

class DailyUpdates extends StatefulWidget {
  const DailyUpdates({Key? key}) : super(key: key);

  @override
  _DailyUpdatesState createState() => _DailyUpdatesState();
}

class _DailyUpdatesState extends State<DailyUpdates> {
    User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: AppBar(
        title: const Text(
          "Daily Updates",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppRoutes.push(context, AddDailyUpdate());
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Update',
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .04),
              bottom: dynamicHeight(context, .02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "All Updates",
                  style: TextStyle(
                    color: myGreen,
                    fontSize: dynamicWidth(context, .06),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                      dynamicHeight(context, .34),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .02),
                      ),
                      child: ListView.builder(
                        itemCount: docs.length,
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
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          SizedBox(
            height: dynamicHeight(context, .02),
          ),
        ],
      ),
    );
  }
}
