import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/authentication/auth_services.dart';
import 'package:smart_agri/trader_screens/farmer_form.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() {
    _firebaseFirestore.collection('users').doc(user!.uid).get().then(
          (value) => {
            loggedInUser = UserModel.fromMap(value.data()),
            print(loggedInUser.firstName),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: dynamicHeight(context, .24),
                width: dynamicWidth(context, 1),
                decoration: BoxDecoration(
                  color: myGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      dynamicWidth(context, .04),
                    ),
                    bottomRight: Radius.circular(
                      dynamicWidth(context, .04),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                        horizontal: dynamicWidth(context, .06),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hi, ${loggedInUser.firstName}',
                            style: TextStyle(
                              color: myWhite,
                              fontSize: dynamicWidth(context, .06),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AuthServices.logOut(context);
                            },
                            child: Icon(
                              Icons.logout,
                              color: myWhite,
                              size: dynamicWidth(context, .08),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: dynamicHeight(context, .12),
                            width: dynamicWidth(context, .4),
                            decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(
                                dynamicWidth(context, .03),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: myWhite.withOpacity(0.4),
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "DEBIT",
                                      style: TextStyle(
                                        color: myBlack,
                                        fontSize: dynamicWidth(context, .054),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rs. 80,000",
                                      style: TextStyle(
                                        color: myGreen,
                                        fontSize: dynamicWidth(context, .048),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: dynamicHeight(context, .12),
                            width: dynamicWidth(context, .4),
                            decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(
                                dynamicWidth(context, .03),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: myWhite.withOpacity(0.4),
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "CREDIT",
                                      style: TextStyle(
                                        color: myBlack,
                                        fontSize: dynamicWidth(context, .054),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rs. 30,000",
                                      style: TextStyle(
                                        color: myRed,
                                        fontSize: dynamicWidth(context, .048),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .06),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Farmers",
                      style: TextStyle(
                        fontSize: dynamicWidth(context, .066),
                        color: myGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: dynamicHeight(context, .46),
                    width: dynamicWidth(context, .9),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .006),
                          ),
                          child: ListTile(
                            title: const Text(
                              "Ghulam Hussain",
                              style: TextStyle(
                                color: myWhite,
                              ),
                            ),
                            subtitle: const Text(
                              "Bought a lot of things",
                              style: TextStyle(
                                color: myGrey,
                              ),
                            ),
                            leading: Icon(
                              Icons.person,
                              size: dynamicWidth(context, .1),
                              color: myWhite,
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              size: dynamicWidth(context, .12),
                              color: myWhite,
                            ),
                            tileColor: myGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                dynamicWidth(context, .02),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppRoutes.push(context, const FarmerForm());
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Farmer',
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
    );
  }
}
