import 'package:flutter/material.dart';

import '../services/app_shared_pref.dart';

class ExamProvider with ChangeNotifier {
  int questionNo = 1;
  DateTime? currentExamDate;
  DateTime? nextExamDate;
  bool isExamAvailable = false;
  //****************** Exams ********************************* */

  void currentExamAccessDate() {
    DateTime now = DateTime.now();
    currentExamDate =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    nextExamDate =
        DateTime(now.year, now.month, (now.day) + 10, now.hour, now.minute);
    AppSharedPref.setNextExamDate(nextExamDate: nextExamDate!);
    isExamAvailable = false;
    notifyListeners();
  }

  void examAvailable() {
    DateTime now = DateTime.now();
    DateTime currentDate =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    print("Next exam date ${AppSharedPref.getNextExamDate()}");
    if (AppSharedPref.getNextExamDate() != null) {
      DateTime nextDate = DateTime.parse(AppSharedPref.getNextExamDate()!);
      if (currentDate.compareTo(nextDate) >= 0) {
        isExamAvailable = true;
      }
    } else {
      isExamAvailable = true;
    }
  }

  void nextQuestion() {
    if (questionNo <= 10) {
      questionNo++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (questionNo > 1) {
      questionNo--;
      notifyListeners();
    }
  }
}
