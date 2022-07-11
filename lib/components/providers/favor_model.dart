import 'package:flutter/material.dart';

class FavorModel with ChangeNotifier {
  final String id, studyId;

  FavorModel({required this.id, required this.studyId});
}
