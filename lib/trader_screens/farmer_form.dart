import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/services/farmer_services.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/form_fields.dart';

final _formKey = GlobalKey<FormState>();
final farmerFName = TextEditingController();
final farmerLName = TextEditingController();
final userName = TextEditingController();
final farmerPassword = TextEditingController(text: "password");
final farmerNumber = TextEditingController();
final farmerCnic = TextEditingController();

class FarmerForm extends StatefulWidget {
  const FarmerForm({Key? key}) : super(key: key);

  @override
  _FarmerFormState createState() => _FarmerFormState();
}

class _FarmerFormState extends State<FarmerForm> {
  @override
  Widget build(BuildContext context) {
        var loading = Provider.of<AuthProvider>(context).loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Farmer",
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
          child: Container(
            width: dynamicWidth(context, .9),
            height: dynamicHeight(context, .76),
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
                          "Add New Farmer",
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
                            "UserName",
                            userName,
                            TextInputType.phone,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid Username';
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
                            "First Name",
                            farmerFName,
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
                            "Last Name",
                            farmerLName,
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
                            "Mobile Number",
                            farmerNumber,
                            TextInputType.phone,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty || value.length < 11) {
                                return 'Please enter a valid Number';
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
                            "CNIC",
                            farmerCnic,
                            TextInputType.number,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty || value.length <= 13) {
                                return 'Please enter a valid CNIC';
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
                            "Password",
                            farmerPassword,
                            TextInputType.visiblePassword,
                            password: true,
                            auth: false,
                            function: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Password must have 6 characters';
                              }
                              return null;
                            },
                            function2: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
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
                      loading == false ?
                      "ADD FARMER" : "Loading...",
                      () {
                        if (!_formKey.currentState!.validate()) {
                          FarmerServices.addFarmerToDB(
                              context,
                              userName.text,
                              farmerPassword.text,
                              farmerFName.text,
                              farmerLName.text,
                              farmerNumber.text,
                              farmerCnic.text);
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
