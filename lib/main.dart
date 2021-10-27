import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/providers/multi_providers.dart';
import 'package:smart_agri/trader_screens/choice.dart';
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
    0xff60ce80,
    <int, Color>{
      50: Color(0xff60ce80),
      100: Color(0xff60ce80),
      200: Color(0xff60ce80),
      300: Color(0xff60ce80),
      400: Color(0xff60ce80),
      500: Color(0xff60ce80),
      600: Color(0xff60ce80),
      700: Color(0xff60ce80),
      800: Color(0xff60ce80),
      900: Color(0xff60ce80),
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
