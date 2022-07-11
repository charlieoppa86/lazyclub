import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/providers/viewed_provider.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/pages/inner/empty/empty_viewed.dart';
import 'package:lazyclub/pages/inner/viewed_list.dart';
import 'package:provider/provider.dart';

class ViewedPage extends StatefulWidget {
  static const routeName = "/ViewedPage";
  const ViewedPage({super.key});

  @override
  State<ViewedPage> createState() => _ViewedPageState();
}

class _ViewedPageState extends State<ViewedPage> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedStudyList =
        viewedProvider.getViewedStudies.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: headTextClr),
          title: Text(
            '최근 스터디',
            style: TextStyle(
                color: headTextClr,
                fontWeight: FontWeight.bold,
                letterSpacing: -1),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                child: Text('모두 삭제'),
                onPressed: () {
                  GlobalMethods.showDeleteDialog(
                      title: '삭제',
                      content: '모두 삭제하시겠습니까?',
                      fct: () {
                        viewedProvider.clearViewedList();
                      },
                      context: context);
                },
              ),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
        child: viewedStudyList.isEmpty
            ? EmptyViewedWidget()
            : ListView.builder(
                itemCount: viewedStudyList.length,
                itemBuilder: ((context, index) {
                  return ChangeNotifierProvider.value(
                      value: viewedStudyList[index], child: ViewedListWidget());
                })),
      ),
    );
  }
}
