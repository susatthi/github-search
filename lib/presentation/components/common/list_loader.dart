import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// アイテムの数
const _itemCount = 20;

/// ダミー行の高さ
const _boneHeight = 14.0;

/// ダミー行の数
const _boneItemCount = 4;

/// ListView用の読み込み中ローダー
class ListLoader extends StatelessWidget {
  const ListLoader({
    Key? key,
    this.avatarSize = 56,
  }) : super(key: key);

  /// leading に表示するダミーアバターのサイズ
  final double avatarSize;

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
          itemCount: _itemCount,
        ),
      ),
    );
  }
}

class _LoaderListTile extends StatelessWidget {
  const _LoaderListTile({
    Key? key,
    required this.avatarSize,
  }) : super(key: key);

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
          for (var i = 0; i < _boneItemCount - 1; i++)
            const _Bone(
              width: double.infinity,
              height: _boneHeight,
            ),
          const _Bone(
            width: 64,
            height: _boneHeight,
          ),
        ],
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
