import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/assets/assets.gen.dart';
import '../../../utils/extensions.dart';
import '../../../utils/logger.dart';

/// エラーView
///
/// エラーを画面上に表示する
class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    required this.error,
    this.stackTrace,
  }) : super(key: key);

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    logger.e('An error has occurred.', error, stackTrace);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.lottie.error,
            width: 200,
          ),
          const SizedBox(height: 8),
          Text(
            error.toErrorMessage(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
