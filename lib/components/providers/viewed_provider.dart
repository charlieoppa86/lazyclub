import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedModel> _viewedStudies = {};
  Map<String, ViewedModel> get getViewedStudies {
    return _viewedStudies;
  }

  void addStudyToHistory({required String studyId}) {
    _viewedStudies.putIfAbsent(
        studyId,
        () => ViewedModel(
              id: DateTime.now().toString(),
              studyId: studyId,
            ));

    notifyListeners();
  }

  void removeOneItem(String studyId) {
    _viewedStudies.remove(studyId);
    notifyListeners();
  }

  void clearViewedList() {
    _viewedStudies.clear();
    notifyListeners();
  }
}
