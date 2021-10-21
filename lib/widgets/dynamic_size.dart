import 'package:flutter/material.dart';

dynamicWidth(BuildContext context, dynamic dynamicSize) {
  return MediaQuery.of(context).size.width * dynamicSize;
}

dynamicHeight(BuildContext context, dynamic dynamicSize) {
  return MediaQuery.of(context).size.height * dynamicSize;
}
