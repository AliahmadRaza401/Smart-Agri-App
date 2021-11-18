import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';
import 'package:smart_agri/widgets/form_fields.dart';

class SearchPage extends StatefulWidget {
  final String searchType;

  const SearchPage({Key? key, required this.searchType}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();

  final searchQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(
            color: myWhite,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: myWhite,
        ),
      ),
      body: Container(
        width: dynamicWidth(context, 1),
        height: dynamicHeight(context, 1),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dynamicHeight(context, .02),
              ),
              child: SizedBox(
                width: dynamicWidth(context, .9),
                child: inputTextField(
                    context, "Search", searchQuery, TextInputType.name),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
