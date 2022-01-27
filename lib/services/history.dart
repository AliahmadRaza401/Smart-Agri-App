// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static addHistory(
    BuildContext context,
    farmerId,
    traderId,
    name,
    price,
    farmerName,
      mode,
      quantity,
  ) async {
    DateTime now = DateTime.now();
    var date = DateFormat.yMMMMd('en_US').format(now);
    var time = DateFormat.jm().format(now);

    try {
      firebaseFirestore.collection("history").add(
        {
          'name': name,
          'price': price,
          'date': date,
          'time': time,
          'mode' : mode,
          'quantity': quantity,
          'farmerId': farmerId,
          'traderId': traderId,
          'timeStamp': now,
          'farmerName': farmerName,
        },
      );
    } catch (e) {}
  }
}
