import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/favor_btn.dart';
import 'package:lazyclub/utils/currency.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/DetailPage';

  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _favoriteCountController = TextEditingController(text: '1');
  late Size size;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = Utils(context).getScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final studyId = ModalRoute.of(context)!.settings.arguments as String;
    final studyGroupsProviders = Provider.of<StudyGroupsProvider>(context);
    final getStudiesNow = studyGroupsProviders.findStudyById(studyId);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInFavor =
        favorProvider.getFavorStudies.containsKey(getStudiesNow.id);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Icon(
              IconlyLight.arrowLeft2,
              color: lightBgClr,
              size: 24,
            ),
          ),
          backgroundColor: Colors.white.withAlpha(0),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.share),
                color: lightBgClr,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 헤더 이미지
              SizedBox(
                child: FancyShimmerImage(
                  imageUrl: getStudiesNow.studyThumbnail,
                  boxFit: BoxFit.fill,
                  width: size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getStudiesNow.studyName,
                              style: TextStyle(
                                  fontSize: 24,
                                  letterSpacing: -1,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: bluishClr),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    child: Text(
                                      getStudiesNow.studyFormat,
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: -1,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.location,
                                      size: 18,
                                    ),
                                    Text(
                                      getStudiesNow.studyLocation,
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                FavorBTN(
                                  studyId: studyId,
                                  isInFavor: _isInFavor,
                                  isInDetail: true,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _line(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            getStudiesNow.studyMinDesc,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            getStudiesNow.studyFormat,
                            style: TextStyle(
                                fontSize: 15,
                                color: headTextClr.withOpacity(0.4),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            getStudiesNow.studyMaxDesc,
                            style: TextStyle(fontSize: 16, height: 1.3),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    _line(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '스터디 리더',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: size.width,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: yelloishClr,
                                        radius: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        getStudiesNow.studyLeaderName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                headTextClr.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    getStudiesNow.studyLeaderInfo,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: headTextClr.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                    ),
                    _line(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '스터디 평가',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '56',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: headTextClr.withOpacity(0.6)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '댓글',
                            style: TextStyle(
                                fontSize: 16,
                                color: headTextClr.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _line(),
                  ],
                ),
              ),
              // 스터디 요약
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 100,
          width: size.width,
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FavorBTN(
                  studyId: studyId,
                  isInFavor: _isInFavor,
                  isInDetail: false,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: 1,
              height: 40,
              color: Colors.grey.withOpacity(0.3),
            ),
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      DataUtils.calcStringToWon(
                          getStudiesNow.studyPrice.toString()),
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: -1,
                          color: headTextClr,
                          fontWeight: FontWeight.bold)),
                  Text(
                    '1회 참가비',
                    style: TextStyle(
                        fontSize: 12, color: headTextClr.withOpacity(0.7)),
                  )
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final User? user = authInstance.currentUser;
                  if (user == null) {
                    GlobalMethods.loginDialog(context: context);
                    return;
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bluishClr,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Center(
                    child: Text(
                      '신청하기',
                      style: TextStyle(
                          color: lightBgClr,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  Widget _line() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: 1,
        color: Colors.black.withOpacity(0.12),
      ),
    );
  }
}
