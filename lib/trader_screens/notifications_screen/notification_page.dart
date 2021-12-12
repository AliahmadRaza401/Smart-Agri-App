import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/add_update_dialog.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

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
                        return farmerRequestCard(
                          context,
                          "image",
                          "number",
                          data["itemName"].toString(),
                          data["category"].toString(),
                          data["quantity"].toString(),
                          data["unit"].toString(),
                          data["status"].toString(),
                          farmer: false,
                          function1: () async {
                            dynamic check, price;
                            await FirebaseFirestore.instance
                                .collection("rates")
                                .get()
                                .then((value) async {
                              for (var result in value.docs) {
                                if (result.data()["traderID"].toString() ==
                                        user!.uid &&
                                    data["category"].toString().toLowerCase() ==
                                        result
                                            .data()["category"]
                                            .toString()
                                            .toLowerCase()) {
                                  if (data["category"]
                                          .toString()
                                          .toLowerCase() ==
                                      "cash") {
                                    check = true;
                                    price = result.data()["price"];
                                    break;
                                  } else {
                                    price = result.data()["price"];
                                    var temp = int.parse(price.toString()) *
                                        int.parse(data["quantity"].toString());
                                    check = true;
                                    price = temp;
                                    break;
                                  }
                                } else {
                                  check = false;
                                }
                              }
                              if (check == true) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user!.uid)
                                    .update(
                                  {
                                    'leneHen': price,
                                  },
                                );
                                await FirebaseFirestore.instance
                                    .collection("farmers")
                                    .doc(data["farmerId"])
                                    .update(
                                  {
                                    'deneHen': price,
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
                              } else if (check == false) {
                                Fluttertoast.showToast(
                                  msg:
                                      "Add Daily Update first of this Category",
                                  backgroundColor: myGreen,
                                  textColor: myWhite,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            });
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
