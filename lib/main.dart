import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/providers/multi_providers.dart';
import 'package:smart_agri/start_up/choice.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/utils/local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotificationsService.instance.initialize();
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
    0xff02b171,
    <int, Color>{
      50: Color(0xff02b171),
      100: Color(0xff02b171),
      200: Color(0xff02b171),
      300: Color(0xff02b171),
      400: Color(0xff02b171),
      500: Color(0xff02b171),
      600: Color(0xff02b171),
      700: Color(0xff02b171),
      800: Color(0xff02b171),
      900: Color(0xff02b171),
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
          primarySwatch: primaryColor,
          fontFamily: 'Zen Kurenaido',
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        home: const Choice(),
      ),
    );
  }
}
