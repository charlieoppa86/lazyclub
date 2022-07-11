import 'package:flutter/material.dart';

class NaverBTN extends StatelessWidget {
  const NaverBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFEE500),
      child: InkWell(
        onTap: () async {},
        child: Image.asset(
          'assets/kakao_icon.png',
          width: 50,
        ),
      ),
    );
  }
}
