import 'package:flutter/material.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/category.dart';
import 'package:lazyclub/components/widgets/profile.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/pages/main/my_page.dart';

class CategoriesPage extends StatefulWidget {
  static const routeName = "/CategoriesPage";
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Map<String, dynamic>> catInfo = [
    {"imgPath": "assets/money.png", "catText": "재테크"},
    {"imgPath": "assets/newbiz.png", "catText": "창업"},
    {"imgPath": "assets/skills.png", "catText": "직무"},
    {"imgPath": "assets/routine.png", "catText": "습관형성"},
    {"imgPath": "assets/habits.png", "catText": "취미"},
    {"imgPath": "assets/etc.png", "catText": "기타"},
  ];

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '카테고리',
            style: TextStyle(
                fontSize: 24, letterSpacing: -2, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(catInfo.length, (index) {
                return CategoriesWidget(
                  catText: catInfo[index]['catText'],
                  imgPath: catInfo[index]['imgPath'],
                );
              }),
            ),
          ),
        ]),
      ),
    );
  }
}
