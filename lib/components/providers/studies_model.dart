import 'package:flutter/material.dart';

class StudyGroupModel with ChangeNotifier {
  StudyGroupModel({
    required this.id,
    required this.uid,
    required this.studyThumbnail,
    required this.studyName,
    required this.studyFormat,
    required this.studyLeaderName,
    required this.studyLeaderInfo,
    required this.studyLocation,
    required this.studyMinDesc,
    required this.studyMaxDesc,
    required this.studyPrice,
    required this.studyApplyLink,
    required this.studySubject,
    // required this.isPopular,
  });

  final String id,
      uid,
      studyName,
      studyFormat,
      studyLeaderName,
      studyLeaderInfo,
      studyLocation,
      studyMinDesc,
      studyThumbnail,
      studySubject,
      studyMaxDesc,
      studyApplyLink;

  // final bool isPopular;
  final int studyPrice;
}
