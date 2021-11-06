// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/form_fields.dart';

class AddDailyUpdate extends StatefulWidget {
  AddDailyUpdate({Key? key}) : super(key: key);

  @override
  _AddDailyUpdateState createState() => _AddDailyUpdateState();
}

class _AddDailyUpdateState extends State<AddDailyUpdate> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Flexible(
              child: inputTextField(
                context,
                "Item Name",
                itemNameController,
                TextInputType.name,
                auth: false,
                function: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid Item Name';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: inputTextField(
                context,
                "Item Price",
                itemPriceController,
                TextInputType.name,
                auth: false,
                function: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Item Price';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: inputTextField(
                context,
                "Item Unit",
                itemUnitController,
                TextInputType.name,
                auth: false,
                function: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Item Unit';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              child: ElevatedButton(
                onPressed: itemNameController.text == null
                    ? null
                    : () {
                        FirebaseServices.addDailyItemToDB(
                            context,
                            itemNameController.text,
                            itemPriceController.text,
                            itemUnitController.text);
                      },
                child: Text(
                  'Add Item',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
