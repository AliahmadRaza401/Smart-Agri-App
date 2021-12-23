// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:smart_agri/utils/config.dart';

class FCMServices {
  static fcmGetTokenandSubscribe(topic) {
    FirebaseMessaging.instance.getToken().then((value) {
      print("FCM Token: $value");
      FirebaseMessaging.instance.subscribeToTopic("$topic");
      print("Scribe $topic Success");
    });
  }

 static Future<http.Response> sendFCM(topic, id, title, description) {
    return http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "key=$serverKey",
      },
      body: jsonEncode({
        "to": "/topics/$topic",
        "notification": {
          "title": title,
          "body": description,
        },
        "data": {
          "id": id,
        }
      }),
    );
  }
}
