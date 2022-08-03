import 'package:flutter/material.dart';
import 'package:lazyclub/pages/main/my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '홈',
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyPage();
                }));
              },
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        body: Center(
          child: Text(
            'home',
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: '즐겨찾기'),
              BottomNavigationBarItem(icon: Icon(Icons.camera), label: '카메라'),
            ]),
      ),
    );
  }
}
