/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/icon_adaptive_foreground.png
  AssetGenImage get iconAdaptiveForeground =>
      const AssetGenImage('assets/images/icon_adaptive_foreground.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// File path: assets/images/splash_android_12.png
  AssetGenImage get splashAndroid12 =>
      const AssetGenImage('assets/images/splash_android_12.png');

  /// File path: assets/images/splash_android_12_dark.png
  AssetGenImage get splashAndroid12Dark =>
      const AssetGenImage('assets/images/splash_android_12_dark.png');

  /// File path: assets/images/splash_dark.png
  AssetGenImage get splashDark =>
      const AssetGenImage('assets/images/splash_dark.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        icon,
        iconAdaptiveForeground,
        splash,
        splashAndroid12,
        splashAndroid12Dark,
        splashDark
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/cool-octovat.json
  String get coolOctovat => 'assets/lottie/cool-octovat.json';

  /// File path: assets/lottie/dashboard-zippeo.json
  String get dashboardZippeo => 'assets/lottie/dashboard-zippeo.json';

  /// File path: assets/lottie/empty-state.json
  String get emptyState => 'assets/lottie/empty-state.json';

  /// File path: assets/lottie/error.json
  String get error => 'assets/lottie/error.json';

  /// File path: assets/lottie/github-dark-mode.json
  String get githubDarkMode => 'assets/lottie/github-dark-mode.json';

  /// File path: assets/lottie/github-logo.json
  String get githubLogo => 'assets/lottie/github-logo.json';

  /// File path: assets/lottie/loading-indicator.json
  String get loadingIndicator => 'assets/lottie/loading-indicator.json';

  /// File path: assets/lottie/octocat.json
  String get octocat => 'assets/lottie/octocat.json';

  /// List of all assets
  List<String> get values => [
        coolOctovat,
        dashboardZippeo,
        emptyState,
        error,
        githubDarkMode,
        githubLogo,
        loadingIndicator,
        octocat
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
