import 'package:flutter/material.dart';

import '../config.dart';
import 'dynamic_size.dart';

Widget button(context, text, {page}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    child: Container(
      width: dynamicWidth(context, .8),
      height: dynamicHeight(context, .064),
      decoration: BoxDecoration(
        color: myGreen,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .026),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: dynamicWidth(context, .054),
          ),
        ),
      ),
    ),
  );
}
