
import 'package:flutter/material.dart';


class AuthProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  bool loading = false;


  void isLoading(value) {
    loading = value;
    notifyListeners();
  }


}
