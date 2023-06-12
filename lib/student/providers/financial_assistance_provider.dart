import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:student_portal/student/models/core/financial_assistance_images.dart';

class FinancialAssistanceProvider with ChangeNotifier {
  List<FinancialAssistanceImages> images = [];

  void addImage(File f, String title) {
    images.add(FinancialAssistanceImages(f: f, title: title));
    notifyListeners();
  }

  void clearImages() {
    images.clear();
    notifyListeners();
  }
}
