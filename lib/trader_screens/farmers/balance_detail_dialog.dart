// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/buttons.dart';

class BalanceDetailDialog extends StatelessWidget {
  final String itemName;
  final String price;
  final double deduction;
  final int finalBalance;
  final String todayPrice;

  const BalanceDetailDialog({
    Key? key,
    required this.itemName,
    required this.price,
    required this.deduction,
    required this.finalBalance,
    required this.todayPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item:  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  itemName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount:  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$price',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rate per 40kg:  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$todayPrice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deduction:  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: myRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  ' Labor Charges  = 1%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: myBlack,
                  ),
                ),
                Text(
                  ' Borker Charges = 0.15%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: myBlack,
                  ),
                ),
                Text(
                  ' Trader Charges = 1.6%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: myBlack,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total = ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: myBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${double.parse((deduction).toStringAsFixed(1))}',
                      // "$deduction",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: myBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Divider(
              height: 10,
              thickness: 3,
              color: Colors.grey[400],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Final Balance:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: myRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$finalBalance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: myBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              thickness: 3,
              color: Colors.grey[400],
            ),
            SizedBox(height: 30),
            Container(
              height: 60,
              child: button(context, "Ok", () {
                Navigator.pop(context);
              }),
            ),
            // NormalButton(
            //   buttonText: "OK",
            //   onTap: () => Navigator.pop(context),
            // )
          ],
        ),
      ),
    );
  }
}
