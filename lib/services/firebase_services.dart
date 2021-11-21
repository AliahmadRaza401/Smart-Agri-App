import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_agri/utils/config.dart';

class FirebaseServices {
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static deleteRecord(BuildContext context, docsName, id) {
    var collection = FirebaseFirestore.instance.collection(docsName);
    collection
        .doc(id) // <-- Doc ID to be deleted.
        .delete()
        .then((e) {
      Fluttertoast.showToast(
        msg: "Delete Successfully!",
        backgroundColor: myGreen,
        textColor: myWhite,
      );
      print("Delete");
    });
  }

  static deleteBalance(BuildContext context, farmerId, balanceId) {
    try {
      FirebaseFirestore.instance
          .collection("farmers")
          .doc(farmerId)
          .collection("balance")
          .doc(balanceId)
          .delete();
      Fluttertoast.showToast(
        msg: "Delete Successfully!",
        backgroundColor: myGreen,
        textColor: myWhite,
      );
    } catch (e) {
      print("Failed!");
    }
  }

  static Future<String> imageUpload(imageFile, name) async {
    var image;
    print('imageFile: $imageFile');
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(name);
    UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.then((res) {
      image = res.ref.getDownloadURL();
      print('image: $image');
    });
    return image;
  }
}
