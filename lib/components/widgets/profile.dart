import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({Key? key, required this.imgUrl, this.size = 40})
      : super(key: key);

  final String imgUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        imgUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
