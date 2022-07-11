import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/favor_model.dart';

class FavorProvider with ChangeNotifier {
  Map<String, FavorModel> _favorStudies = {};
  Map<String, FavorModel> get getFavorStudies {
    return _favorStudies;
  }

  void addRemoveStudyToFavor({required String studyId}) {
    if (_favorStudies.containsKey(studyId)) {
      _favorStudies.remove(studyId);
    } else {
      _favorStudies.putIfAbsent(
          studyId,
          () => FavorModel(
                id: DateTime.now().toString(),
                studyId: studyId,
              ));
    }
    notifyListeners();
  }

  void removeOneItem(String studyId) {
    _favorStudies.remove(studyId);
    notifyListeners();
  }

  void clearFavorList() {
    _favorStudies.clear();
    notifyListeners();
  }
}
