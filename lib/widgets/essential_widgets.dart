// ignore_for_file: prefer_const_constructors

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
            fontSize: dynamicWidth(context, .043),
            color: myBlack,
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
                color: myGreen,
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
            fontSize: dynamicWidth(context, .042),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget farmerRecordCard(context, entry, bold, textColor,
    {debit = "", credit = "", heading}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: myWhite,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .41),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entry,
                      style: TextStyle(
                        color: myBlack,
                        fontSize: heading == true
                            ? dynamicWidth(context, .042)
                            : dynamicWidth(context, .040),
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .25),
              color: heading == true ? noColor : greenLite,
              child: Center(
                child: Text(
                  heading == true ? credit : "Rs. $credit",
                  style: TextStyle(
                    color: myGreen,
                    fontSize: heading == true
                        ? dynamicWidth(context, .042)
                        : dynamicWidth(context, .040),
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
                        ? dynamicWidth(context, .042)
                        : dynamicWidth(context, .040),
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
