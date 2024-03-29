import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/components/providers/studies_model.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/widgets/lists/study_list.dart';
import 'package:lazyclub/components/widgets/profile.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/pages/inner/all_studies.dart';
import 'package:lazyclub/pages/main/my_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/MainPage';
  MainPage({super.key});
  final User? user = authInstance.currentUser;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = Utils(context).getScreenSize;
    final studyGroupsProviders = Provider.of<StudyGroupsProvider>(context);
    List<StudyGroupModel> allStudies = studyGroupsProviders.getStudyGroups;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: headTextClr),
        centerTitle: false,
        title: Image.asset(
          'assets/logo_black.png',
          fit: BoxFit.cover,
          height: 150,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyPage()));
                },
                child: UserProfileImage(
                  size: 55,
                  imgUrl:
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
                )),
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.25,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    SwiperImg.swiperImages[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: SwiperImg.swiperImages.length,
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.black,
                    )),
                autoplay: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '온라인 스터디 🖥',
                            style: TextStyle(
                                fontSize: 24,
                                letterSpacing: -2,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              GlobalMethods.navigateTo(
                                  context: context,
                                  routeName: AllStudyListPage.routeName);
                            },
                            child: Text('모두 보기',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: bluishClr,
                                    letterSpacing: -1,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ]),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allStudies.length < 2 ? allStudies.length : 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: allStudies[index],
                        child: AllStudyListWidget(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '오프라인 스터디 👩🏻‍💻',
                            style: TextStyle(
                                fontSize: 24,
                                letterSpacing: -2,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              GlobalMethods.navigateTo(
                                  context: context,
                                  routeName: AllStudyListPage.routeName);
                            },
                            child: Text('모두 보기',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: bluishClr,
                                    letterSpacing: -1,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ]),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allStudies.length < 2 ? allStudies.length : 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: allStudies[index],
                        child: AllStudyListWidget(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '모든 스터디 📝',
                            style: TextStyle(
                                fontSize: 24,
                                letterSpacing: -2,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              GlobalMethods.navigateTo(
                                  context: context,
                                  routeName: AllStudyListPage.routeName);
                            },
                            child: Text('모두 보기',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: bluishClr,
                                    letterSpacing: -1,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ]),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allStudies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: allStudies[index],
                        child: AllStudyListWidget(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Splash {
  static List<String> splashImages = [
    'assets/splash1.png',
    'assets/splash2.png',
    'assets/splash3.png',
    'assets/splash4.png',
  ];
}

class SwiperImg {
  static List<String> swiperImages = [
    'assets/swiper1.png',
    'assets/swiper2.png',
  ];
}
