import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/signup/sign_up_provider.dart';
import 'package:lazyclub/components/providers/signup/sign_up_state.dart';
import 'package:lazyclub/models/custom_error_model.dart';
import 'package:lazyclub/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _email, _password;
  final _passwordController = TextEditingController();

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    print('이름 : $_name, 이메일 : $_email, 비밀번호 : $_password');

    try {
      await context.read<SignUpProvider>().signup(
            name: _name!,
            email: _email!,
            password: _password!,
          );
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = context.watch<SignUpProvider>().state;
    return GestureDetector(
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
              reverse: true,
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
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: '이름(닉네임)',
                      prefixIcon: Icon(Icons.account_box)),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '이름(닉네임)을 입력해주세요';
                    }
                    if (value.trim().length < 2) {
                      return '이름(닉네임)을 다시 확인해 주세요';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 20,
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
                  controller: _passwordController,
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
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: '비밀번호 확인',
                      prefixIcon: Icon(Icons.lock)),
                  validator: (String? value) {
                    if (_passwordController.text != value) {
                      return '비밀번호가 맞지 않습니다';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: signUpState.signUpStatus == SignUpStatus.submitting
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
                      signUpState.signUpStatus == SignUpStatus.submitting
                          ? '등록 중'
                          : '회원가입'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      signUpState.signUpStatus == SignUpStatus.submitting
                          ? null
                          : Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline)),
                    child: Text(
                      '이미 회원이신가요?',
                    )),
              ].reversed.toList(),
            ),
          ),
        )),
      ),
    );
  }
}
