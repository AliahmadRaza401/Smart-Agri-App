import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/trader_screens/daily_update/update_daily_update.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/local_notification.dart';
import 'package:smart_agri/widgets/add_update_dialog.dart';
import 'package:smart_agri/widgets/box_widgets.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/form_fields.dart';

class FarmerDailyUpdates extends StatefulWidget {
  final dynamic farmerId, traderId;

  const FarmerDailyUpdates({Key? key, this.farmerId, this.traderId})
      : super(key: key);

  @override
  _FarmerDailyUpdatesState createState() => _FarmerDailyUpdatesState();
}

class _FarmerDailyUpdatesState extends State<FarmerDailyUpdates> {
  User? user = FirebaseAuth.instance.currentUser;

  final searchQuery = TextEditingController();
  String stream = "";

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
          showDialog(
            context: context,
            builder: (context) => const AddUpdate(),
          );
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
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .02),
            ),
            child: SizedBox(
              width: dynamicWidth(context, .9),
              child: inputTextField(
                context,
                "Search",
                searchQuery,
                TextInputType.name,
                auth: false,
                inputAction: TextInputAction.done,
                submitFunction: (value) {
                  setState(() {
                    stream = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .02),
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
              stream: stream != ""
                  ? FirebaseFirestore.instance
                      .collection('dailyUpdate')
                      .where("itemName", isEqualTo: stream.toLowerCase())
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('dailyUpdate')
                      .where("traderId", isEqualTo: widget.traderId)
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
                  print('docs: $docs');

                  if (docs.isEmpty) {
                    return noDataError(
                      context,
                      "assets/dailyUpdatesCartoon.png",
                      const AddUpdate(),
                      dynamicHeight(context, .34),
                      farmer: true,
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
                          DateTime date = DateTime.now();
                          DateTime postDate = data['createdAt'].toDate();
                          final diff = date.difference(postDate).inMinutes;
                          if (diff <= 1) {
                            LocalNotificationsService.instance
                                .showChatNotifcation(
                                    title: "New Post",
                                    body:
                                        "Trader Upload new post in daily item");
                          }

                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context) {
                                    var id =
                                        snapshot.data!.docs[i].reference.id;
                                    showDialog(
                                      context: context,
                                      builder: (context) => UpdateDailyUpdate(
                                        itemName: data['itemName'],
                                        price: data['itemPrice'],
                                        unit: data['itemUnit'],
                                        docsId: id,
                                        category: "category",
                                      ),
                                    );
                                  },
                                  backgroundColor: myLiteGreen,
                                  foregroundColor: myWhite,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (BuildContext context) {
                                    var id =
                                        snapshot.data!.docs[i].reference.id;
                                    FirebaseServices.deleteRecord(
                                      context,
                                      'dailyUpdate',
                                      id,
                                    );
                                  },
                                  backgroundColor: myRed,
                                  foregroundColor: myWhite,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: dynamicHeight(context, .012),
                                horizontal: dynamicWidth(context, .04),
                              ),
                              child: dailyUpdateCard(
                                context,
                                data['itemName'],
                                data['date'],
                                data['itemPrice'],
                                data['itemUnit'],
                                "category",
                                data['image']['url'],
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
