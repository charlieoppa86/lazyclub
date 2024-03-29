import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/theme/text.dart';

class AppleBTN extends StatelessWidget {
  const AppleBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 50,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/apple_logo.png',
                  height: 45,
                ),
                Text(
                  '애플 아이디로 로그인',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Opacity(
                  opacity: 0,
                  child: Image.asset(
                    'assets/apple_logo.png',
                    height: 45,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
