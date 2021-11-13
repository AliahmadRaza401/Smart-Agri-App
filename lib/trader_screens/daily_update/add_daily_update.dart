import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/form_fields.dart';



class AddDailyUpdate extends StatefulWidget {
  const AddDailyUpdate({Key? key}) : super(key: key);

  @override
  _AddDailyUpdateState createState() => _AddDailyUpdateState();
}

class _AddDailyUpdateState extends State<AddDailyUpdate> {
  final _formKey = GlobalKey<FormState>();
final itemName = TextEditingController();
final itemPrice = TextEditingController();
final itemUnit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<AuthProvider>(context).loading;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Update",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            width: dynamicWidth(context, .9),
            height: dynamicHeight(context, .7),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: dynamicHeight(context, .03),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add New Update",
                          style: TextStyle(
                            color: myGreen,
                            fontSize: dynamicWidth(context, .07),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .01),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: inputTextField(
                            context,
                            "Item Name",
                            itemName,
                            TextInputType.name,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .01),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: inputTextField(
                            context,
                            "Item Price",
                            itemPrice,
                            TextInputType.number,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid Price';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .01),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: inputTextField(
                            context,
                            "item Unit",
                            itemUnit,
                            TextInputType.name,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid Unit';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .02),
                    ),
                    child: button(
                      context,
                      loading == false ? "ADD Update" : "Loading...",
                      () {
                        if (!_formKey.currentState!.validate()) {
                          print(itemName.text + itemPrice.text + itemUnit.text);
                          return;
                        } else {
                          FirebaseServices.addDailyItemToDB(
                            context,
                            itemName.text,
                            itemPrice.text,
                            itemUnit.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
