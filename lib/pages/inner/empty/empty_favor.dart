import 'package:flutter/material.dart';
import 'package:lazyclub/app.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/theme/text.dart';
import 'package:lazyclub/components/widgets/utils.dart';

class EmptyFavorWidget extends StatelessWidget {
  const EmptyFavorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset('assets/favor_img.png',
              width: double.infinity, height: size.height * 0.4),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            text: '즐겨찾기한 스터디가 없어요!',
            color: color,
            textSize: 26,
            isTitle: true,
          ),
          SizedBox(
            height: 5,
          ),
          TextWidget(text: '관심 스터디에 하트를 눌러 놓으세요!', color: color, textSize: 16),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  primary: bluishClr),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => App()));
              },
              child: TextWidget(
                text: '돌아가기',
                color: Colors.white,
                textSize: 16,
                isTitle: true,
              ))
        ],
      ),
    );
  }
}
