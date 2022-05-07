import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

/// ListView用の読み込み中ローダー
class ListLoader extends StatelessWidget {
  const ListLoader({
    Key? key,
    this.iconSize = 56,
    this.items = 1,
    this.boneHeight = 14,
    this.boneItemCount = 2,
  })  : assert(boneItemCount >= 2),
        super(key: key);

  /// leading に表示するダミーアイコンのサイズ
  final double iconSize;

  /// アイテムの数
  final int items;

  /// ダミー行の高さ
  final double boneHeight;

  /// ダミー行の数
  final int boneItemCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SkeletonLoader(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        items: items,
        builder: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: iconSize / 2,
                backgroundColor: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < boneItemCount - 1; i++)
                    _Bone(
                      width: double.infinity,
                      height: boneHeight,
                    ),
                  _Bone(
                    width: 64,
                    height: boneHeight,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        width: width,
        height: height,
        child: const ColoredBox(
          color: Colors.white,
        ),
      ),
    );
  }
}
