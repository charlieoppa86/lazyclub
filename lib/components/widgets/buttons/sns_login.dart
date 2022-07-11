import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lazyclub/app.dart';
import 'package:lazyclub/components/providers/global_methods.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/database/firebase_consts.dart';

class SNSLoginWidget extends StatelessWidget {
  const SNSLoginWidget({super.key});

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
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => App()));
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              content: '${error.message}', context: context);
        } catch (error) {
          GlobalMethods.errorDialog(content: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: headTextClr.withOpacity(0.7),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(2, 1), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/kakao_logo.png'))),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: headTextClr.withOpacity(0.7),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(2, 1), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/naver_logo.png'))),
          ),
        ),
        GestureDetector(
          onTap: () {
            _googleSignIn(context);
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: headTextClr.withOpacity(0.7),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(2, 1), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/google_logo.png'))),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: headTextClr.withOpacity(0.7),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(2, 1), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/apple_logo.png'))),
          ),
        ),
      ],
    );
  }
}
