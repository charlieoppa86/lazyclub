import 'package:flutter/material.dart';
import 'package:lazyclub/components/theme/text.dart';

class KakaoBTN extends StatefulWidget {
  const KakaoBTN({super.key});

  @override
  State<KakaoBTN> createState() => _KakaoBTNState();
}

class _KakaoBTNState extends State<KakaoBTN> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFEE500),
      child: InkWell(
        onTap: () async {},
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            'assets/kakao_icon.png',
            width: 50,
          ),
          SizedBox(
            width: 75,
          ),
          TextWidget(text: '카카오 아이디로 로그인', color: Colors.black87, textSize: 16)
        ]),
      ),
    );
  }
}
