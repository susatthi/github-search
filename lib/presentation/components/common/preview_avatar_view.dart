import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// アバターのプレビューView
class PreviewAvatarView extends StatelessWidget {
  const PreviewAvatarView({
    super.key,
    required this.url,
  });

  /// アバター画像のURL
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
        backgroundDecoration: const BoxDecoration(),
      ),
    );
  }
}
