// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/local_notification.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_buttons.dart';
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

Widget noDataError(context, image, page, imageSize, {farmer = false}) {
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
          farmer == false ? AppRoutes.push(context, page) : null;
        },
        child: Text(
          farmer == false
              ? "Nothing To Show!!\nTap to Add"
              : "Nothing To Show!!",
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

Widget farmerRecordCard(context, entry, amount, date, time) {
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
            Container(
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.amber,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          width: dynamicWidth(context, .5),
                          child: Text(
                            entry,
                            style: TextStyle(
                              color: myBlack,
                              fontSize: dynamicWidth(context, .040),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${date}'),
                      ],
                    ),

                    // Text('$time'),
                  ],
                ),
              ),
            ),
            Container(
              // color: Colors.yellow,
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .38),
              child: Row(
                children: [
                  Container(
                    height: dynamicHeight(context, .075),
                    width: dynamicWidth(context, .01),
                    decoration: BoxDecoration(
                      color: greenLite,
                    ),
                  ),
                  Container(
                    height: dynamicHeight(context, .08),
                    width: dynamicWidth(context, .35),
                    alignment: Alignment.center,
                    child: Text(
                      "Rs: $amount",
                      style: TextStyle(
                        color: myBlack,
                        fontSize: dynamicWidth(context, .040),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget farmerRecordCardHeading(
  context,
) {
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
            Container(
              // color: Colors.amber,
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .51),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(
                        color: myBlack,
                        fontSize: dynamicWidth(context, .040),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .38),
              color: greenLite,
              child: Center(
                child: Text(
                  "Total",
                  style: TextStyle(
                    color: myGreen,
                    fontSize: dynamicWidth(context, .042),
                    fontWeight: FontWeight.w600,
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

Widget oopsAlert(context, message) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    content: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'OOPS!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: myRed,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Text(
            message,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.4,
              child: button(
                context,
                "OK",
                () {
                  AppRoutes.pop(context);
                },
                fontSize: MediaQuery.of(context).size.width * 0.045,
              )),
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.06,
          //   width: MediaQuery.of(context).size.width * 0.4,
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          //   child: NormalButton(
          //     buttonText: "OK",
          //     onTap: () => Navigator.pop(context),
          //   ),
          // )
        ],
      ),
    ),
  );
}

Widget farmerRequestCard(
    context, image, farmerName, number, name, category, quantity, unit, status,
    {farmer = "", function1 = "", function2 = ""}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .05),
      vertical: dynamicHeight(context, .01),
    ),
    child: Container(
      width: dynamicWidth(context, .9),
      decoration: BoxDecoration(
        color: containerBgColor,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .04),
        ),
      ),
      padding: EdgeInsets.all(
        dynamicWidth(context, .04),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: dynamicWidth(context, .08),
                backgroundColor: myGreen,
                child: CircleAvatar(
                  radius: dynamicWidth(context, .075),
                  backgroundColor: myWhite,
                  backgroundImage: NetworkImage(
                    image == "" || image == null
                        ? 'https://www.clipartkey.com/mpngs/m/87-871244_this-free-icons-png-design-of-male-avatar.png'
                        : image,
                  ),
                ),
              ),
              SizedBox(
                width: dynamicWidth(context, .46),
                child: Text(
                  farmerName,
                  style: TextStyle(
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: dynamicWidth(context, .04),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  launch("tel: $number");
                },
                icon: Icon(
                  Icons.call,
                  color: myGreen,
                  size: dynamicWidth(context, .08),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item Name : ",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        "Category : ",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        "Quantity/Unit : ",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        quantity + "/" + unit,
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          farmer == true || status.toString() != "Pending"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor(status),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: myWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .035),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(
                      context,
                      "Decline",
                      function2,
                      btnColor: myRed,
                      color: myWhite,
                      height: dynamicHeight(context, .046),
                      width: dynamicWidth(context, .36),
                      fontSize: dynamicWidth(context, .044),
                    ),
                    button(
                      context,
                      "Accept",
                      function1,
                      btnColor: myGreen,
                      color: myWhite,
                      height: dynamicHeight(context, .046),
                      width: dynamicWidth(context, .36),
                      fontSize: dynamicWidth(context, .044),
                    )
                  ],
                ),
        ],
      ),
    ),
  );
}

Widget historyCard(
  context,
  name,
  int price,
  date,
  time,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .05),
      vertical: dynamicHeight(context, .005),
    ),
    child: Container(
      width: dynamicWidth(context, .9),
      decoration: BoxDecoration(
        color: containerBgColor,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .04),
        ),
      ),
      padding: EdgeInsets.all(
        dynamicWidth(context, .04),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.history_rounded,
                color: myGreen,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ",
                      style: TextStyle(
                        color: myBlack,
                        fontSize: dynamicWidth(context, .04),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .006),
                    ),
                    Text(
                      "Price : ",
                      style: TextStyle(
                        color: myBlack,
                        fontSize: dynamicWidth(context, .04),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: myBlack,
                        fontSize: dynamicWidth(context, .04),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .006),
                    ),
                    Text(
                      '$price',
                      style: TextStyle(
                        color: myBlack,
                        fontSize: dynamicWidth(context, .04),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Divider(
              thickness: 0.7,
              color: myGreen,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .04),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .04),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

statusColor(status) {
  if (status == "Accepted") {
    // LocalNotificationsService.instance.showChatNotifcation(
    //   title: "Request Accepted",
    //   body: "Trader accept your request",
    // );
    return myGreen;
  } else if (status == "Declined") {
    // LocalNotificationsService.instance.showChatNotifcation(
    //   title: "Request Declined",
    //   body: "Trader reject your request",
    // );
    return myRed;
  } else {
    return myYellow;
  }
}
