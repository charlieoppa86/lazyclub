import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/manage_model.dart';

class ManageProvider with ChangeNotifier {
  final Map<String, ManageModel> _manageStudies = {};
  Map<String, ManageModel> get getManageStudies {
    return _manageStudies;
  }

  void addRemoveStudyToManage({required String studyId}) {
    if (_manageStudies.containsKey(studyId)) {
      _manageStudies.remove(studyId);
    } else {
      _manageStudies.putIfAbsent(
          studyId,
          () => ManageModel(
                id: DateTime.now().toString(),
                studyId: studyId,
              ));
    }
    notifyListeners();
  }

  void removeOneItem(String studyId) {
    _manageStudies.remove(studyId);
    notifyListeners();
  }

  void clearManageList() {
    _manageStudies.clear();
    notifyListeners();
  }
}
