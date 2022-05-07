import 'package:flutter/material.dart';

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
    return Center(
      child: Text(error.toErrorMessage()),
    );
  }
}
