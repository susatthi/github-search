# Github Search

[Github API](https://docs.github.com/ja/rest) を利用して Github のリポジトリを検索するアプリです。[株式会社ゆめみのFlutterエンジニアコードチェック](https://github.com/yumemi-inc/flutter-engineer-codecheck)の要件を満たすよう実装しています。

本アプリを通して自分なりの最適なアーキテクチャを確立することを目的にしています。

## アプリの機能

- 最低限の UI / UX
- 多言語対応（日本語/英語）
- カスタムフォント
- [mockito](https://pub.dev/packages/mockito) を使った Unit / Widget テスト
- [go_router](https://pub.dev/packages/go_router) を使った新しいルーティング
- [http](https://pub.dev/packages/http) を使った REST API の実装
- サポートするプラットフォーム
  - iOS / Android / Web

### 今後対応予定

- アプリアイコン
- スプラッシュ画面
- [hive](https://pub.dev/packages/hive) or [shared_preferences](https://pub.dev/packages/shared_preferences) の利用
- CI / CD
- Integration テスト
- macOS / Windows のサポート
- テーマ対応
- ダークモード対応
- よりよい UI / UX

### 対応しないこと

- Firebase 連携

## アーキテクチャ / パッケージ

[flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + [state_notifier](https://pub.dev/packages/state_notifier) + [freezed](https://pub.dev/packages/freezed) + [go_router](https://pub.dev/packages/go_router)

[CODE WITH ANDREA](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) の下記アーキテクチャを参考にしています。

<img src="https://user-images.githubusercontent.com/13707135/160351645-7acb5ab6-34f9-45a8-9f95-80147af6c408.png" width="30%">

## フォルダ構成
<img src="https://user-images.githubusercontent.com/13707135/159856721-bba39334-18ef-4476-9d1e-14a4932bf810.png" width="60%">

## 環境

|                | Version                          |
|----------------|----------------------------------|
| Xcode          | 13.3                             |
| Android Studio | Bumblebee 2021.1.1 Patch 2       |
| Flutter        | 2.10.3                           |
| Swift          | 5.6                              |
| Kotlin         | 1.6.10                           |
| Chrome         | 99                               |

## 対象 OSバージョン

|        | OS Version    |
|--------|---------------|
|iOS     | 9.0 ~ 15.4    |
|Android | 8.0 ~ 13      |


## ビルド方法

- `lib/src/config/env.default.dart` を `lib/src/config/env.dart` にコピーして、自分にあった内容に書き換える
  - `githubOAuthToken` には [Github 個人アクセストークン](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) を設定してください
- Configurationsを選択してビルドしてください

Configurations名|説明
--|--
app|アプリ（iOS / Android）向け
web|Web 向け

## ライセンス

MIT
