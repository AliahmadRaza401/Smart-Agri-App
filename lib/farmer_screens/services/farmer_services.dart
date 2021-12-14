// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

class FarmerServices {
  static getFarmerProfileByID(farmerId) {
    var response =
        FirebaseFirestore.instance.collection("farmers").doc(farmerId).get();
    return response;
  }

  static sendRequest(
    BuildContext context,
    farmerId,
    traderId,
    farmerName,
    farmerImage,
    farmerNumber,
    itemName,
    category,
    subCategory,
    unit,
    quantity,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection("request").doc().set({
      'farmerId': farmerId,
      'traderId': traderId,
      'farmerName': farmerName,
      'farmerImage': farmerImage,
      'farmerNumber': farmerNumber,
      "itemName": itemName,
      "category": category,
      "subCategory": subCategory,
      "unit": unit,
      "quantity": quantity,
      "status": "Pending"
    }).then((value) {
      Fluttertoast.showToast(
        msg: "Account created successfully :) ",
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
      AppRoutes.pop(context);
    }).catchError(() {
      oopsAlert(context, "Request Failed! \n Please try again later");
    });
  }
}
