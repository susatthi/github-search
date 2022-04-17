// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
//ignore: depend_on_referenced_packages
import 'package:stack_trace/stack_trace.dart';

final logger = Logger(
  printer: SinglePrettyPrinter(
    loggerName: '[APP]',
    stackTraceLevel: Level.error,
  ),
);

class SinglePrettyPrinter extends LogPrinter {
  SinglePrettyPrinter({
    this.loggerName,
    this.colors = true,
    this.printCaller = true,
    this.printEmojis = true,
    this.printLevels = true,
    this.printTime = true,
    this.stackTraceLevel = Level.nothing,
    this.stackTraceMethodCount = 20,
  });

  /// ロガー名
  final String? loggerName;

  /// 出力するログを色づけするかどうか
  final bool colors;

  /// ログを出力した場所を出力するかどうか
  final bool printCaller;

  /// 絵文字を出力するかどうか
  final bool printEmojis;

  /// ログレベルを出力するかどうか
  final bool printLevels;

  /// 時刻を出力するかどうか
  final bool printTime;

  /// スタックトレースを表示するログレベル
  final Level stackTraceLevel;

  /// 表示するスタックトレースのメソッド数
  final int stackTraceMethodCount;

  /// このファイルのパス
  static final _selfPath = _getSelfPath();

  /// スタックトレースのプレフィックス
  static const _prefixStackTrace = '│';

  /// ログレベル毎のカラー
  static final _levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  /// ログレベル毎の絵文字
  static final _levelEmojis = {
    Level.verbose: '🐱',
    Level.debug: '🐛',
    Level.info: '💡',
    Level.warning: '⚠️',
    Level.error: '⛔',
    Level.wtf: '👾',
  };

  /// ログレベル毎の文字列
  static final _levelLabels = {
    Level.verbose: '[VERBOSE]',
    Level.debug: '[DEBUG]  ',
    Level.info: '[INFO]   ',
    Level.warning: '[WARNING]',
    Level.error: '[ERROR]  ',
    Level.wtf: '[WTF]    ',
  };

  /// iOS/Android 向けのスタックトレース行に一致する正規表現
  /// 例:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex =
      RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  /// Web 向けのスタックトレース行に一致する正規表現
  /// 例:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex =
      RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');

  /// このファイルのパスを返す
  static String _getSelfPath() {
    final match = RegExp(r'^(.+.dart)').firstMatch(Frame.caller(0).toString());
    if (match == null) {
      return '';
    }
    return match.group(1)!;
  }

  @override
  List<String> log(LogEvent event) {
    List<String>? stackTraceLines;
    if (event.stackTrace != null) {
      // stackTrace があれば優先して表示する
      stackTraceLines = _getStackTrace(stackTrace: event.stackTrace);
    } else if (event.level.index >= stackTraceLevel.index) {
      // 致命的エラーの場合は stackTrace を表示する
      stackTraceLines = _getStackTrace();
    }

    return _formatAndPrint(
      level: event.level,
      message: _stringifyMessage(event.message),
      time: printTime ? _getCurrentTime() : null,
      caller: printCaller ? _getCaller() : null,
      error: event.error?.toString(),
      stackTrace: stackTraceLines,
    );
  }

  /// ロガー呼び出し場所を返す
  String? _getCaller() {
    final lines = StackTrace.current.toString().split('\n');
    for (final line in lines) {
      if (_discardDeviceStackTraceLine(line) ||
          _discardWebStackTraceLine(line) ||
          line.isEmpty) {
        continue;
      }
      if (_deviceStackTraceRegex.matchAsPrefix(line) != null) {
        // iOS/Android 向けに余計な部分を除去する
        return line
            .replaceFirst(RegExp(r'#\d+\s+'), '')
            .replaceFirst(RegExp(r'package:[a-z0-9_]+\/'), '/');
      }
      if (_webStackTraceRegex.matchAsPrefix(line) != null) {
        // Web 向けに余計な部分を除去する
        return line.replaceFirst(RegExp(r'^packages\/[a-z0-9_]+\/'), '/');
      }
    }
    return null;
  }

  /// スタックトレースを返す
  List<String> _getStackTrace({
    StackTrace? stackTrace,
  }) {
    final lines = (stackTrace ?? StackTrace.current).toString().split('\n');
    final formatted = <String>[];
    var count = 0;
    for (final line in lines) {
      if (_discardDeviceStackTraceLine(line) ||
          _discardWebStackTraceLine(line) ||
          line.isEmpty) {
        continue;
      }
      final replaced = line.replaceFirst(RegExp(r'#\d+\s+'), '');
      formatted.add(' $_prefixStackTrace #$count   $replaced');
      if (++count == stackTraceMethodCount) {
        break;
      }
    }
    return formatted;
  }

  /// iOS/Android のスタックトレースの場合、無視するかどうかを返す
  bool _discardDeviceStackTraceLine(String line) {
    final match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)!.startsWith('package:logger') ||
        line.contains(_selfPath);
  }

  /// Web のスタックトレースの場合、無視するかどうかを返す
  bool _discardWebStackTraceLine(String line) {
    final match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('packages/logger') ||
        match.group(1)!.startsWith('dart-sdk/lib') ||
        line.startsWith(_selfPath);
  }

  /// 現在時刻を返す
  String _getCurrentTime() {
    return DateFormat('HH:mm:ss.SSS').format(DateTime.now());
  }

  /// ログメッセージを返す
  String _stringifyMessage(dynamic message) {
    if (message is dynamic Function()) {
      return message().toString();
    } else if (message is String) {
      return message;
    }
    return message.toString();
  }

  /// ログレベル毎のカラーを返す
  AnsiColor _getLevelColor(Level level) {
    if (colors) {
      return _levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  /// フォーマットして出力する
  List<String> _formatAndPrint({
    required Level level,
    required String message,
    String? time,
    String? caller,
    String? error,
    List<String>? stackTrace,
  }) {
    final buffer = <String>[];
    final color = _getLevelColor(level);

    if (printEmojis) {
      buffer.add(color(_levelEmojis[level]!));
    }
    if (loggerName != null) {
      buffer.add(color(loggerName!));
    }
    if (printLevels) {
      buffer.add(color(_levelLabels[level]!));
    }
    if (time != null) {
      buffer.add(color(time));
    }
    if (caller != null) {
      buffer.add(color(caller));
    }

    final logs = <String>[];
    if (buffer.isNotEmpty) {
      logs.add('${buffer.join(' ')}${color(':')} ${color(message)}');
    } else {
      logs.add(color(message));
    }

    // エラーがあれば次の行に追記する
    if (error != null) {
      logs.add(color(error));
    }

    // stackTrace があれば次の行に追記する
    if (stackTrace != null && stackTrace.isNotEmpty) {
      for (final line in stackTrace) {
        logs.add(color(line));
      }
    }
    return logs;
  }
}
