import 'package:flutter/material.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/providers/theme/text.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/pages/main/new_study.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subtitle,
    required this.buttontext,
  });

  final String imgUrl, title, subtitle, buttontext;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imgUrl,
                    width: double.infinity, height: size.height * 0.4),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: title,
                  color: headTextClr,
                  textSize: 26,
                  isTitle: true,
                ),
                SizedBox(
                  height: 5,
                ),
                TextWidget(text: subtitle, color: headTextClr, textSize: 16),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        primary: bluishClr),
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          context: context,
                          routeName: UploadStudyPage.routeName);
                    },
                    child: TextWidget(
                      text: buttontext,
                      color: Colors.white,
                      textSize: 16,
                      isTitle: true,
                    ))
              ]),
        ),
      ),
    );
  }
}
