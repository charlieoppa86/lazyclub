import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:provider/provider.dart';

class FavorBTN extends StatefulWidget {
  const FavorBTN({
    super.key,
    required this.studyId,
    this.isInFavor = false,
    required this.isInDetail,
  });
  final String studyId;
  final bool? isInFavor;
  final bool isInDetail;

  @override
  State<FavorBTN> createState() => _FavorBTNState();
}

class _FavorBTNState extends State<FavorBTN> {
  bool isMyFavorite = false;
  int favoriteItemCount = 1;

  @override
  void initState() {
    isMyFavorite = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favorProvider = Provider.of<FavorProvider>(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          final User? user = authInstance.currentUser;
          if (user == null) {
            GlobalMethods.loginDialog(context: context);
            return;
          } else {
            if (isMyFavorite) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('즐겨찾기를 삭제됐습니다')));
              favoriteItemCount -= 1;
              isMyFavorite = false;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('즐겨찾기에 추가됐습니다')));
              favoriteItemCount += 1;
              isMyFavorite = true;
            }
            favorProvider.addRemoveStudyToFavor(studyId: widget.studyId);
          }
        });
      },
      child: Column(
        children: [
          Icon(
            widget.isInFavor != null && widget.isInFavor == true
                ? IconlyBold.heart
                : IconlyLight.heart,
            color: widget.isInFavor != null && widget.isInFavor == true
                ? Colors.red
                : Colors.white,
            size: 22,
          ),
          Visibility(
              visible: widget.isInDetail ? true : false,
              child: Text(favoriteItemCount.toString()))
        ],
      ),
    );
  }
}
