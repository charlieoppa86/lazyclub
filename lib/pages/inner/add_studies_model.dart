import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/components/providers/studies_model.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/favor_btn.dart';
import 'package:lazyclub/components/widgets/currency.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:provider/provider.dart';

class AddStudiesModel extends StatefulWidget {
  final dynamic studies;
  const AddStudiesModel({super.key, required this.studies});

  @override
  State<AddStudiesModel> createState() => _AddStudiesModelState();
}

class _AddStudiesModelState extends State<AddStudiesModel> {
  final _favoriteCountController = TextEditingController(text: '');
  bool isMyFavorite = false;
  int favoriteItemCount = 0;

  @override
  void initState() {
    isMyFavorite = false;
    super.initState();
  }

  @override
  void dispose() {
    _favoriteCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final studyGroupModel = Provider.of<StudyGroupModel>(context);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInFavor =
        favorProvider.getFavorStudies.containsKey(studyGroupModel.id);
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: FancyShimmerImage(
                imageUrl: widget.studies['studyThumbnail'][0],
                height: size.width * 0.28,
                width: size.width * 0.28,
                boxFit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.studies['studyName'],
                  style: TextStyle(
                      letterSpacing: -1,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.studies['studyMinDesc'],
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 13,
                      letterSpacing: -1,
                      color: headTextClr.withOpacity(0.7)),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: yelloishClr),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Text(
                          widget.studies['studySubject'],
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: -1,
                              color: headTextClr,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: bluishClr),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Text(
                          widget.studies['studyFormat'],
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: -1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                    DataUtils.calcStringToWon(
                        widget.studies['studyPrice'].toString()),
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: -1,
                      color: headTextClr,
                    )),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.location,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      widget.studies['studyLocation'],
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FavorBTN(
                studyId: studyGroupModel.id,
                isInFavor: _isInFavor,
                isInDetail: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
