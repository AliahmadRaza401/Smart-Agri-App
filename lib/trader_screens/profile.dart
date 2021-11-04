import 'package:flutter/material.dart';
import 'package:smart_agri/services/auth_services.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            AuthServices.logOut(context);
          },
          child: const Icon(
            Icons.logout,
          ),
        ),
      ),
    );
  }
}
