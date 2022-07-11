import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/studies_model.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/back_btn.dart';
import 'package:lazyclub/components/widgets/lists/popular_list.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:provider/provider.dart';

class AllPopularListPage extends StatefulWidget {
  static const routeName = "/AllPopularListPage";
  const AllPopularListPage({super.key});

  @override
  State<AllPopularListPage> createState() => _AllPopularListPageState();
}

class _AllPopularListPageState extends State<AllPopularListPage> {
  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final studyGroupsProviders = Provider.of<StudyGroupsProvider>(context);
    List<StudyGroupModel> popularStudies =
        studyGroupsProviders.getPopularStudies;
    return Scaffold(
        appBar: AppBar(
            title: Text(
              '인기 스터디',
              style: TextStyle(
                  color: headTextClr,
                  letterSpacing: -1,
                  fontWeight: FontWeight.bold),
            ),
            leading: BackBtn()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: size.width / (size.height * 0.18),
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    children: List.generate(popularStudies.length - 1, (index) {
                      return ChangeNotifierProvider.value(
                        value: popularStudies[index + 1],
                        child: PopularStudyWidget(),
                      );
                    })),
              ],
            ),
          ),
        ));
  }
}
