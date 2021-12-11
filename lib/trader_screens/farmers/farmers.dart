// ignore_for_file: unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/trader_screens/farmers/farmer_details.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/box_widgets.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/form_fields.dart';

import 'farmer_form.dart';

class Farmers extends StatefulWidget {
  const Farmers({Key? key}) : super(key: key);

  @override
  _FarmersState createState() => _FarmersState();
}

class _FarmersState extends State<Farmers> {
  User? user = FirebaseAuth.instance.currentUser;

  final searchQuery = TextEditingController();
  String stream = "";

  @override
  void initState() {
    super.initState();
  }

  // addAmount(farmerId) async {
  //   print("hy");
  //   QuerySnapshot snap = await FirebaseFirestore.instance
  //       .collection('farmers')
  //       .doc(farmerId)
  //       .collection('balance')
  //       .get();

  //   for (int i = 0; i < snap.docs.length; i++) {
  //     var a = snap.docs[i].data();
  //     var b = a['name'] == null ? "sdf" : "asdf";
  //     print('a: ${a['name'] ?? "vnnbm"}');
  //   }

  //   // snap.docs.forEach((document) {
  //   //   print(document.data());

  //   //   var credit = 0;
  //   //   var dabit = 0;
  //   //   if (document[0].data()!['type'] == 'credit') {
  //   //     print("credit type DAta");
  //   //     setState(() {
  //   //       credit = document.data()['credit'];
  //   //     });
  //   //   } else {
  //   //       print("dabit type DAta");
  //   //     setState(() {
  //   //       credit = document.data()!['dabit'];
  //   //     });
  //   //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: AppBar(
        title: const Text(
          "Farmers",
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
                  "All Farmers",
                  style: TextStyle(
                    color: myGreen,
                    fontSize: dynamicWidth(context, .05),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: stream != ""
                  ? FirebaseFirestore.instance
                      .collection('farmers')
                      .where("firstName", isEqualTo: stream.toLowerCase())
                      .snapshots()
                  : FirebaseFirestore.instance
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
                      dynamicHeight(context, .3),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        print('docs[i]: ${docs[i].id}');
                        // addAmount(docs[i].id);
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
                              vertical: dynamicHeight(context, .014),
                              horizontal: dynamicWidth(context, .04),
                            ),
                            child: farmerCard(
                              context,
                              data['userName'],
                              data['mobileNumber'],
                              "80,000",
                              "30,000",
                              data['image']['url'],
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
          SizedBox(
            height: dynamicHeight(context, .02),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppRoutes.push(
            context,
            const FarmerForm(),
          );
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Farmer',
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
    );
  }
}
