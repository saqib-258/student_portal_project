import 'dart:io';

import 'package:flutter/cupertino.dart';

class FinancialAssistanceProvider with ChangeNotifier {
  List<File> images = [];

  void addImage(File f) {
    images.add(f);
    notifyListeners();
  }

  void clearImages() {
    images.clear();
    notifyListeners();
  }
}
