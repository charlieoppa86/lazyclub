import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/signin/sign_in_provider.dart';
import 'package:lazyclub/components/providers/signin/sign_in_state.dart';
import 'package:lazyclub/models/custom_error_model.dart';
import 'package:lazyclub/pages/auth/sign_up_page.dart';
import 'package:lazyclub/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const String routeName = '/signin';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    try {
      await context.read<SignInProvider>().signin(
            email: _email!,
            password: _password!,
          );
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SignInProvider>().state;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Image.asset(
                    'assets/logo_black.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: '이메일',
                        prefixIcon: Icon(Icons.email)),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      if (!isEmail(value.trim())) {
                        return '유효한 이메일이 아닙니다';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: '비밀번호',
                        prefixIcon: Icon(Icons.lock)),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return '비밀번호를 입력해주세요';
                      }
                      if (value.trim().length < 6) {
                        return '패스워드가 너무 짧습니다';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed:
                        signInState.signInStatus == SignInStatus.submitting
                            ? null
                            : _submit,
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(18),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    child: Text(
                        signInState.signInStatus == SignInStatus.submitting
                            ? '연결 중'
                            : '로그인'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        signInState.signInStatus == SignInStatus.submitting
                            ? null
                            : Navigator.pushNamed(
                                context, SignUpPage.routeName);
                      },
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline)),
                      child: Text(
                        '아직 회원이 아니시라면?',
                      )),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
