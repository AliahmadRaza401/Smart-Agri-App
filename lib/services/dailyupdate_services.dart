// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/farmer_screens/services/balance_services.dart';
import 'package:smart_agri/services/fcm_services.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/widgets/motion_toast.dart';

class DailyUpdateServices {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static addDailyItemToDB(
    BuildContext context,
    name,
    price,
    unit,
    category,
    subCategory,
    imageFile,
    description,
  ) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);

    try {
      var image = await FirebaseServices.imageUpload(imageFile, now.toString());

      firebaseFirestore.collection("dailyUpdate").add({
        'itemName': name,
        'itemPrice': price,
        'itemUnit': unit,
        'category': category,
        'subCategory': subCategory,
        'date': date,
        'time': time,
        'createdAt': now,
        'traderId': user!.uid,
        'image': {'name': now.toString(), 'url': image},
        'description':description,
      });
      BalanceServices.sendRequest(
        context,
        user.uid,
        category,
        price,
      );
      await FCMServices.sendFCM(
        'farmer',
        "",
        "$name Post",
        "Trader add new Post in Daily Update",
      );
      authProvider.isLoading(false);
      MyMotionToast.success(
        context,
        "Success",
        "Post Upload Successfully",
      );

      AppRoutes.pop(context);
    } catch (e) {
      authProvider.isLoading(false);

      MyMotionToast.error(
        context,
        "Error",
        e.toString(),
      );
    }
  }

  static updateDailyItemToDB(
    BuildContext context,
    docsID,
    name,
    price,
    unit,
    itemCategory,
  ) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);

    try {
      firebaseFirestore.collection("dailyUpdate").doc(docsID).update({
        'itemName': name,
        'itemPrice': price,
        'itemUnit': unit,
        'category': itemCategory,
        'date': date,
        'time': time,
        'traderId': user!.uid,
      });
      authProvider.isLoading(false);
      MyMotionToast.success(
        context,
        "Success",
        "Update Successfully Donw",
      );
      AppRoutes.pop(context);
    } catch (e) {
      authProvider.isLoading(false);

      MyMotionToast.error(
        context,
        "Error",
        e.toString(),
      );
    }
  }
}
