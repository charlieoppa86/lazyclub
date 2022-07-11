import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/components/providers/dark_theme_provider.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/theme/text.dart';
import 'package:lazyclub/database/firebase_consts.dart';
import 'package:lazyclub/pages/auth/login_page.dart';
import 'package:lazyclub/pages/auth/pw_forget.dart';
import 'package:lazyclub/pages/inner/viewed_recently.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  void _showLoginoutDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return user == null
              ? CupertinoAlertDialog(
                  title: const Text('로그인'),
                  content: const Text('로그인 페이지로 이동할까요?'),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: TextWidget(
                        text: '이동',
                        color: Colors.red,
                        textSize: 18,
                      ),
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: const Text('로그아웃'),
                  content: const Text('정말 로그아웃 하시겠습니까?'),
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
                      onPressed: () async {
                        // 로그인 페이지로 이동

                        await Future.delayed(const Duration(microseconds: 100))
                            .whenComplete(() => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                ));

                        print("유저가 로그아웃했습니다");
                        await authInstance.signOut();
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

  Widget _listTiles({
    required String title,
    required IconData icon,
    required Function onPressed,
  }) {
    return ListTile(
      title: TextWidget(
        color: headTextClr,
        text: title,
        textSize: 18,
        isTitle: true,
      ),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: (() {
        onPressed();
      }),
    );
  }

  String? _email;
  String? _username;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _username = userDoc.get('username');
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
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: headTextClr),
          centerTitle: false,
          title: Text(
            '내 정보',
            style: TextStyle(
                color: headTextClr,
                fontWeight: FontWeight.bold,
                letterSpacing: -1),
          ),
          actions: [],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
          child: Column(
            children: [
              _listTiles(
                title: '계정 관리',
                icon: IconlyLight.profile,
                onPressed: () {},
              ),
              _listTiles(
                title: '최근 본 스터디',
                icon: IconlyLight.show,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: ViewedPage.routeName);
                },
              ),
              _listTiles(
                title: '서비스 이용 안내',
                icon: IconlyLight.document,
                onPressed: () {},
              ),
              _listTiles(
                title: '비밀번호 변경',
                icon: IconlyLight.unlock,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PwForgetPage()));
                },
              ),
              _listTiles(
                title: '고객 센터',
                icon: IconlyLight.chat,
                onPressed: () {},
              ),
              Container(
                width: 350,
                height: 1,
                decoration: BoxDecoration(color: subTextClr.withOpacity(0.1)),
              ),
              SizedBox(
                height: 5,
              ),
              CupertinoButton(
                  onPressed: () {
                    _showLoginoutDialog(context);
                  },
                  child: user == null
                      ? Text('로그인',
                          style: TextStyle(fontSize: 16, color: bluishClr))
                      : Text(
                          '로그아웃',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ))
            ],
          ),
        ));
  }
}
