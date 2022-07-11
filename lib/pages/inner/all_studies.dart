import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/components/providers/studies_model.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/back_btn.dart';
import 'package:lazyclub/components/widgets/lists/study_list.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:provider/provider.dart';

class AllStudyListPage extends StatefulWidget {
  static const routeName = "/AllStudyListPage";
  const AllStudyListPage({super.key});

  @override
  State<AllStudyListPage> createState() => _AllStudyListPageState();
}

class _AllStudyListPageState extends State<AllStudyListPage> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final studyGroupsProviders = Provider.of<StudyGroupsProvider>(context);
    List<StudyGroupModel> allStudies = studyGroupsProviders.getStudyGroups;
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
            GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: size.width / (size.height * 0.18),
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                children: List.generate(allStudies.length - 1, (index) {
                  return ChangeNotifierProvider.value(
                    value: allStudies[index + 1],
                    child: AllStudyListWidget(),
                  );
                }))
          ]),
        ),
      ),
    );
  }
}
