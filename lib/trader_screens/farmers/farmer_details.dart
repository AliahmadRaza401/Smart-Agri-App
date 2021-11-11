import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/add_amount_dialog.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

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
      body: Container(
        color: Colors.amber,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Text("Body"),
            )),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AddAmount());
                      },
                      child: Text("You Gave Rs")),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AddAmount());
                      },
                      child: Text("You Got Rs")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
