import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/widgets/lists/favor_list.dart';
import 'package:lazyclub/components/widgets/profile.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/pages/inner/empty/empty_favor.dart';
import 'package:lazyclub/pages/main/my_page.dart';
import 'package:provider/provider.dart';

class FavorPage extends StatefulWidget {
  static const routeName = "/FavorPage";
  FavorPage({super.key});
  final User? user = authInstance.currentUser;

  @override
  State<FavorPage> createState() => _FavorPageState();
}

class _FavorPageState extends State<FavorPage> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final favorProvider = Provider.of<FavorProvider>(context);
    final favorStudyList =
        favorProvider.getFavorStudies.values.toList().reversed.toList();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: favorStudyList.isEmpty
                  ? EmptyFavorWidget()
                  : ListView.builder(
                      itemCount: favorStudyList.length,
                      itemBuilder: ((context, index) {
                        return ChangeNotifierProvider.value(
                            value: favorStudyList[index],
                            child: FavorListWidget());
                      })),
            )
          ],
        ),
      ),
    );
  }
}
