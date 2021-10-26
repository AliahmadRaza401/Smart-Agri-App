import 'package:provider/provider.dart';
import 'package:smart_agri/trader_screens/authentication/auth_provider.dart';

final multiProviders = [
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
    lazy: true,
  ),
];
