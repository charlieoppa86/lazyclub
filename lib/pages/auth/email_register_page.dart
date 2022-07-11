import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/app.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/widgets/buttons/auth_btn.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/database/consts.dart';
import 'package:lazyclub/database/firebase_consts.dart';
import 'package:lazyclub/pages/auth/loading_manager.dart';
import 'package:lazyclub/pages/auth/login_page.dart';
import 'package:lazyclub/pages/auth/pw_forget.dart';

class EmailRegisterPage extends StatefulWidget {
  static const routeName = '/EmailRegisterPage';
  const EmailRegisterPage({super.key});

  @override
  State<EmailRegisterPage> createState() => _EmailRegisterPageState();
}

class _EmailRegisterPageState extends State<EmailRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  bool _obscureText = true;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailTextController.dispose();
    passTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.createUserWithEmailAndPassword(
            email: emailTextController.text.toLowerCase().trim(),
            password: passTextController.text.trim());
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'username': fullNameController.text,
          'email': emailTextController.text.toLowerCase(),
          'userFavor': [],
          'userStudy': [],
          'createdAt': Timestamp.now(),
        });
        Navigator.pushNamedAndRemoveUntil(context, '/App', (route) => false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('회원가입에 성공했습니다')));
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            content: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = Utils(context).color;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              duration: 1000,
              autoplayDelay: 2000,
              itemCount: Splash.splashImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Splash.splashImages[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/logo_white.png',
                      width: 200,
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              controller: fullNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '이름을 입력해주세요';
                                } else {
                                  return null;
                                }
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                  labelText: "이름(닉네임)",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: "이름(닉네임)",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              focusNode: _emailFocusNode,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              controller: emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '이메일을 입력해주세요';
                                } else if (value.isValidEmail() == false) {
                                  return '이메일 양식이 어딘가 이상해요';
                                } else if (value.isValidEmail() == true) {
                                  return null;
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                  labelText: "이메일을 입력하세요",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: '이메일',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _passFocusNode,
                              textInputAction: TextInputAction.done,
                              obscureText: _obscureText,
                              onEditingComplete: submitFormOnRegister,
                              controller: passTextController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return '비밀번호 입력이 없거나, 너무 짧네요!';
                                } else {
                                  return null;
                                }
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                  labelText: "비밀번호를 입력하세요",
                                  labelStyle: TextStyle(color: Colors.white),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: _obscureText
                                          ? Icon(IconlyLight.hide)
                                          : Icon(IconlyLight.show)),
                                  hintText: '비밀번호',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    GlobalMethods.navigateTo(
                                        context: context,
                                        routeName: PwForgetPage.routeName);
                                  },
                                  child: Text(
                                    '비밀번호를 잊으셨어요?',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AuthBTN(
                                fct: () {
                                  submitFormOnRegister();
                                },
                                buttontext: '회원가입'),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '이미 가입하셨었나요?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, LoginPage.routeName);
                                    },
                                    child: Text(
                                      '로그인하러 이동',
                                      style: TextStyle(
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
