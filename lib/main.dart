import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/providers/multi_providers.dart';
import 'package:smart_agri/start_up/choice.dart';
import 'package:smart_agri/utils/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: myGreen,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final MaterialColor primaryColor = const MaterialColor(
    0xff02b875,
    <int, Color>{
      50: Color(0xff02b875),
      100: Color(0xff02b875),
      200: Color(0xff02b875),
      300: Color(0xff02b875),
      400: Color(0xff02b875),
      500: Color(0xff02b875),
      600: Color(0xff02b875),
      700: Color(0xff02b875),
      800: Color(0xff02b875),
      900: Color(0xff02b875),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: primaryColor,
          fontFamily: 'Georgia',
        ),
        home: const Choice(),
      ),
    );
  }
}
