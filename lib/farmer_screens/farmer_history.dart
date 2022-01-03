import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/farmer_screens/add_request.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/local_notification.dart';
import 'package:smart_agri/widgets/add_update_dialog.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/farmer_bottom_nav.dart';

class FarmerHistory extends StatefulWidget {
  final dynamic farmerId;

  const FarmerHistory({Key? key, required this.farmerId}) : super(key: key);

  @override
  _FarmerHistoryState createState() => _FarmerHistoryState();
}

class _FarmerHistoryState extends State<FarmerHistory> {
  dynamic traderId, farmerImage, farmerName, farmerNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: dynamicHeight(context, .8),
          width: dynamicWidth(context, 1),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('history')
                .where("farmerId", isEqualTo: widget.farmerId)
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
                    const FarmerBottomNav(),
                    dynamicHeight(context, .34),
                    farmer: true,
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, .02),
                    ),
                    child: ListView.builder(
                      // reverse: true,
                      itemCount: docs.length,
                      itemBuilder: (context, i) {
                        final data = docs[i].data();

                        return historyCard(
                          context,
                          data['name'],
                          data['price'].toInt(),
                          data['date'],
                          data['time'],
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
      ),
    );
  }
}
