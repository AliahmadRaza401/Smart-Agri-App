import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BalanceServices {
  static sendRequest(
    BuildContext context,
    traderID,
    category,
    price,

  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("rates").doc(traderID).set({
      'category': category,
      'price': price,
      'traderID': traderID,
    });
  }
}
