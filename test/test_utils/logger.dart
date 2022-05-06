// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:roggle/roggle.dart';

final testLogger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: '[TEST]',
    colors: false,
  ),
);
