import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/components/providers/studies_model.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/back_btn.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/pages/inner/all_studies_model.dart';
import 'package:provider/provider.dart';

class AllStudyListPage extends StatefulWidget {
  static const routeName = "/AllStudyListPage";
  const AllStudyListPage({super.key});

  @override
  State<AllStudyListPage> createState() => _AllStudyListPageState();
}

class _AllStudyListPageState extends State<AllStudyListPage> {
  final Stream<QuerySnapshot> _allStudiesStream =
      FirebaseFirestore.instance.collection('studies').snapshots();
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  /*  @override
  void initState() {
    final studyGroupsProvider =
        Provider.of<StudyGroupsProvider>(context, listen: false);
    studyGroupsProvider.fetchStudies();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final studyGroupsProvider = Provider.of<StudyGroupsProvider>(context);
    List<StudyGroupModel> allStudies = studyGroupsProvider.getStudyGroups;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '모든 스터디',
            style: TextStyle(
                color: headTextClr,
                letterSpacing: -1,
                fontWeight: FontWeight.bold),
          ),
          leading: BackBtn()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffix: IconButton(
                      icon: Icon(IconlyLight.closeSquare, color: headTextClr),
                      onPressed: (() {
                        _searchTextController!.clear();
                        _searchTextFocusNode.unfocus();
                      })),
                  hintText: '원하는 스터디를 검색해보세요',
                  prefixIcon: Icon(
                    IconlyLight.search,
                    color: headTextClr.withOpacity(0.6),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: headTextClr, width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: headTextClr, width: 0.5)),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _allStudiesStream,
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
                                color: headTextClr.withOpacity(0.1), width: 1)),
                      ),
                      height: size.height,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return AllStudiesListModel(
                                studies: snapshot.data!.docs[index]);
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
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
