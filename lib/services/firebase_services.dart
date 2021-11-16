// ignore_for_file: avoid_print, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/model/farmer_model.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/trader_screens/authentication/login.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';

class FirebaseServices {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static addDailyItemToDB(
    BuildContext context,
    name,
    price,
    unit,
  ) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);

    try {
      print(name);
      firebaseFirestore.collection("dailyUpdate").add({
        'itemName': name,
        'itemPrice': price,
        'itemUnit': unit,
        'date': date,
        'time': time,
        'traderId': user!.uid,
      });
      authProvider.isLoading(false);
      Fluttertoast.showToast(
        msg: "Added Success",
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
      AppRoutes.pop(context);
      print("Success");
    } catch (e) {
      authProvider.isLoading(false);
      print("Catch Error");
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  static deleteRecord(BuildContext context, docsName, id) {
    var collection = FirebaseFirestore.instance.collection(docsName);
    collection
        .doc(id) // <-- Doc ID to be deleted.
        .delete()
        .then((e) {
      Fluttertoast.showToast(
        msg: "Delete Successfully!",
        backgroundColor: myGreen,
        textColor: myWhite,
      );
      print("Delete");
    });
  }

  static deleteBalance(BuildContext context, farmerId, balanceId) {
    try {
      FirebaseFirestore.instance
          .collection("farmers")
          .doc(farmerId)
          .collection("balance")
          .doc(balanceId)
          .delete();
      Fluttertoast.showToast(
        msg: "Delete Successfully!",
        backgroundColor: myGreen,
        textColor: myWhite,
      );
    } catch (e) {
      print("Failed!");
    }
  }
}
