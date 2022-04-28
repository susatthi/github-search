// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/utils/logger.dart';
import 'package:logger/logger.dart';

final testLogger = Logger(
  printer: SinglePrettyPrinter(
    loggerName: '[TEST]',
    colors: false,
  ),
);
