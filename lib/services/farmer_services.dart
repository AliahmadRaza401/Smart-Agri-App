import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/model/farmer_model.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/trader_screens/authentication/login.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';

class FarmerServices {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static addFarmerToDB(BuildContext context, userName, password, firstName,
      lastName, mobileNumber, cnic) async {
    print('mobileNumber: $mobileNumber');

    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? user = _auth.currentUser;

    FarmerModel farmer = FarmerModel();

    farmer.cnic = cnic;
    farmer.firstName = firstName;
    farmer.mobileNumber = mobileNumber;
    farmer.password = password;
    farmer.secondName = lastName;
    farmer.traderUid = user!.uid;
    farmer.userName = userName;
    authProvider.isLoading(true);

    try {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(farmer.toMap());
      Fluttertoast.showToast(
        msg: "Farmer addeed successfully :) ",
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
      authProvider.isLoading(false);
    } catch (e) {
      authProvider.isLoading(false);

      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
