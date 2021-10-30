import 'package:flutter/material.dart';


class FarmerForm extends StatefulWidget {
  const FarmerForm({Key? key}) : super(key: key);

  @override
  _FarmerFormState createState() => _FarmerFormState();
}

class _FarmerFormState extends State<FarmerForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Farmer"),
      ),
    );
  }
}
