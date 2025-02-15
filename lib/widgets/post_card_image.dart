import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/helper.dart';

class PostCardImage extends StatelessWidget {
  final String url;
  const PostCardImage({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: context.height * 0.60,
        maxWidth: context.width * 0.80,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          getS3Url(url),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
