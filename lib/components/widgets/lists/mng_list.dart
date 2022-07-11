import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/currency.dart';
import 'package:lazyclub/components/widgets/utils.dart';

class ManageListWidget extends StatefulWidget {
  const ManageListWidget({super.key, required this.id});

  final String id;

  @override
  State<ManageListWidget> createState() => _ManageListWidgetState();
}

class _ManageListWidgetState extends State<ManageListWidget> {
  bool _isLoading = false;

  String studyName = '';
  String? studyThumbnail;
  String studyMinDesc = '';
  String studyLocation = '';
  int studyPrice = 0;
  String studySubject = '';
  String studyFormat = '';

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final DocumentSnapshot studiesDoc = await FirebaseFirestore.instance
          .collection('studies')
          .doc(widget.id)
          .get();
      if (studiesDoc == null) {
        return;
      } else {
        studyName = studiesDoc.get('studyName');
        studyThumbnail = studiesDoc.get('studyThumbnail').toString();
        studyMinDesc = studiesDoc.get('studyMinDesc');
        studyLocation = studiesDoc.get('studyLocation');
        studyPrice = studiesDoc.get('studyPrice');
        studySubject = studiesDoc.get('studySubject');
        studyFormat = studiesDoc.get('studyFormat');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(content: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    /* final manageProvider = Provider.of<ManageProvider>(context);
    final studyGroupProvider = Provider.of<StudyGroupsProvider>(context);
    final manageModel = Provider.of<ManageModel>(context);
    final getCurrStudy = studyGroupProvider.findStudyById(manageModel.studyId); */
    return GestureDetector(
      onTap: () {
        /*  GlobalMethods.navigateTo(
            context: context, routeName: DetailPage.routeName); */
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: FancyShimmerImage(
                    imageUrl: studyThumbnail!,
                    height: size.width * 0.25,
                    width: size.width * 0.25,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studyName,
                      style: TextStyle(
                          letterSpacing: -1,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      studyMinDesc,
                      style: TextStyle(
                          fontSize: 13,
                          letterSpacing: -1,
                          color: headTextClr.withOpacity(0.7)),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: yelloishClr),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: Text(
                              studySubject,
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: -1,
                                  color: headTextClr,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: bluishClr),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: Text(
                              studyFormat,
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: -1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(DataUtils.calcStringToWon(studyPrice.toString()),
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: -1,
                          color: headTextClr,
                        )),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          size: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          studyLocation,
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton(
              color: Colors.white,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {},
                      child: Text('수정'),
                      value: 1,
                    ),
                    PopupMenuItem(
                      onTap: () {
                        GlobalMethods.showDeleteDialog(
                            title: '스터디 삭제',
                            content: '정말 삭제하시겠습니까?',
                            fct: () async {
                              await FirebaseFirestore.instance
                                  .collection('studies')
                                  .doc(widget.id)
                                  .delete();
                              await Fluttertoast.showToast(
                                  msg: '스터디가 성공적으로 삭제되었습니다.',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1);
                            },
                            context: context);
                      },
                      child: Text(
                        '삭제',
                        style: TextStyle(color: Colors.red),
                      ),
                      value: 1,
                    )
                  ]),
        ]),
      ),
    );
  }
}
