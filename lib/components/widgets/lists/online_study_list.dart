import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/pages/inner/add_studies_model.dart';

class OnlineStudiesWidget extends StatefulWidget {
  static const routeName = '/OnlineStudiesWidget';
  OnlineStudiesWidget({Key? key}) : super(key: key);

  @override
  State<OnlineStudiesWidget> createState() => _OnlineStudiesWidgetListState();
}

class _OnlineStudiesWidgetListState extends State<OnlineStudiesWidget> {
  final Stream<QuerySnapshot> _studiesStream = FirebaseFirestore.instance
      .collection('studies')
      .where('studyFormat', isEqualTo: '온라인')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return StreamBuilder<QuerySnapshot>(
      stream: _studiesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('데이터 연동에 문제가 있습니다');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: headTextClr.withOpacity(0.1), width: 1)),
            ),
            height: size.height * 0.15,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return AddStudiesModel(studies: snapshot.data!.docs[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 1,
                    color: headTextClr.withOpacity(0.1),
                  );
                },
                itemCount: snapshot.data!.docs.length),
          ),
        );
      },
    );
  }
}
