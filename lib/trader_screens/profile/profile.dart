// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/services/auth_services.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel loggedInUser = UserModel();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    await _firebaseFirestore.collection('users').doc(user!.uid).get().then(
          (value) => {
            setState(() {
              loggedInUser = UserModel.fromMap(value.data());
            }),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: dynamicHeight(context, .06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: dynamicWidth(context, .18),
                    backgroundColor: myYellow,
                    child: Icon(
                      Icons.person,
                      color: myBlack,
                      size: dynamicWidth(context, .26),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .02),
                horizontal: dynamicWidth(context, .06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    loggedInUser.firstName.toString() +
                        " " +
                        loggedInUser.secondName.toString(),
                    style: TextStyle(
                      color: myGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: dynamicWidth(context, .06),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .01),
                horizontal: dynamicWidth(context, .06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "First Name",
                        style: TextStyle(
                          color: myGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .056),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        loggedInUser.firstName ?? 'First Name',
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .048),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .014),
                horizontal: dynamicWidth(context, .06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Last Name",
                        style: TextStyle(
                          color: myGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .056),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        loggedInUser.secondName ?? "Last Name",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .048),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .01),
                horizontal: dynamicWidth(context, .06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Mobile Number",
                        style: TextStyle(
                          color: myGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .056),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        loggedInUser.mobileNumber ?? "Mobile Number",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .048),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .01),
                horizontal: dynamicWidth(context, .06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "CNIC",
                        style: TextStyle(
                          color: myGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .056),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        loggedInUser.cnic ?? "CNIC",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .048),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .04),
                horizontal: dynamicWidth(context, .06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(
                    context,
                    "Log Out",
                    () {
                      AuthServices.logOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
