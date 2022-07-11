import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/components/providers/dark_theme_provider.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/pages/main/category_page.dart';
import 'package:lazyclub/pages/main/favor_page.dart';
import 'package:lazyclub/pages/main/main_page.dart';

import 'package:lazyclub/pages/main/my_study.dart';
import 'package:lazyclub/pages/main/new_study.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  static const routeName = '/App';
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List pages = [
    MainPage(),
    CategoriesPage(),
    FavorPage(),
    MyStudiesList(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(IconlyLight.editSquare),
          backgroundColor: bluishClr,
          onPressed: () {
            GlobalMethods.navigateTo(
                context: context, routeName: UploadStudyPage.routeName);
          }),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        selectedItemColor: bluishClr,
        elevation: 0,
        unselectedItemColor: subTextClr,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white.withOpacity(0.9),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                  currentIndex == 0 ? IconlyBold.user3 : IconlyLight.user3),
              label: '스터디'),
          BottomNavigationBarItem(
              icon: Icon(currentIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: '카테고리'),
          BottomNavigationBarItem(
              icon: Icon(
                  currentIndex == 2 ? IconlyBold.heart : IconlyLight.heart),
              label: '즐겨찾기'),
          BottomNavigationBarItem(
              icon: Icon(currentIndex == 3
                  ? IconlyBold.moreCircle
                  : IconlyLight.moreCircle),
              label: '관리'),
        ],
      ),
    );
  }
}
