import 'package:flutter/material.dart';

class FarmerHomeScreen extends StatefulWidget {
  final dynamic farmerId;

  const FarmerHomeScreen({Key? key, this.farmerId}) : super(key: key);

  @override
  _FarmerHomeScreenState createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Ali You are in Farmer Home Screen. Ok?\nFarmer Id = " +
              widget.farmerId.toString() +
              "\nNow Use this id to get all data of that document. ok?"
                  "\nAsh Kro!!!",
        ),
      ),
    );
  }
}
