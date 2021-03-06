import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/widgets/buttons/auth_btn.dart';
import 'package:lazyclub/components/widgets/buttons/sns_login/apple_btn.dart';
import 'package:lazyclub/components/widgets/buttons/sns_login/google_btn.dart';
import 'package:lazyclub/components/widgets/utils.dart';
import 'package:lazyclub/database/consts.dart';
import 'package:lazyclub/database/firebase_consts.dart';
import 'package:lazyclub/pages/auth/email_register_page.dart';
import 'package:lazyclub/pages/auth/loading_manager.dart';
import 'package:lazyclub/pages/auth/pw_forget.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        await Future.delayed(const Duration(microseconds: 100)).whenComplete(
            () => Navigator.pushNamedAndRemoveUntil(
                context, '/App', (route) => false));

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('???????????? ??????????????????')));
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            content: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
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
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              duration: 1000,
              autoplayDelay: 4000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Splash.splashImages[index],
                  fit: BoxFit.cover,
                );
              },
              itemCount: Splash.splashImages.length,
              pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.black,
                  )),
              autoplay: true,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Column(children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return '????????? ????????? ?????? ????????????';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                              labelText: "???????????? ???????????????",
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: '?????????',
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
                          height: 15,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            submitFormOnLogin();
                          },
                          controller: passwordController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return '???????????? ????????? ?????????, ?????? ?????????!';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                              labelText: "??????????????? ???????????????",
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
                              hintText: '????????????',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              )),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AuthBTN(buttontext: '?????????', fct: submitFormOnLogin),
                    SizedBox(
                      height: 10,
                    ),
                    GoogleBTN(),
                    SizedBox(
                      height: 10,
                    ),
                    AppleBTN(),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            GlobalMethods.navigateTo(
                                context: context,
                                routeName: PwForgetPage.routeName);
                          },
                          child: Text(
                            '??????????????? ????????????????',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '??????',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*  AuthBTN(
                      buttontext: '????????? ????????????',
                      fct: () {
                        FirebaseAuth.instance.signInAnonymously();
                        Navigator.pushReplacementNamed(context, App.routeName);
                      },
                      primaryColor: yelloishClr,
                    ),
                    SizedBox(
                      height: 20,
                    ), */
                    Text(
                      '????????? ?????? ????????????????',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthBTN(
                      fct: () {
                        GlobalMethods.navigateTo(
                            context: context,
                            routeName: EmailRegisterPage.routeName);
                      },
                      buttontext: '????????????',
                      primaryColor: bluishClr,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
