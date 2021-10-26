import 'package:flutter/material.dart';

import '../utils/config.dart';
import 'dynamic_size.dart';

Widget button(context, text, function) {
  return InkWell(
    onTap: function,
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
