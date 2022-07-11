import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/currency.dart';
import 'package:lazyclub/components/widgets/utils.dart';

class MngStudiesModel extends StatefulWidget {
  final dynamic studies;
  const MngStudiesModel({super.key, required this.studies});

  @override
  State<MngStudiesModel> createState() => _MngStudiesModelState();
}

class _MngStudiesModelState extends State<MngStudiesModel> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: FancyShimmerImage(
                imageUrl: widget.studies['studyThumbnail'][0],
                height: size.width * 0.28,
                width: size.width * 0.28,
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
                  widget.studies['studyName'],
                  style: TextStyle(
                      letterSpacing: -1,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.studies['studyMinDesc'],
                  maxLines: 1,
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
                          widget.studies['studySubject'],
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: -1,
                              color: headTextClr,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: bluishClr),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Text(
                          widget.studies['studyFormat'],
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
                Text(
                    DataUtils.calcStringToWon(
                        widget.studies['studyPrice'].toString()),
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
                      widget.studies['studyLocation'],
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
          Spacer(),
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
                                  .doc(widget.studies['id'])
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
        ],
      ),
    );
  }
}
