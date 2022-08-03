import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/custom_btn.dart';
import 'package:validators/validators.dart';
import 'package:lazyclub/pages/auth/loading_manager.dart';
import 'package:lazyclub/pages/auth/login_page.dart';
import 'package:lazyclub/pages/auth/pw_forget.dart';
import 'package:lazyclub/pages/auth/splash_screen.dart';

class EmailRegisterPage extends StatefulWidget {
  static const routeName = '/EmailRegisterPage';
  const EmailRegisterPage({super.key});

  @override
  State<EmailRegisterPage> createState() => _EmailRegisterPageState();
}

class _EmailRegisterPageState extends State<EmailRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _passCheckFocusNode = FocusNode();
  bool _obscureText = true;
  bool _isLoading = false;

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
    _passCheckFocusNode.dispose();
    super.dispose();
  }

  void submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
      _autovalidateMode = AutovalidateMode.always;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
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
                      autovalidateMode: _autovalidateMode,
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
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return '이름(닉네임)을 입력해주세요';
                                }
                                if (value.trim().length < 2) {
                                  return '이름(닉네임)을 다시 확인해 주세요';
                                }
                                return null;
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
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return '이메일을 입력해주세요';
                                }
                                if (!isEmail(value.trim())) {
                                  return '유효한 이메일이 아닙니다';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                  labelText: "이메일",
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
                              textInputAction: TextInputAction.next,
                              obscureText: _obscureText,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passCheckFocusNode),
                              controller: passTextController,
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return '비밀번호를 입력해주세요';
                                }
                                if (value.trim().length < 6) {
                                  return '패스워드가 너무 짧습니다';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                  labelText: "비밀번호 (6자 이상)",
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
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _passCheckFocusNode,
                              textInputAction: TextInputAction.done,
                              obscureText: _obscureText,
                              onEditingComplete: submitFormOnRegister,
                              validator: (String? value) {
                                if (passTextController.text != value) {
                                  return '비밀번호가 맞지 않습니다';
                                } else {
                                  return null;
                                }
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                  labelText: "비밀번호 확인",
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
                            CustomBTN(
                                title: '회원가입',
                                fontSize: 16,
                                backgroundColor: bluishClr,
                                onPressed: () {
                                  submitFormOnRegister();
                                },
                                fontColor: lightBgClr,
                                borderRadius: 4,
                                letterSpacing: 0),
                            /*              AuthBTN(
                                fct: () {
                                  submitFormOnRegister();
                                },
                                buttontext: '회원가입'), */
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
