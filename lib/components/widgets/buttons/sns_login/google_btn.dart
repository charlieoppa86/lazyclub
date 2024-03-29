import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/constants/db_constants.dart';

class GoogleBTN extends StatelessWidget {
  const GoogleBTN({super.key});

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          await Future.delayed(const Duration(microseconds: 100)).whenComplete(
              () => Navigator.pushNamedAndRemoveUntil(
                  context, '/App', (route) => false));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('로그인에 성공했습니다')));
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              content: '${error.message}', context: context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$error')));
        } catch (error) {
          GlobalMethods.errorDialog(content: '$error', context: context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$error')));
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(235, 235, 235, 1),
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: SizedBox(
          height: 50,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/google_logo.png',
                  height: 45,
                ),
                Text(
                  '구글 아이디로 로그인',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                Opacity(
                  opacity: 0,
                  child: Image.asset(
                    'assets/google_logo.png',
                    height: 45,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
