import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';

import 'dynamic_size.dart';

Widget balanceBox(context, title, amount, color) {
  return Container(
    height: dynamicHeight(context, .12),
    width: dynamicWidth(context, .4),
    decoration: BoxDecoration(
      color: myWhite,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .03),
      ),
      boxShadow: [
        BoxShadow(
          color: myBlack.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 6,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: myBlack,
                fontSize: dynamicWidth(context, .054),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rs. $amount",
              style: TextStyle(
                color: color,
                fontSize: dynamicWidth(context, .048),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget dailyUpdateCard(context, title, date, price, unit) {
  return Stack(
    children: [
      Center(
        child: Container(
          height: dynamicHeight(context, .12),
          width: dynamicWidth(context, .8),
          decoration: BoxDecoration(
            color: greenLite,
            borderRadius: BorderRadius.circular(
              dynamicWidth(context, .03),
            ),
            boxShadow: [
              BoxShadow(
                color: myBlack.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .004),
            horizontal: dynamicWidth(context, .04),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(
                      color: myBlack,
                      fontSize: dynamicWidth(context, .052),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    date ?? "",
                    style: TextStyle(
                      color: myBlack,
                      fontSize: dynamicWidth(context, .042),
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Rs. $price / $unit",
                    style: TextStyle(
                      color: myBlack,
                      fontSize: dynamicWidth(context, .046),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, .14),
        width: dynamicWidth(context, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Image(
              image: AssetImage("assets/leaf.png"),
            ),
          ],
        ),
      ),
    ],
  );
}
