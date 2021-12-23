import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_agri/model/user_model.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/start_up/choice.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';
import 'package:smart_agri/trader_screens/authentication/login.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/botton_nav.dart';

class AuthServices {
  static var errorMessage;

  //SignIn
  static void signIn(
      BuildContext context, String email, String password) async {
    final auth = FirebaseAuth.instance;
    AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    _authProvider.isLoading(true);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(
                  msg: "LogIn Successful",
                  backgroundColor: myGreen,
                  textColor: myWhite,
                  gravity: ToastGravity.CENTER,
                ),
                AppRoutes.replace(
                  context,
                  const BottomNav(),
                ),
                userLoggedIn(true),
                _authProvider.isLoading(false),
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address is invalid.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      _authProvider.isLoading(false);

      // GeneralDialogs.showOopsDialog(context, errorMessage);
      Fluttertoast.showToast(
        msg: errorMessage!,
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  // SignUp-----------------------------------------
  static void signUp(BuildContext context, String email, String password,
      firstName, lastName, mobilenumber, cnic, imageFile) async {
    final _auth = FirebaseAuth.instance;
    AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    _authProvider.isLoading(true);
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(context, firstName, lastName,
                    mobilenumber, cnic, imageFile),
                _authProvider.isLoading(false),
              })
          .catchError((e) {
        print(e);
        Fluttertoast.showToast(
          msg: e!.message,
          backgroundColor: myGreen,
          textColor: myWhite,
          gravity: ToastGravity.CENTER,
        );
        _authProvider.isLoading(false);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address is invalid";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      _authProvider.isLoading(false);
      Fluttertoast.showToast(
        msg: errorMessage!,
        backgroundColor: myGreen,
        textColor: myWhite,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  static postDetailsToFirestore(BuildContext context, firstName, lastName,
      mobileNumber, cnic, imageFile) async {
    // calling our firestore
    // calling our user model
    // sending these values
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName;
    userModel.secondName = lastName;
    userModel.mobileNumber = mobileNumber;
    userModel.cnic = cnic;

    var image = await FirebaseServices.imageUpload(imageFile, cnic);
    print('image: $image');

    await firebaseFirestore.collection("users").doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'firstName': firstName,
      'secondName': lastName,
      'mobileNumber': mobileNumber,
      'cnic': cnic,
      'image': {'name': cnic, 'url': image}
    });
    Fluttertoast.showToast(
      msg: "Account created successfully :) ",
      backgroundColor: myGreen,
      textColor: myWhite,
      gravity: ToastGravity.CENTER,
    );

    AppRoutes.push(context, const LoginPage());
  }

  // LogOut--------------------------------------

  static logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    userLoggedIn(false);
    AppRoutes.replace(context, const Choice());
  }

  static logOutFarmer(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    farmerLoggedIn(false);
    AppRoutes.replace(context, const Choice());
  }

  // user Logged
  static userLoggedIn(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userLoggedIn', value);
  }

// get user LoggedIn value
  static getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('userLoggedIn');
    return boolValue;
  }

  // Farmer Logged
  static farmerLoggedIn(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('farmerLoggedIn', value);
  }

// get Farmer LoggedIn value
  static getFarmerLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('farmerLoggedIn');
    return boolValue;
  }

// save FarmerId
  static saveFarmerID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('farmerID', value);
  }

  // get Farmer LoggedIn value
  static getFarmerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('farmerID');
    return value;
  }

  // save TraderId
  static saveTraderID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('traderID', value);
  }

  // get Farmer LoggedIn value
  static getTraderID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('traderID');
    return value;
  }
}
