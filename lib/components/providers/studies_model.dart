import 'package:flutter/material.dart';

class StudyGroupModel with ChangeNotifier {
  final String id,
      cid,
      imgUrl,
      name,
      category,
      leader,
      leaderInfo,
      location,
      minDesc,
      maxDesc,
      price;

  final bool isPopular, isOffline;

  StudyGroupModel(
      {required this.id,
      required this.cid,
      required this.imgUrl,
      required this.name,
      required this.category,
      required this.leader,
      required this.leaderInfo,
      required this.location,
      required this.minDesc,
      required this.maxDesc,
      required this.price,
      required this.isPopular,
      required this.isOffline});
}
