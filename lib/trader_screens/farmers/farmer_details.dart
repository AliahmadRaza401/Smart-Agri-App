import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:smart_agri/services/firebase_services.dart';
import 'package:smart_agri/trader_screens/farmers/balance_detail_dialog.dart';
import 'package:smart_agri/trader_screens/farmers/update_farmer.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/add_amount_dialog.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/essential_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
  dynamic netBalance = 0.0;
  late DocumentSnapshot snapshot;

  getNetBalance() async {
    await FirebaseFirestore.instance
        .collection("farmers")
        .doc(widget.farmerId)
        .collection("balance")
        .get()
        .then((value) {
      for (var i in value.docs) {
        if (i.data().containsKey("price") == true) {
          setState(() {
            netBalance = netBalance +
                int.parse(i.data()['finalBalance'].toStringAsFixed(0));
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getNetBalance();
  }

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
            onTap: () async {
              var number = widget.mNumber;
              await canLaunch("tel:$number")
                  ? await launch("tel:$number")
                  : throw 'Could not launch $number';
            },
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
                      'Edit',
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
                          docsID: widget.farmerId,
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
                  onPressed: () {
                    FirebaseServices.deleteRecord(
                      context,
                      "farmers",
                      widget.farmerId,
                    );
                    AppRoutes.pop(context);
                  },
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddAmount(
              farmerId: widget.farmerId,
              farmerUserName: widget.userName,
            ),
          );
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Sale',
          style: TextStyle(
            color: myWhite,
            fontSize: dynamicWidth(context, .04),
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
        ),
        icon: const Icon(
          Icons.add,
          color: myWhite,
        ),
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
                        widget.fName + " " + widget.lName,
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
                        widget.fCNIC.toString(),
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
                        netBalance.toString(),
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
                  farmerRecordCardHeading(
                    context,
                  ),
                  Flexible(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("farmers")
                          .doc(widget.farmerId)
                          .collection("balance")
                          .orderBy('timeStamp', descending: true)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Oops! Something went wrong');
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;
                          if (docs.isEmpty) {
                            return const Center(
                              child: Text("Record is empty"),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                print('data: $data');

                                if (data.containsKey("price") == true) {
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: .25,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (BuildContext context) {
                                            var balanceId = docs[i].id;
                                            FirebaseServices.deleteBalance(
                                              context,
                                              widget.farmerId,
                                              balanceId,
                                            );
                                          },
                                          backgroundColor: myRed,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  BalanceDetailDialog(
                                                    itemName: data['name'],
                                                    price: data['price'],
                                                    deduction:
                                                        data['deductions'],
                                                    finalBalance:
                                                        data['finalBalance']
                                                            .toInt(),
                                                    todayPrice:
                                                        data['todayPrice'],
                                                    laberChar:
                                                        data['labourCharges'],
                                                    brokerChar:
                                                        data['brokerCharges'],
                                                    traderChar:
                                                        data['traderCharges'],
                                                    itemWeight:
                                                        data['itemWeight'],
                                                  ));
                                        },
                                        child: farmerRecordCard(
                                          context,
                                          data['name'] ?? "",
                                          data['finalBalance']
                                                  .toStringAsFixed(0) ??
                                              "",
                                          data['date'] ?? "",
                                          data['time'] ?? "",
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: dynamicHeight(context, .02),
          ),
        ],
      ),
    );
  }
}
