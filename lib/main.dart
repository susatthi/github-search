// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/config/app.dart';

void main() {
  runApp(
    ProviderScope(
      child: GithubSearchApp(),
    ),
  );
}
