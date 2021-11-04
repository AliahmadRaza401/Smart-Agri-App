import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/utils/app_route.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class DailyUpdates extends StatefulWidget {
  const DailyUpdates({Key? key}) : super(key: key);

  @override
  _DailyUpdatesState createState() => _DailyUpdatesState();
}

class _DailyUpdatesState extends State<DailyUpdates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Updates",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // AppRoutes.push(context, const FarmerForm());
        },
        backgroundColor: myGreen,
        elevation: 4.0,
        label: AutoSizeText(
          'New Update',
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
    );
  }
}
