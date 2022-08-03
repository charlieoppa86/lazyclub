import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/components/providers/studies_model.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/favor_btn.dart';
import 'package:lazyclub/utils/currency.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/pages/inner/detail_page.dart';
import 'package:provider/provider.dart';

class AllStudyListWidget extends StatefulWidget {
  const AllStudyListWidget({super.key});

  @override
  State<AllStudyListWidget> createState() => _AllStudyListWidgetState();
}

class _AllStudyListWidgetState extends State<AllStudyListWidget> {
  final _favoriteCountController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _favoriteCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final studyGroupModel = Provider.of<StudyGroupModel>(context);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInFavor =
        favorProvider.getFavorStudies.containsKey(studyGroupModel.id);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: studyGroupModel.id);
        /* GlobalMethods.navigateTo(
            context: context, routeName: DetailPage.routeName); */
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: headTextClr.withOpacity(0.1), width: 1)),
        ),
        height: size.height * 0.15,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: FancyShimmerImage(
                  imageUrl: studyGroupModel.studyThumbnail,
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  boxFit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 130,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studyGroupModel.studyName,
                          style: TextStyle(
                              letterSpacing: -1,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          studyGroupModel.studyMinDesc,
                          style: TextStyle(
                              fontSize: 13,
                              letterSpacing: -1,
                              color: headTextClr.withOpacity(0.7)),
                        ),
                        Text(
                            DataUtils.calcStringToWon(
                                studyGroupModel.studyPrice.toString()),
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
                              studyGroupModel.studyFormat,
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
                              size: 14,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              studyGroupModel.studyLocation,
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
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
        ),
      ),
    );
  }
}
