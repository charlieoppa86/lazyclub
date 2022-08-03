import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/theme/text.dart';
import 'package:lazyclub/pages/auth/login_page.dart';

class GlobalMethods {
  static navigateTo(
      {required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> loginDialog({
    required BuildContext context,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('로그인이 필요해요☺️'),
              content: Text('로그인 페이지로 이동합니다👌'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '취소',
                    color: Colors.blue,
                    textSize: 18,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  child: TextWidget(
                    text: '확인',
                    color: Colors.red,
                    textSize: 18,
                  ),
                ),
              ],
            );
          });
    } else {
      await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('로그인이 필요해요☺️'),
              content: Text('로그인 페이지로 이동합니다👌'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '취소',
                    color: Colors.blue,
                    textSize: 18,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  child: TextWidget(
                    text: '확인',
                    color: Colors.red,
                    textSize: 18,
                  ),
                ),
              ],
            );
          });
    }
  }

  static Future<void> showDeleteDialog({
    required String title,
    required String content,
    required Function fct,
    required BuildContext context,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '취소',
                    color: Colors.blue,
                    textSize: 18,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '확인',
                    color: Colors.red,
                    textSize: 18,
                  ),
                ),
              ],
            );
          });
    } else {
      await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '취소',
                    color: Colors.blue,
                    textSize: 18,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '확인',
                    color: Colors.red,
                    textSize: 18,
                  ),
                ),
              ],
            );
          });
    }
  }

  static Future<void> warningDialog({
    required String title,
    required String content,
    required Function fct,
    required BuildContext context,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '취소',
                    color: Colors.blue,
                    textSize: 18,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    fct();
                  },
                  child: TextWidget(
                    text: '확인',
                    color: Colors.red,
                    textSize: 18,
                  ),
                ),
              ],
            );
          });
    } else {
      await showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    text: '취소',
                    color: Colors.blue,
                    textSize: 18,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    fct();
                  },
                  child: TextWidget(
                    text: '확인',
                    color: Colors.red,
                    textSize: 18,
                  ),
                ),
              ],
            );
          });
    }
  }

  static Future<void> errorDialog({
    required String content,
    required BuildContext context,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('문제가 발생했어요!\n아래 에러 메시지를 참고해 주세요'),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: '확인',
                  color: Colors.blue,
                  textSize: 18,
                ),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('문제가 발생했어요!\n아래 에러 메시지를 참고해 주세요'),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: '확인',
                  color: Colors.blue,
                  textSize: 18,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
