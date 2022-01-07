import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/trader_screens/farmers/farmers.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/widgets/motion_toast.dart';

import 'history.dart';

class FarmerServicesTrader {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

// add farmer in DB
  static addFarmerToDB(
    BuildContext context,
    farmerNo,
    userName,
    password,
    firstName,
    lastName,
    mobileNumber,
    cnic,
    imageFile,
  ) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);

    try {
      var image = await FirebaseServices.imageUpload(imageFile, cnic);
      firebaseFirestore.collection("farmers").add({
        'farmerNo': farmerNo,
        'firstName': firstName,
        'lastName': lastName,
        'cnic': cnic,
        'mobileNumber': mobileNumber,
        'userName': userName,
        'password': password,
        'traderId': user!.uid,
        'leneHen': 0.0,
        'deneHen': 0.0,
        'image': {
          'name': cnic,
          'url': image,
        },
      });

      authProvider.isLoading(false);
      AppRoutes.pop(context);

      MyMotionToast.success(
        context,
        "Success",
        "Farmer account created successfully :) ",
      );
    } catch (e) {
      authProvider.isLoading(false);
      MyMotionToast.error(
        context,
        "Error",
        e.toString(),
      );
    }
  }

  static updateFarmerToDB(BuildContext context, docsId, userName, password,
      firstName, lastName, mobileNumber, cnic) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;

    authProvider.isLoading(true);

    try {
      firebaseFirestore.collection("farmers").doc(docsId).update({
        'firstName': firstName,
        'lastName': lastName,
        'cnic': cnic,
        'mobileNumber': mobileNumber,
        'userName': userName,
        'password': password,
        'traderId': user!.uid,
      });

      authProvider.isLoading(false);
      MyMotionToast.success(
        context,
        "Success",
        "Farmer update successfully :) ",
      );
      AppRoutes.replace(context, Farmers());
    } catch (e) {
      authProvider.isLoading(false);
      MyMotionToast.error(
        context,
        "Error",
        'Oops! something went wrong',
      );
    }
  }

  // add farmer in DB
  static addFarmerAmount(
    BuildContext context,
    farmerId,
    name,
    price,
    todayPrice,
  ) async {
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;
    authProvider.isLoading(true);

    dynamic t1 = (int.parse(price.toString()) / 100);
    dynamic labourCharges = (t1 * 1);
    dynamic brokerCharges = (t1 * 0.15);
    dynamic traderCharges = (t1 * 1.6);
    dynamic deduction = labourCharges + brokerCharges + traderCharges;
    dynamic finalPrice = (int.parse(price.toString()) - deduction);

    try {
      firebaseFirestore
          .collection("farmers")
          .doc(farmerId)
          .collection("balance")
          .add(
        {
          'name': name,
          'price': price,
          'date': date,
          'time': time,
          'labourCharges': labourCharges,
          'brokerCharges': brokerCharges,
          'traderCharges': traderCharges,
          'deductions': deduction,
          'finalBalance': finalPrice,
          'todayPrice': todayPrice,
          "timeStamp": DateTime.now(),
        },
      );

      await FirebaseFirestore.instance
          .collection("farmers")
          .doc(farmerId)
          .get()
          .then((querySnapshot) async {
        var deneHenData = querySnapshot.data()!["deneHen"] ?? 0;
        var leneHenData = querySnapshot.data()!["leneHen"] ?? 0;

        if (deneHenData > 0) {
          if (deneHenData > finalPrice) {
            finalPrice = deneHenData - finalPrice;
            await firebaseFirestore.collection("farmers").doc(farmerId).update(
              {
                'deneHen': finalPrice,
                'leneHen': leneHenData,
              },
            );
          } else if (deneHenData < finalPrice) {
            finalPrice = finalPrice - deneHenData;
            await firebaseFirestore.collection("farmers").doc(farmerId).update(
              {
                'deneHen': 0,
                'leneHen': finalPrice + leneHenData,
              },
            );
          }
        } else if (deneHenData == 0) {
          await firebaseFirestore.collection("farmers").doc(farmerId).update(
            {
              'deneHen': 0,
              'leneHen': finalPrice + leneHenData,
            },
          );
        }
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .get()
          .then((querySnapshot) async {
        var balance = querySnapshot.data()!["balance"] ?? 0;
        await firebaseFirestore.collection("users").doc(user?.uid).update({
          "balance": traderCharges + balance,
        });
      });

      authProvider.isLoading(false);
      HistoryServices.addHistory(
        context,
        farmerId,
        user!.uid,
        name,
        finalPrice,
      );

      MyMotionToast.success(
        context,
        "Success",
        "Amount added successfully :) ",
      );
      AppRoutes.pop(context);
    } catch (e) {
      authProvider.isLoading(false);
      MyMotionToast.error(
        context,
        "Error",
        "Oops! something went wrong",
      );
      AppRoutes.pop(context);
    }
  }
}
