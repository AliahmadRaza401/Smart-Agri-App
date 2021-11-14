import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';

import 'dynamic_size.dart';

Widget rowText(context, text1, page, text2) {
  return Padding(
    padding: EdgeInsets.only(
      top: dynamicHeight(context, .04),
      bottom: dynamicHeight(context, .01),
      right: dynamicWidth(context, .04),
      left: dynamicWidth(context, .04),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: dynamicWidth(context, .056),
            color: myGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          onTap: () {
            AppRoutes.push(
              context,
              page,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(
              dynamicWidth(context, .02),
            ),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: dynamicWidth(context, .04),
                color: myLiteGreen,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget noDataError(context, image, page, imageSize) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(
          image,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, .02),
      ),
      InkWell(
        onTap: () {
          AppRoutes.push(context, page);
        },
        child: Text(
          "Nothing To Show!!\nTap to Add",
          style: TextStyle(
            color: myGreen,
            fontSize: dynamicWidth(context, .046),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget farmerRecordCard(context, entry, bold, textColor,
    {debit = "", credit = "", heading}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, .004),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: dynamicHeight(context, .08),
          width: dynamicWidth(context, .44),
          child: Center(
            child: Text(
              entry,
              style: TextStyle(
                color: myBlack,
                fontSize: heading == true
                    ? dynamicWidth(context, .048)
                    : dynamicWidth(context, .042),
                fontWeight: bold,
              ),
            ),
          ),
        ),
        Container(
          height: dynamicHeight(context, .08),
          width: dynamicWidth(context, .22),
          color: heading == true ? noColor : greenLite,
          child: Center(
            child: Text(
              heading == true ? credit : "Rs. $credit",
              style: TextStyle(
                color: myGreen,
                fontSize: heading == true
                    ? dynamicWidth(context, .048)
                    : dynamicWidth(context, .042),
                fontWeight: bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: dynamicHeight(context, .08),
          width: dynamicWidth(context, .22),
          child: Center(
            child: Text(
              heading == true ? debit : "Rs. $debit",
              style: TextStyle(
                color: myRed,
                fontSize: heading == true
                    ? dynamicWidth(context, .048)
                    : dynamicWidth(context, .042),
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
