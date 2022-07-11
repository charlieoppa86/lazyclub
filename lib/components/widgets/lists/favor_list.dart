import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/favor_model.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/favor_btn.dart';
import 'package:lazyclub/components/widgets/currency.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/pages/inner/detail_page.dart';
import 'package:provider/provider.dart';

class FavorListWidget extends StatefulWidget {
  const FavorListWidget({super.key});

  @override
  State<FavorListWidget> createState() => _FavorListWidgetState();
}

class _FavorListWidgetState extends State<FavorListWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final favorProvider = Provider.of<FavorProvider>(context);
    final studyGroupProvider = Provider.of<StudyGroupsProvider>(context);
    final favorModel = Provider.of<FavorModel>(context);
    final getCurrStudy = studyGroupProvider.findStudyById(favorModel.studyId);
    bool? _isInFavor =
        favorProvider.getFavorStudies.containsKey(getCurrStudy.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: favorModel.studyId);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: headTextClr.withOpacity(0.1), width: 1)),
        ),
        height: size.height * 0.15,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              SizedBox(
                width: size.width * 0.23,
                height: size.width * 0.23,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: FancyShimmerImage(
                    imageUrl: getCurrStudy.imgUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getCurrStudy.name,
                    style: TextStyle(
                        letterSpacing: -1,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    getCurrStudy.minDesc,
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: -1,
                        color: headTextClr.withOpacity(0.7)),
                  ),
                  Text(DataUtils.calcStringToWon(getCurrStudy.price),
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: -1,
                        color: headTextClr,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: bluishClr),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      child: Text(
                        getCurrStudy.isOffline ? '오프라인' : '온라인',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: -1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location,
                        size: 16,
                      ),
                      Text(
                        getCurrStudy.location,
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FavorBTN(
                studyId: getCurrStudy.id,
                isInFavor: _isInFavor,
                isInDetail: true,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
