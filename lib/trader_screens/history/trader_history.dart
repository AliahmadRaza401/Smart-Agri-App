import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/farmer_bottom_nav.dart';
import 'package:smart_agri/widgets/form_fields.dart';

class TraderHistory extends StatefulWidget {
  final dynamic traderId;

  const TraderHistory({Key? key, required this.traderId}) : super(key: key);

  @override
  _TraderHistoryState createState() => _TraderHistoryState();
}

class _TraderHistoryState extends State<TraderHistory> {
  dynamic traderId, farmerImage, farmerName, farmerNumber;
  final searchQuery = TextEditingController();
  dynamic stream = "";

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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .02),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: myWhite,
                ),
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
                      if (value == "") {
                        stream = "";
                      } else {
                        stream = FirebaseFirestore.instance
                            .collection('history')
                            .orderBy('timeStamp', descending: true)
                            .where("farmerName", isEqualTo: value.toString())
                            .snapshots();
                      }
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: dynamicWidth(context, 1),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: stream != ""
                      ? stream
                      : FirebaseFirestore.instance
                          .collection('history')
                          .orderBy('timeStamp', descending: true)
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
                                data['farmerName'],
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
          ],
        ),
      ),
    );
  }
}
