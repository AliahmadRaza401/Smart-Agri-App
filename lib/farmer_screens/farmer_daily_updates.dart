import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';
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
  dynamic stream = "", activeCategory = "";

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
      body: Column(
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
                          .collection('dailyUpdate')
                          .where("itemName", isEqualTo: value.toLowerCase())
                          .where("traderId", isEqualTo: widget.traderId)
                          .snapshots();
                    }
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = "";
                    stream = "";
                  });
                },
                child: dailyUpdateFilter(
                  context,
                  "All",
                  activeCategory == "" ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = "Fertilizers";
                    stream = FirebaseFirestore.instance
                        .collection('dailyUpdate')
                        .where("category", isEqualTo: "Fertilizers")
                        .where("traderId", isEqualTo: widget.traderId)
                        .snapshots();
                  });
                },
                child: dailyUpdateFilter(context, "Fertilizers",
                    activeCategory == "Fertilizers" ? true : false),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = "Pesticides";

                    stream = FirebaseFirestore.instance
                        .collection('dailyUpdate')
                        .where("category", isEqualTo: "Pesticides")
                        .where("traderId", isEqualTo: widget.traderId)
                        .snapshots();
                  });
                },
                child: dailyUpdateFilter(context, "Pesticides",
                    activeCategory == "Pesticides" ? true : false),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      activeCategory = "Seed";

                      stream = FirebaseFirestore.instance
                          .collection('dailyUpdate')
                          .where("category", isEqualTo: "Seed")
                          .where("traderId", isEqualTo: widget.traderId)
                          .snapshots();
                    },
                  );
                },
                child: dailyUpdateFilter(
                    context, "Seed", activeCategory == "Seed" ? true : false),
              ),
            ],
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
                  ? stream
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

                  if (docs.isEmpty) {
                    return noDataError(
                      context,
                      "assets/dailyUpdatesCartoon.png",
                      const AddUpdate(),
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
                              vertical: dynamicHeight(context, .012),
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

  Widget dailyUpdateFilter(context, text, check) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dynamicWidth(context, .012),
      ),
      child: Container(
        height: dynamicHeight(context, .036),
        decoration: BoxDecoration(
          color: check == false ? noColor : myGreen,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .4),
          ),
          border: Border.all(
            color: myGreen,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: dynamicWidth(context, .04),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: dynamicWidth(context, .036),
              color: check == false ? myGreen : myWhite,
            ),
          ),
        ),
      ),
    );
  }
}
