// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/services/auth_services.dart';
import 'package:smart_agri/trader_screens/history/trader_history.dart';
import 'package:smart_agri/trader_screens/profile/edit_profile.dart';
import 'package:smart_agri/utils/app_route.dart';
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

  String? userImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    await _firebaseFirestore.collection('users').doc(user!.uid).get().then(
          (value) =>
      {
        setState(() {
          userImage = value.data()!['image']['url'].toString();


          loggedInUser = UserModel.fromMap(value.data());
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: myGrey,
      body: SizedBox(
        width: dynamicWidth(context, 1),
        height: dynamicHeight(context, 1),
        child: Stack(
          children: [
            SizedBox(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, .3),
              child: Image.asset(
                "assets/profile_bg.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: dynamicWidth(context, 1),
                height: dynamicHeight(context, .7),
                decoration: BoxDecoration(
                  color: myGrey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      dynamicWidth(context, .1),
                    ),
                    topLeft: Radius.circular(
                      dynamicWidth(context, .1),
                    ),
                  ),
                ),
                padding: EdgeInsets.all(
                  dynamicWidth(context, .06),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: dynamicHeight(context, .08),
                        bottom: dynamicHeight(context, .006),
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
                              fontSize: dynamicWidth(context, .056),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .004),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loggedInUser.mobileNumber ?? "Mobile Number",
                            style: TextStyle(
                              color: myGreen,
                              fontSize: dynamicWidth(context, .048),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .004),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loggedInUser.email ?? "Email",
                            style: TextStyle(
                              color: myGreen,
                              fontSize: dynamicWidth(context, .048),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .004),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loggedInUser.cnic ?? "CNIC",
                            style: TextStyle(
                              color: myGreen,
                              fontSize: dynamicWidth(context, .048),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .04),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: profileButton(
                        context,
                        Icons.edit,
                        "Edit Profile",
                        function: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                EditTraderProfile(
                                    firstName: loggedInUser.firstName
                                        .toString(),
                                    secondName: loggedInUser.secondName
                                        .toString(),
                                    cnic: loggedInUser.cnic.toString(),
                                    mobileNumber: loggedInUser.mobileNumber
                                        .toString(),
                                ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: profileButton(context, Icons.history, "History",
                          function: () {
                            AppRoutes.push(
                                context, TraderHistory(traderId: user!.uid));
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: profileButton(context, Icons.logout, "LogOut",
                          function: () {
                            AuthServices.logOut(context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: dynamicHeight(context, .14),
                  ),
                  child: Container(
                      width: dynamicWidth(context, .32),
                      height: dynamicHeight(context, .16),
                      decoration: BoxDecoration(
                        color: myWhite,
                        borderRadius: BorderRadius.circular(
                          dynamicWidth(context, .06),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            "$userImage",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text("")
                    //  Image.network(

                    //   userImage.toString(),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
