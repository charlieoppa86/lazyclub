import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/pages/inner/add_studies_model.dart';

class OfflineStudiesWidget extends StatefulWidget {
  static const routeName = '/OfflineStudiesList';
  OfflineStudiesWidget({Key? key}) : super(key: key);

  @override
  State<OfflineStudiesWidget> createState() => _OfflineStudiesWidgetListState();
}

class _OfflineStudiesWidgetListState extends State<OfflineStudiesWidget> {
  final Stream<QuerySnapshot> _studiesStream = FirebaseFirestore.instance
      .collection('studies')
      .where('studyFormat', isEqualTo: '오프라인')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
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
