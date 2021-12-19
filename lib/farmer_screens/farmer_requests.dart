import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/farmer_screens/add_request.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/local_notification.dart';
import 'package:smart_agri/widgets/add_update_dialog.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

class FarmerRequests extends StatefulWidget {
  final dynamic farmerId;

  const FarmerRequests({Key? key, this.farmerId}) : super(key: key);

  @override
  _FarmerRequestsState createState() => _FarmerRequestsState();
}

class _FarmerRequestsState extends State<FarmerRequests> {
  dynamic traderId, farmerImage, farmerName, farmerNumber;

  @override
  void initState() {
    super.initState();
    getFarmerData();
  }

  getFarmerData() {
    FirebaseFirestore.instance
        .collection("farmers")
        .doc(widget.farmerId)
        .get()
        .then(
          (value) => {
            print(value.data()),
            setState(
              () {
                traderId = value.data()!["traderId"];
                farmerName = value.data()!["firstName"];
                farmerImage = value.data()!["image"]["url"];

                farmerNumber = value.data()!["mobileNumber"];
              },
            ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: AppBar(
        title: const Text(
          "Requests",
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
            builder: (context) => AddRequest(
              farmerId: widget.farmerId,
              traderId: traderId,
              farmerName: farmerName,
              farmerImage: farmerImage,
              farmerNumber: farmerNumber,
            ),
          );
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Request',
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
      body: Center(
        child: SizedBox(
          height: dynamicHeight(context, .8),
          width: dynamicWidth(context, 1),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('request')
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
                        print('data: $data');
                        // LocalNotificationsService.instance.showChatNotifcation(
                        //   title: "Request Declined",
                        //   body: "Trader reject your request",
                        // );
                        return farmerRequestCard(
                          context,
                          data["farmerImage"].toString(),
                          data["farmerName"].toString(),
                          data["farmerNumber"].toString(),
                          data["itemName"].toString(),
                          data["category"].toString(),
                          data["quantity"].toString(),
                          data["unit"].toString(),
                          data["status"].toString(),
                          farmer: true,
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
