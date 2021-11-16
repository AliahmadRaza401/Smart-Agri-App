import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/add_amount_dialog.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

class FarmerDetails extends StatefulWidget {
  final String userName;
  final farmerId;

  const FarmerDetails(
      {Key? key, required this.userName, required this.farmerId})
      : super(key: key);

  @override
  _FarmerDetailsState createState() => _FarmerDetailsState();
}

class _FarmerDetailsState extends State<FarmerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: AppBar(
        backgroundColor: myGreen,
        title: Text(
          widget.userName.toString(),
          style: const TextStyle(
            color: myWhite,
          ),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, .04),
              ),
              child: const Icon(
                Icons.call,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, .04),
              ),
              child: const Icon(
                Icons.more_vert_rounded,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: dynamicWidth(context, 1),
            height: dynamicHeight(context, .12),
            decoration: BoxDecoration(
              color: myGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  dynamicWidth(context, .06),
                ),
                bottomRight: Radius.circular(
                  dynamicWidth(context, .06),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Text(
                        "First name and last name",
                        style: TextStyle(
                          color: myWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: dynamicWidth(context, .05),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Text(
                        "CNIC Number",
                        style: TextStyle(
                          color: myWhite,
                          fontWeight: FontWeight.w400,
                          fontSize: dynamicWidth(context, .046),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: dynamicHeight(context, .02),
          ),
          Flexible(
            child: SizedBox(
              width: dynamicWidth(context, .9),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Net Balance",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .048),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Rs. 78000",
                        style: TextStyle(
                          color: myBlack,
                          fontSize: dynamicWidth(context, .048),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  farmerRecordCard(
                    context,
                    "Entries",
                    FontWeight.w600,
                    myBlack,
                    debit: "Sent",
                    credit: "Received",
                    heading: true,
                  ),
                  Flexible(
                    child: SizedBox(
                      width: dynamicWidth(context, 1),
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return farmerRecordCard(
                            context,
                            "Entries",
                            FontWeight.normal,
                            myBlack,
                            debit: "4,500",
                            credit: "3,000",
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: dynamicHeight(context, .02),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              redButton(
                context,
                "You Gave Rs.",
                () {
                  showDialog(
                    context: context,
                    builder: (context) => AddAmount(
                      farmerId: widget.farmerId,
                       balanceType: 'credit',
                    ),
                  );
                },
                width: dynamicWidth(context, .36),
                fontSize: dynamicWidth(context, .042),
              ),
              button(
                context,
                "You Got Rs.",
                () {
                  showDialog(
                    context: context,
                    builder: (context) => AddAmount(
                      farmerId: widget.farmerId,
                       balanceType: 'dabit',
                    ),
                  );
                },
                width: dynamicWidth(context, .36),
                fontSize: dynamicWidth(context, .042),
                color: myWhite,
                btnColor: myGreen,
              ),
            ],
          ),
          SizedBox(
            height: dynamicHeight(context, .01),
          ),
        ],
      ),
    );
  }
}
