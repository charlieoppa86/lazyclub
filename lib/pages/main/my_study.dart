import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/manage_model.dart';
import 'package:lazyclub/components/providers/manage_provider.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/profile.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/pages/inner/detail_page.dart';
import 'package:lazyclub/pages/inner/mng_studies_model.dart';
import 'package:lazyclub/pages/main/my_page.dart';
import 'package:provider/provider.dart';

class MyStudiesList extends StatefulWidget {
  static const routeName = '/MyStudiesList';
  MyStudiesList({Key? key}) : super(key: key);

  @override
  State<MyStudiesList> createState() => _MyStudiesListState();
}

class _MyStudiesListState extends State<MyStudiesList> {
  final Stream<QuerySnapshot> _myStudiesStream =
      FirebaseFirestore.instance.collection('studies').snapshots();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '스터디 관리',
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: -2,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _myStudiesStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('데이터 전송에 문제가 있습니다');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        /*     Navigator.pushNamed(
                          context,
                          DetailPage.routeName,
                        ); */
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: headTextClr.withOpacity(0.1),
                                  width: 1)),
                        ),
                        height: size.height,
                        child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return MngStudiesModel(
                                  studies: snapshot.data!.docs[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                height: 1,
                                color: headTextClr.withOpacity(0.1),
                              );
                            },
                            itemCount: snapshot.data!.docs.length),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
