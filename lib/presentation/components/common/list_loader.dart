import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// ListView用の読み込み中ローダー
class ListLoader extends StatelessWidget {
  const ListLoader({
    super.key,
    this.avatarSize = 56,
  });

  /// leading に表示するダミーアバターのサイズ
  final double avatarSize;

  /// アイテムの数
  static const itemCount = 20;

  /// ダミー行の高さ
  static const boneHeight = 14.0;

  /// ダミー行の数
  static const boneItemCount = 4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: const Duration(milliseconds: 2000),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (_, __) => _LoaderListTile(
            avatarSize: avatarSize,
          ),
          separatorBuilder: (context, _) => const Divider(
            color: Colors.white,
          ),
          itemCount: itemCount,
        ),
      ),
    );
  }
}

class _LoaderListTile extends StatelessWidget {
  const _LoaderListTile({
    required this.avatarSize,
  });

  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: avatarSize / 2,
        backgroundColor: Colors.white,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < ListLoader.boneItemCount - 1; i++)
            const LoaderBone(
              width: double.infinity,
              height: ListLoader.boneHeight,
            ),
          const LoaderBone(
            width: 64,
            height: ListLoader.boneHeight,
          ),
        ],
      ),
    );
  }
}

@visibleForTesting
class LoaderBone extends StatelessWidget {
  const LoaderBone({
    super.key,
    this.width,
    this.height,
  });

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
