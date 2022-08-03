import 'package:flutter/material.dart';
import 'package:lazyclub/app.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:provider/provider.dart';

class FetchMainStudies extends StatefulWidget {
  const FetchMainStudies({super.key});

  @override
  State<FetchMainStudies> createState() => _FetchMainStudiesState();
}

class _FetchMainStudiesState extends State<FetchMainStudies> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final studyGroupsProvider =
          Provider.of<StudyGroupsProvider>(context, listen: false);
      await studyGroupsProvider.fetchStudies();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const App()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
