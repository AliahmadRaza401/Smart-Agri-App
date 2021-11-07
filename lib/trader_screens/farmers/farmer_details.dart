import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';

class FarmerDetails extends StatefulWidget {
  final String userName;

  const FarmerDetails({Key? key, required this.userName}) : super(key: key);

  @override
  _FarmerDetailsState createState() => _FarmerDetailsState();
}

class _FarmerDetailsState extends State<FarmerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName.toString(),
          style: const TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
    );
  }
}
