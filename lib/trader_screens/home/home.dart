import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/trader_screens/authentication/auth_services.dart';
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
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() {
    _firebaseFirestore
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) => {
              this.loggedInUser = UserModel.fromMap(value.data()),
              print(loggedInUser.firstName),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  AuthServices.logOut(context);
                },
                child: Text("Logout")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: dynamicHeight(context, .06),
                  width: dynamicWidth(context, .4),
                  child: Center(
                    child: Text(
                      "Rs. 80,000",
                      style: TextStyle(
                        color: myGreen,
                        fontSize: dynamicWidth(context, .05),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: dynamicHeight(context, .06),
                  width: dynamicWidth(context, .4),
                  child: Center(
                    child: Text(
                      "Rs. 50,000",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: dynamicWidth(context, .05),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: dynamicHeight(context, .06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: dynamicHeight(context, .8),
                    width: dynamicWidth(context, .9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your Farmers",
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .07),
                                color: myGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            width: dynamicWidth(context, .86),
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .006),
                                  ),
                                  child: ListTile(
                                    title: const Text("Ghulam Hussain"),
                                    subtitle:
                                        const Text("Bought a lot of things"),
                                    leading: Icon(
                                      Icons.person,
                                      size: dynamicWidth(context, .1),
                                      color: myGreen,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right_rounded,
                                      size: dynamicWidth(context, .12),
                                      color: myGreen,
                                    ),
                                    tileColor: myGrey,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: myGreen,
        elevation: 4.0,
        child: const Icon(
          Icons.add,
          color: myWhite,
        ),
      ),
    );
  }
}
