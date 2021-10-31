import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';

import 'dynamic_size.dart';

Widget inputTextField(context, label, myController, inputType,
    {function, function2, password = false, auth}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (function == "") ? () {} : function,
    controller: myController,
    textInputAction: TextInputAction.next,
    keyboardType: inputType,
    obscureText: password == true ? obscureText : false,
    cursorColor: myGreen,
    cursorWidth: 2.0,
    cursorHeight: dynamicHeight(context, .034),
    style: const TextStyle(
      color: myWhite,
    ),
    decoration: InputDecoration(
      prefixText: label == "Mobile Number" ? "+92 " : "",
      prefixStyle: const TextStyle(
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
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: myGreen),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: myGreen),
      ),
    ),
  );
}
