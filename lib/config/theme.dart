// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/assets/fonts.gen.dart';

/// テーマProvider
final themeProvider = Provider<ThemeData>(
  (ref) => ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: FontFamily.murecho,
  ),
);
