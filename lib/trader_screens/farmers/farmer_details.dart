import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:smart_agri/trader_screens/farmers/update_farmer.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/add_amount_dialog.dart';
import 'package:smart_agri/widgets/buttons.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';

class FarmerDetails extends StatefulWidget {
  final String userName, fName, lName, mNumber, fCNIC, password;
  final farmerId;

  const FarmerDetails({
    Key? key,
    required this.userName,
    required this.fName,
    required this.lName,
    required this.mNumber,
    required this.fCNIC,
    required this.password,
    required this.farmerId,
  }) : super(key: key);

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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, .04),
            ),
            child: QudsPopupButton(
              items: [
                QudsPopupMenuItem(
                    leading: const Icon(
                      Icons.edit,
                      color: myGreen,
                    ),
                    title: Text(
                      'Update',
                      style: TextStyle(
                        color: myGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: dynamicWidth(context, .042),
                      ),
                      maxLines: 1,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => UpdateFarmer(
                          userName: widget.userName,
                          fName: widget.fName,
                          lName: widget.lName,
                          mNumber: widget.mNumber,
                          fCNIC: widget.fCNIC,
                          password: widget.password,
                        ),
                      );
                    }),
                QudsPopupMenuDivider(),
                QudsPopupMenuItem(
                  leading: const Icon(
                    Icons.delete,
                    color: myRed,
                  ),
                  title: Text(
                    'Delete',
                    style: TextStyle(
                      color: myRed,
                      fontWeight: FontWeight.w600,
                      fontSize: dynamicWidth(context, .042),
                    ),
                    maxLines: 1,
                  ),
                  onPressed: () {},
                ),
              ],
              child: Icon(
                Icons.more_vert_rounded,
                size: dynamicWidth(context, .08),
                color: myWhite,
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
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (BuildContext context) {},
                                  backgroundColor: myRed,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Center(
                              child: farmerRecordCard(
                                context,
                                "Entries",
                                FontWeight.normal,
                                myBlack,
                                debit: "4,500",
                                credit: "3,000",
                              ),
                            ),
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
