// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';

class DailyUpdateServices {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static addDailyItemToDB(
      BuildContext context, name, price, unit, imageFile) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);

    try {
      print(name);
      var image = await FirebaseServices.imgeUpload(imageFile, now.toString());
      print('image: $image');
      firebaseFirestore.collection("dailyUpdate").add({
        'itemName': name,
        'itemPrice': price,
        'itemUnit': unit,
        'date': date,
        'time': time,
        'traderId': user!.uid,
        'image': {'name': now.toString(), 'url': image}
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

  static updateDailyItemToDB(
    BuildContext context,
    docsID,
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
      firebaseFirestore.collection("dailyUpdate").doc(docsID).update({
        'itemName': name,
        'itemPrice': price,
        'itemUnit': unit,
        'date': date,
        'time': time,
        'traderId': user!.uid,
      });
      authProvider.isLoading(false);
      Fluttertoast.showToast(
        msg: "Update Success!",
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
}
