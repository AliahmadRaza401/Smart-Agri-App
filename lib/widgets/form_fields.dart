import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';

import 'dynamic_size.dart';

Widget inputTextField(context, label, myController, inputType,
    {function,
    function2,
    password = false,
    auth = true,
    inputAction = "",
    submitFunction = ""}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (function == "") ? () {} : function,
    controller: myController,
    textInputAction: inputAction == "" ? TextInputAction.next : inputAction,
    keyboardType: inputType,
    obscureText: password == true ? obscureText : false,
    cursorColor: myGreen,
    cursorWidth: 2.0,
    onFieldSubmitted: submitFunction == "" ? () {} : submitFunction,
    cursorHeight: dynamicHeight(context, .034),
    style: TextStyle(
      color: auth == true ? myWhite : myGreen,
    ),
    decoration: InputDecoration(
      prefixText: label == "Mobile Number" ? "+92 " : "",
      prefixStyle: TextStyle(
        color: auth == true ? myWhite : myGreen,
      ),
      suffixIcon: password == false
          ? null
          : InkWell(
              onTap: function2 == "" ? () {} : function2,
              child: const Icon(
                Icons.remove_red_eye_rounded,
                color: myGreen,
              ),
            ),
      contentPadding: EdgeInsets.symmetric(
        vertical: dynamicHeight(context, .02),
        horizontal: dynamicWidth(context, .03),
      ),
      labelText: label,
      labelStyle: TextStyle(
        color: myGreen,
        fontSize: dynamicWidth(context, .04),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: myYellow),
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: myGreen),
        borderRadius: BorderRadius.all(
          Radius.circular(
            dynamicWidth(context, .6),
          ),
        ),
      ),
    ),
  );
}
