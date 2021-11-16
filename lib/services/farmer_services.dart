// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';

class FarmerServices {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

// add farmer in DB
  static addFarmerToDB(BuildContext context, userName, password, firstName,
      lastName, mobileNumber, cnic) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;

    authProvider.isLoading(true);

    try {
      print(firstName);
      firebaseFirestore.collection("farmers").add({
        'firstName': firstName,
        'lastName': lastName,
        'cnic': cnic,
        'mobileNumber': mobileNumber,
        'userName': userName,
        'password': password,
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

  // add farmer in DB
  static addFarmerAmount(
    BuildContext context,
    farmerId,
    name,
    price,
    balanceType,
  ) async {
    print('adding Farmer Amount...........:');
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);

    try {
      firebaseFirestore
          .collection("farmers")
          .doc(farmerId)
          .collection("balance")
          .add(
        {
          'type': balanceType,
          'name': name,
          'price': price,
          'date': date,
          'time': time,
        },
      );
      authProvider.isLoading(false);
      Fluttertoast.showToast(
        msg: "Added Success",
        backgroundColor: myGreen,
        textColor: myWhite,
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
      );
    }
  }
}
