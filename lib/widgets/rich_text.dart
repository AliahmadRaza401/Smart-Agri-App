import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget richTextWidget(
    context, text1, text2, size1, size2, page, color1, color2, push) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text1,
          style: TextStyle(
            fontSize: size1,
            color: color1,
          ),
        ),
        page == ""
            ? TextSpan(
                text: text2,
                style: TextStyle(
                  fontSize: size2,
                  color: color2,
                  fontWeight: FontWeight.bold,
                ),
              )
            : TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => push == true
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => page,
                          ),
                        )
                      : Navigator.pop(context),
                text: text2,
                style: TextStyle(
                  fontSize: size2,
                  color: color2,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    ),
  );
}
