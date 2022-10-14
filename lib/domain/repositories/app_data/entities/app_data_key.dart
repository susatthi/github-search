import '../../repo/entities/search_repos_order.dart';
import '../../repo/entities/search_repos_sort.dart';

/// アプリデータのキー名
enum AppDataKey {
  /// リポジトリ検索用ソート値
  searchReposSort,

  /// リポジトリ検索用オーダー値
  searchReposOrder,
  ;

  /// デフォルト値を返す
  Object? get defaultValue {
    switch (this) {
      case searchReposSort:
        return SearchReposSort.bestMatch;
      case searchReposOrder:
        return SearchReposOrder.desc;
    }
  }
}