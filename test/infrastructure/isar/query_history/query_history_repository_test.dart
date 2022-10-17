// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history.dart';
import 'package:github_search/domain/repositories/query_history/query_history_repository.dart';
import 'package:github_search/infrastructure/isar/query_history/query_history_repository.dart';

import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  late QueryHistoryRepository repository;
  setUp(() async {
    await agent.setUp();
    repository = agent.mockContainer().read(isarQueryHistoryRepositoryProvider);
  });
  tearDown(agent.tearDown);

  group('isarProvider', () {
    test('DIする前はUnimplementedErrorがthrowされるはず', () async {
      expect(
        () => ProviderContainer().read(isarProvider),
        throwsUnimplementedError,
      );
    });
  });
  group('IsarQueryHistoryRepository', () {
    test('add(): 正常に登録できるはず', () async {
      final input = QueryHistory.create('flutter');
      await repository.add(input);
      final queris = await repository.finds(queryString: '');
      expect(queris.length, 1);
      expect(queris.first.queryString.value, 'flutter');
    });
    test('delete(): 正常に削除できるはず', () async {
      // 1件登録する
      final input = QueryHistory.create('flutter');
      await repository.add(input);

      // 全件取得する
      var queris = await repository.finds(queryString: '');

      // 全件（1件）取得できるはず
      expect(queris.length, 1);

      // 削除する
      await repository.delete(queris.first);

      // 全件取得する
      queris = await repository.finds(queryString: '');

      // 削除したので0件のはず
      expect(queris.length, 0);
    });
    test('delete(): 同じ文言はすべて削除するはず', () async {
      // 同じ文言で2件登録する
      for (var i = 0; i < 2; i++) {
        final input = QueryHistory.create('flutter');
        await repository.add(input);
      }

      // 全件取得する
      var queris = await repository.finds(queryString: '');

      // 文言の重複を排除するので1件取得できるはず
      expect(queris.length, 1);

      // 削除する
      await repository.delete(queris.first);

      // 全件取得する
      queris = await repository.finds(queryString: '');

      // 全件削除したので0件のはず
      expect(queris.length, 0);
    });
    test('finds(): 先頭の文字があっていれば検索できるはず', () async {
      final input = QueryHistory.create('flutter');
      await repository.add(input);

      // 先頭の文字があっているので1件取得できるはず
      var queris = await repository.finds(queryString: 'f');
      expect(queris.length, 1);
      // 先頭の文字があっていないので1件取得できるはず
      queris = await repository.finds(queryString: 'a');
      expect(queris.length, 0);
    });
    test('finds(): 大文字小文字を区別しないはず', () async {
      final input = QueryHistory.create('flutter');
      await repository.add(input);

      // 大文字小文字を区別しないので1件取得できるはず
      final queris = await repository.finds(queryString: 'FlU');
      expect(queris.length, 1);
    });
    test('finds(): 検索日時の降順になっているはず', () async {
      for (var i = 0; i < 10; i++) {
        final input = QueryHistory.create('flutter_$i');
        await repository.add(input);
      }

      // 検索日時の降順になっているはず
      final queris = await repository.finds(queryString: '');
      expect(queris.length, 10);
      for (var i = 0; i < 10; i++) {
        expect(queris[i].queryString.value, 'flutter_${9 - i}');
      }
    });
    test('finds(): 最大20件まで検索できるはず', () async {
      for (var i = 0; i < 21; i++) {
        final input = QueryHistory.create('flutter_$i');
        await repository.add(input);
      }

      // 最大20件まで検索できるはず
      final queris = await repository.finds(queryString: '');
      expect(queris.length, 20);
    });
  });
}
