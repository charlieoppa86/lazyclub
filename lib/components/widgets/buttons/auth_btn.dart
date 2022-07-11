import 'package:flutter/material.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/components/theme/text.dart';

class AuthBTN extends StatelessWidget {
  const AuthBTN(
      {super.key,
      required this.fct,
      required this.buttontext,
      this.primaryColor = bluishClr});

  final Function fct;
  final String buttontext;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: primaryColor),
            onPressed: () async {
              await fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextWidget(
                color: Colors.white,
                textSize: 16,
                text: buttontext,
              ),
            )),
      ),
    );
  }
}
