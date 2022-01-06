// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/fcm_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:smart_agri/widgets/motion_toast.dart';

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
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    authProvider.isLoading(true);

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
      "status": "Pending",
      "timeStamp": DateTime.now(),
    }).then((value) {
      FCMServices.sendFCM(
        'trader',
        '$traderId',
        "New Request",
        "$farmerName send a request for $category",
      );
      authProvider.isLoading(false);
      AppRoutes.pop(context);
      MyMotionToast.success(
        context,
        "Success",
        "Request Send Successfully :) ",
      );

      AppRoutes.pop(context);
    }).catchError(() {
      authProvider.isLoading(false);
      oopsAlert(context, "Request Failed! \n Please try again later");
    });
  }
}
