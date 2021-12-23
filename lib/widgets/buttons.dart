import 'package:flutter/material.dart';

import '../utils/config.dart';
import 'dynamic_size.dart';

Widget button(
  context,
  text,
  function, {
  width = "",
  height = "",
  fontSize = "",
  color = "",
  btnColor = "",
}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Container(
      width: width == "" ? dynamicWidth(context, .8) : width,
      height: height == "" ? dynamicHeight(context, .064) : height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .6),
        ),
        gradient: LinearGradient(
          colors: [
            btnColor == "" ? myGreen : btnColor,
            btnColor == "" ? myLiteGreen : btnColor,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color == "" ? myWhite : color,
            fontSize: fontSize == "" ? dynamicWidth(context, .054) : fontSize,
          ),
        ),
      ),
    ),
  );
}

Widget cancelButton(
  context,
  text,
  function, {
  width = "",
  height = "",
  fontSize = "",
  color = "",
  btnColor = "",
}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Container(
      width: width == "" ? dynamicWidth(context, .8) : width,
      height: height == "" ? dynamicHeight(context, .064) : height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .6),
        ),
        border: Border.all(
          color: myRed, //                   <--- border color
          width: 2.0,
        ),
        gradient: LinearGradient(
          colors: [
            btnColor == "" ? myGreen : btnColor,
            btnColor == "" ? myLiteGreen : btnColor,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color == "" ? myWhite : color,
            fontSize: fontSize == "" ? dynamicWidth(context, .054) : fontSize,
          ),
        ),
      ),
    ),
  );
}

Widget redButton(
  context,
  text,
  function, {
  width = "",
  height = "",
  fontSize = "",
}) {
  return InkWell(
    onTap: function,
    child: Container(
      width: width == "" ? dynamicWidth(context, .8) : width,
      height: height == "" ? dynamicHeight(context, .064) : height,
      decoration: BoxDecoration(
        color: myRed,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .6),
        ),
        gradient: const LinearGradient(
          colors: [
            myRed,
            myRed,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize == "" ? dynamicWidth(context, .054) : fontSize,
          ),
        ),
      ),
    ),
  );
}

Widget profileButton(context, icon, text, {function = ""}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Container(
      width: dynamicWidth(context, .8),
      height: dynamicHeight(context, .066),
      decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .03),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: dynamicWidth(context, .04),
        vertical: dynamicWidth(context, .02),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: myGreen,
          ),
          SizedBox(
            width: dynamicWidth(context, .06),
          ),
          Text(
            text,
            style: TextStyle(
              color: myBlack,
              fontWeight: FontWeight.w500,
              fontSize: dynamicWidth(context, .04),
            ),
          ),
        ],
      ),
    ),
  );
}
