import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/services/auth_services.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class FarmerProfile extends StatefulWidget {
  final dynamic farmerId;

  const FarmerProfile({Key? key, this.farmerId}) : super(key: key);

  @override
  _FarmerProfileState createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  dynamic farmerFName, farmerLName, farmerNo, farmerCNIC, image = "";

  @override
  void initState() {
    super.initState();
    getFarmerProfile();
  }

  getFarmerProfile() {
    FirebaseFirestore.instance
        .collection("farmers")
        .doc(widget.farmerId)
        .get()
        .then(
          (value) => {
            setState(
              () {
                farmerFName = value.data()!["firstName"];
                farmerLName = value.data()!["lastName"];
                farmerNo = value.data()!["mobileNumber"];
                farmerCNIC = value.data()!["cnic"];
                image = value.data()!["image"]["url"];
              },
            ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            farmerFName.toString() +
                                " " +
                                farmerLName.toString(),
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
                            farmerNo.toString(),
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
                            farmerCNIC.toString(),
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: profileButton(
                        context,
                        Icons.notifications,
                        "Notifications",
                      ),
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
                          image.toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
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
