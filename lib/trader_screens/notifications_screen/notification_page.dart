import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/services/fcm_services.dart';
import 'package:smart_agri/services/history.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/add_update_dialog.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/motion_toast.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  User? user = FirebaseAuth.instance.currentUser;

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
      body: Center(
        child: SizedBox(
          height: dynamicHeight(context, .8),
          width: dynamicWidth(context, 1),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('request')
                .where("traderId", isEqualTo: user!.uid)
                .orderBy('timeStamp', descending: true)
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
                      itemCount: docs.length,
                      itemBuilder: (context, i) {
                        final data = docs[i].data();
                        double requestPrice = 0.0;
                        dynamic check = "";
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
                          farmer: false,
                          function1: () async {
                            requestPrice = 0.0;
                            if (data["category"].toString() == "Cash") {
                              check = true;
                              requestPrice =
                                  double.parse(data["quantity"].toString());
                            } else {
                              await FirebaseFirestore.instance
                                  .collection("dailyUpdate")
                                  .get()
                                  .then((value) async {
                                for (var result in value.docs) {
                                  requestPrice = 0.0;
                                  if (data["category"].toString() ==
                                          result
                                              .data()["category"]
                                              .toString() &&
                                      data["itemName"]
                                              .toString()
                                              .toLowerCase() ==
                                          result
                                              .data()["itemName"]
                                              .toString()
                                              .toLowerCase()) {
                                    requestPrice = double.parse(
                                        result.data()["itemPrice"].toString());

                                    double temp = requestPrice *
                                        double.parse(
                                            data["quantity"].toString());
                                    check = true;
                                    requestPrice = temp;
                                    break;
                                  } else {
                                    check = false;
                                  }
                                }
                              });
                            }

                            if (check == true) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user!.uid)
                                  .collection("balance")
                                  .doc(data["farmerId"])
                                  .set(
                                {
                                  'traderId': user!.uid,
                                  'farmerId': data["farmerId"],
                                  'leneHen': requestPrice,
                                },
                              );
                              await FirebaseFirestore.instance
                                  .collection("farmers")
                                  .doc(data["farmerId"])
                                  .collection("balance")
                                  .doc(user!.uid)
                                  .set(
                                {
                                  'traderId': user!.uid,
                                  'farmerId': data["farmerId"],
                                  'deneHen': requestPrice,
                                },
                              );
                              await FirebaseFirestore.instance
                                  .collection("request")
                                  .doc(docs[i].reference.id)
                                  .update(
                                {
                                  'status': "Accepted",
                                  'traderId': user!.uid,
                                },
                              );

                              await FirebaseFirestore.instance
                                  .collection("farmers")
                                  .doc(data["farmerId"])
                                  .get()
                                  .then((querySnapshot) async {
                                var deneHenData =
                                    querySnapshot.data()!["deneHen"];
                                var leneHenData =
                                    querySnapshot.data()!["leneHen"];

                                if (leneHenData > 0) {
                                  if (leneHenData > requestPrice) {
                                    var price = leneHenData - requestPrice;
                                    await FirebaseFirestore.instance
                                        .collection("farmers")
                                        .doc(data["farmerId"])
                                        .update(
                                      {
                                        'deneHen': int.parse(
                                            deneHenData.toStringAsFixed(0)),
                                        'leneHen': price,
                                      },
                                    );
                                  } else if (leneHenData < requestPrice) {
                                    var price = requestPrice - leneHenData;
                                    await FirebaseFirestore.instance
                                        .collection("farmers")
                                        .doc(data["farmerId"])
                                        .update(
                                      {
                                        'deneHen': int.parse(
                                                price.toStringAsFixed(0)) +
                                            int.parse(
                                                deneHenData.toStringAsFixed(0)),
                                        'leneHen': 0,
                                      },
                                    );
                                  }
                                } else if (leneHenData == 0) {
                                  await FirebaseFirestore.instance
                                      .collection("farmers")
                                      .doc(data["farmerId"])
                                      .update(
                                    {
                                      'deneHen': int.parse(
                                              requestPrice.toStringAsFixed(0)) +
                                          int.parse(
                                              deneHenData.toStringAsFixed(0)),
                                      'leneHen': 0,
                                    },
                                  );
                                }
                              });

                              await HistoryServices.addHistory(
                                context,
                                data["farmerId"],
                                user!.uid,
                                data["itemName"].toString(),
                                requestPrice,
                              );

                              // send Notification to farmer
                              FCMServices.sendFCM(
                                'farmer',
                                data["farmerId"],
                                "Request Accepted",
                                "your request is accepted",
                              );
                            } else if (check == false) {
                              MyMotionToast.warning(
                                context,
                                "Missing",
                                "Add Daily Update first of this Category",
                              );
                            }
                          },
                          function2: () {
                            FirebaseFirestore.instance
                                .collection("request")
                                .doc(docs[i].reference.id)
                                .update(
                              {
                                'status': "Declined",
                                'traderId': user!.uid,
                              },
                            );
                            FCMServices.sendFCM(
                              'farmer',
                              data["farmerId"],
                              "Request Declined",
                              "Trader cancel your request",
                            );
                          },
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
