import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
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

Widget farmerRecordCard(context, entry, bold, textColor,
    {debit = "", credit = "", heading, date, time}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: myWhite,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .41),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Text('${date}' + '$time'),
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
                  heading == true ? credit : "$credit",
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
                  heading == true ? debit : "$debit",
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

Widget farmerRecordCardHeading(
  context,
  entry,
  bold,
  textColor, {
  debit = "",
  credit = "",
  heading,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: myWhite,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: dynamicHeight(context, .08),
              width: dynamicWidth(context, .41),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  heading == true ? credit : "$credit",
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
                  heading == true ? debit : "$debit",
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
          SizedBox(height: 30),
          Text(
            message,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.4,
            child: NormalButton(
              buttonText: "OK",
              onTap: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    ),
  );
}

Widget farmerRequestCard(
    context, image, number, name, category, quantity, unit, status) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .05),
      vertical: dynamicHeight(context, .01),
    ),
    child: Expanded(
      child: Container(
        width: dynamicWidth(context, .9),
        decoration: BoxDecoration(
          color: greenLite,
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
                  backgroundColor: myWhite,
                  backgroundImage: NetworkImage(image),
                ),
                SizedBox(
                  width: dynamicWidth(context, .46),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: myBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: dynamicWidth(context, .04),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launch(number);
                  },
                  icon: Icon(
                    Icons.call,
                    color: myBlack,
                    size: dynamicWidth(context, .08),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Item Name ",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        "Category ",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        "Quantity/Unit ",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "   :   ",
                        style: TextStyle(
                          color: myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        "   :   ",
                        style: TextStyle(
                          color: myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        "   :   ",
                        style: TextStyle(
                          color: myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .046),
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
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .006),
                      ),
                      Text(
                        quantity + "/" + unit,
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(
                  context,
                  "Decline",
                  () {},
                  btnColor: myRed,
                  color: myWhite,
                  height: dynamicHeight(context, .046),
                  width: dynamicWidth(context, .36),
                  fontSize: dynamicWidth(context, .044),
                ),
                button(
                  context,
                  "Accept",
                  () {},
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
    ),
  );
}
