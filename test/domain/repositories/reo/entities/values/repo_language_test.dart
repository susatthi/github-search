// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/repo/entity/value/repo_language.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  group('RepoLanguageHelper', () {
    test('value != null', () async {
      const language = RepoLanguage('Dart');
      expect(language.value, 'Dart');
      expect(language.display, 'Dart');
      expect(language.color.value, HexColor('#00B4AB').value);
    });
    test('value = null', () async {
      const language = RepoLanguage();
      expect(language.value, isNull);
      expect(language.display, '');
      expect(language.color.value, HexColor('#999999').value);
    });
    test('value is unknown', () async {
      const language = RepoLanguage('Unknown');
      expect(language.value, 'Unknown');
      expect(language.display, 'Unknown');
      expect(language.color.value, HexColor('#999999').value);
    });
  });
}
