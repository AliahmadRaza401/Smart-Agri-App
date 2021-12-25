import 'package:auto_size_text/auto_size_text.dart';
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
                fontSize: dynamicWidth(context, .048),
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

Widget farmerCard(context, userName, number, debit, credit, image) {
  return Center(
    child: Container(
      height: dynamicHeight(context, .16),
      width: dynamicWidth(context, .9),
      decoration: BoxDecoration(
        color: containerBgColor,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: dynamicWidth(context, .26),
                height: dynamicHeight(context, .06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Yet to Give",
                          style: TextStyle(
                            color: myBlack,
                            fontSize: dynamicWidth(context, .044),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs. $debit",
                          style: TextStyle(
                            color: myRed,
                            fontSize: dynamicWidth(context, .04),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: dynamicWidth(context, .085),
                backgroundColor: myGreen,
                child: CircleAvatar(
                  radius: dynamicWidth(context, .08),
                  backgroundColor: containerBgColor,
                  child: image != null
                      ? ClipOval(
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: dynamicWidth(context, 1),
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: dynamicWidth(context, .08),
                          color: myWhite,
                        ),
                ),
              ),
              SizedBox(
                width: dynamicWidth(context, .26),
                height: dynamicHeight(context, .06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: AutoSizeText(
                            "Yet to Receive",
                            style: TextStyle(
                              color: myBlack,
                              fontSize: dynamicWidth(context, .044),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs. $credit",
                          style: TextStyle(
                            color: myGreen,
                            fontSize: dynamicWidth(context, .04),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName.toString(),
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .052),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "+92 " + number.toString(),
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .042),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget dailyUpdateCard(context, title, date, price, unit, category, image) {
  return Container(
    width: dynamicWidth(context, .9),
    height: dynamicHeight(context, .28),
    decoration: BoxDecoration(
      color: containerBgColor,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .06),
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              dynamicWidth(context, .06),
            ),
            topLeft: Radius.circular(
              dynamicWidth(context, .06),
            ),
          ),
          child: SizedBox(
            width: dynamicWidth(context, .9),
            height: dynamicHeight(context, .18),
            child: Image.network(
              image,
              width: dynamicWidth(context, 1),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: dynamicHeight(context, .01),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .06),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toString().toUpperCase(),
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .038),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Rs. $price / $unit",
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .038),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .06),
          ),
          child: Row(
            children: [
              Text(
                category ?? "",
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .038),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .06),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                date ?? "",
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .03),
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(
          height: dynamicHeight(context, .001),
        ),
      ],
    ),
  );
  // return Stack(
  //   children: [
  //     Center(
  //       child: Container(
  //         height: dynamicHeight(context, .12),
  //         width: dynamicWidth(context, .9),
  //         decoration: BoxDecoration(
  //           color: greenLite,
  //           borderRadius: BorderRadius.circular(
  //             dynamicWidth(context, .03),
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: myBlack.withOpacity(0.2),
  //               spreadRadius: 1,
  //               blurRadius: 6,
  //               offset: const Offset(0, 3), // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         padding: EdgeInsets.symmetric(
  //           vertical: dynamicHeight(context, .004),
  //           horizontal: dynamicWidth(context, .04),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Row(
  //               children: [
  //                 Text(
  //                   "$title ~ $category",
  //                   style: TextStyle(
  //                     color: myBlack,
  //                     fontSize: dynamicWidth(context, .052),
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   date ?? "",
  //                   style: TextStyle(
  //                     color: myBlack,
  //                     fontSize: dynamicWidth(context, .042),
  //                     fontWeight: FontWeight.w300,
  //                   ),
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   "Rs. $price / $unit",
  //                   style: TextStyle(
  //                     color: myBlack,
  //                     fontSize: dynamicWidth(context, .046),
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     SizedBox(
  //       height: dynamicHeight(context, .14),
  //       width: dynamicWidth(context, 1),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: const [
  //           Image(
  //             image: AssetImage("assets/leaf.png"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // );
}
