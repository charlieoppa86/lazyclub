import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/theme/dark_theme_provider.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/components/providers/theme/text.dart';
import 'package:lazyclub/pages/inner/each_cat.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.catText,
    required this.imgPath,
  }) : super(key: key);

  final String catText, imgPath;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EachCategotyPage.routeName,
            arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
            color: headTextClr.withOpacity(0.03),
            borderRadius: BorderRadius.circular(20)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: _screenWidth * 0.25,
            height: _screenWidth * 0.25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 15,
          ),
          TextWidget(
            text: catText,
            color: headTextClr,
            textSize: 18,
            isTitle: true,
          )
        ]),
      ),
    );
  }
}
