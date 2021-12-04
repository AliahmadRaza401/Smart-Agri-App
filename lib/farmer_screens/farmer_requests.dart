import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/farmer_screens/add_request.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class FarmerRequests extends StatefulWidget {
  final dynamic farmerId;

  const FarmerRequests({Key? key, this.farmerId}) : super(key: key);

  @override
  _FarmerRequestsState createState() => _FarmerRequestsState();
}

class _FarmerRequestsState extends State<FarmerRequests> {
  dynamic traderId;

  @override
  void initState() {
    super.initState();
    getFarmerData();
  }

  getFarmerData() {
    FirebaseFirestore.instance
        .collection("farmers")
        .doc(widget.farmerId)
        .get()
        .then(
          (value) => {
            setState(
              () {
                traderId = value.data()!["traderId"];
              },
            ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: AppBar(
        title: const Text(
          "Requests",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddRequest(
              farmerId: widget.farmerId,
              traderId: traderId,
            ),
          );
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Request',
          style: TextStyle(
            color: myWhite,
            fontSize: dynamicWidth(context, .04),
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
        ),
        icon: const Icon(
          Icons.add,
          color: myWhite,
        ),
      ),
      // body: Text("data"),
    );
  }
}
