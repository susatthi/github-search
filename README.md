<p align="center">
<a href="https://github.com/susatthi/github-search/actions/workflows/flutter_ci.yaml"><img src="https://github.com/susatthi/github-search/actions/workflows/flutter_ci.yaml/badge.svg" alt="Flutter CI"></a>
<a href="https://codecov.io/gh/susatthi/github-search"><img src="https://codecov.io/gh/susatthi/github-search/branch/develop/graph/badge.svg?token=C48OG86U8O" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple" alt="MIT"></a>
<img width="100%" src="https://user-images.githubusercontent.com/13707135/165474118-d7a43467-7e8e-4dc7-9aed-2e1dd1456ea6.png">
</p>

# GitHub Search

[GitHub API](https://docs.github.com/ja/rest) を利用して GitHub のリポジトリを検索するアプリです。[株式会社ゆめみのFlutterエンジニアコードチェック](https://github.com/yumemi-inc/flutter-engineer-codecheck)の要件を満たすよう実装しています。

本アプリを通して自分なりの最適なアーキテクチャを確立し、リファレンスコードにすることを目的にしています。

> **:warning: 注意**  
> このアプリは `GitHub API` を利用するために GitHub の `アクセストークン` をアプリの内部でハードコーディングして保持する構成になっています。このアプリを公開すると悪意のある者に `アクセストークン` を抜き取られ悪用される恐れがありますのでお控え下さい。もちろん、手元でビルドして動かすことは問題ありません。

![github_search_0_9_0_demo](https://user-images.githubusercontent.com/13707135/172117146-22d5f5b2-5e90-4d09-8060-8c1976b2b42a.gif)

## ビルド方法

#### ソースコードを clone
  
```bash
git clone https://github.com/susatthi/github-search.git
```

#### GitHub の個人アクセストークンを取得

本アプリで使用する GitHub の[個人アクセストークン](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)を取得して、カレントディレクトリで次のコマンドを実行してください。

```bash
# 引数で与えられた環境変数を基にビルドに必要な `lib/config/env.dart` を作成してくれます。
# 作成された `lib/config/env.dart` を直接編集しても大丈夫です。

bin/flutter_env -g [GitHub 個人アクセストークン] -s [検索文字列の初期値]
```

|パラメータ                     |          |説明                                                       |
|-----------------------------|----------|----------------------------------------------------------|
|`-g`                         |`Must`    |値には [GitHub 個人アクセストークン](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) を設定してください。|
|`-s`                         |`Optional`|値には好きな文字列を設定してください。指定しない場合は空文字が設定されます。|
|`-h`                         |          |ヘルプを表示します。                                          |

#### ビルド

Configurations を選択してビルドしてください。

|Configurations 名 |説明                       |
|------------------|--------------------------|
|`app-debug`       |アプリ向けデバッグビルド      |
|`app-release`     |アプリ向けリリースビルド      |
|`web-debug`       |Web 向けデバッグビルド       |

## 技術スタック

- アプリの機能
  - GitHub リポジトリの検索と詳細表示
  - 検索結果の並び替えと [hive](https://pub.dev/packages/hive) を使ったデータの永続化
  - Sliver を使った無限スクロール対応
  - [isar](https://isar.dev/) を使った検索履歴の保存とサジェスト
- [go_router](https://pub.dev/packages/go_router) を使ったルーティング
- [http](https://pub.dev/packages/http) を使った REST API の実装
- [fast_i18n](https://pub.dev/packages/fast_i18n) を使った多言語対応（日本語/英語）
- カスタムフォント対応
- [mocktail](https://pub.dev/packages/mocktail) を使った Unit / Widget テスト
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) を使ったアプリアイコン
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) を使ったスプラッシュ画面
- [GitHub Actions](https://github.co.jp/features/actions) によるCI(自動テストと自動ビルド)
- サポートするプラットフォーム
  - iOS / Android / Web / macOS / Windows

### 今後対応予定

- デスクトップ UI
- ダークモード対応
- Golden テスト
- Integration テスト

### 対応しないこと

- Firebase 連携
- Flavor 対応（develop / staging / production などの環境分け）

## アーキテクチャ / パッケージ

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + [state_notifier](https://pub.dev/packages/state_notifier) + [freezed](https://pub.dev/packages/freezed) + [go_router](https://pub.dev/packages/go_router)
- [CODE WITH ANDREA](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) と [DDD](https://little-hands.hatenablog.com/entry/2018/12/10/ddd-architecture) のアーキテクチャを参考にして、本アプリは下記の３層アーキテクチャで実装しています。

![アーキテクチャ図](https://user-images.githubusercontent.com/13707135/172120909-bfd17ff6-f1ca-4b72-ad24-babd5b147188.png)

### プレゼンテーション層

#### Widgets

ページや UI 部品の Widget クラス群。状態を監視して UI に表現する。ユーザーイベントを検知してコントローラーのメソッドを呼び出す。

#### Controllers

Repository Interfaces を呼び出して Entities を受け取って States を更新する。Widgets からのメソッド呼び出しや、依存する States の更新を契機に発火する。ドメイン層に依存するがインフラストラクチャ層には依存してはいけない。

#### States

アプリのあらゆる状態。`Provider` 等でラップされ Widgets に利用される。

### ドメイン層

#### Entities

ユーザーなどの実体。入力値のバリデーションはエンティティで実装しインフラストラクチャ層が呼び出す。どこにも依存しないこと。

#### Repository Interfaces

データの永続化をになうリポジトリ層のインターフェース。どこにも依存しないこと。インフラストラクチャ層が投げる例外はドメイン層で定義する。

### インフラストラクチャ層

#### Repository Implements

Repository Interfaces の実体。Data Sources を利用してデータの永続化を行う。

#### Data Sources

データソース。API だったり、Hive だったり、SharedPreferences だったり、Isar だったりする。

### Riverpod の依存関係図

- [riverpod_graph](https://github.com/rrousselGit/riverpod/tree/master/packages/riverpod_graph) を使って Riverpod の依存関係図を出力してみました。

```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px; 
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px; 
  end

  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end
  _MockPage((_MockPage));
  searchReposQueryStringUpdater -.-> _MockPage;
  searchReposEnteringQueryStringUpdater -.-> _MockPage;
  _GitHubSearchApp((_GitHubSearchApp));
  themeProvider ==> _GitHubSearchApp;
  routerProvider ==> _GitHubSearchApp;
  launchUrlStateProvider --> _GitHubSearchApp;
  HyperlinkText((HyperlinkText));
  launcher -.-> HyperlinkText;
  SearchReposTextButton((SearchReposTextButton));
  searchReposQueryStringUpdater -.-> SearchReposTextButton;
  SliverRepoDetailView((SliverRepoDetailView));
  selectedRepoProvider ==> SliverRepoDetailView;
  _IconLabel((_IconLabel));
  launcher -.-> _IconLabel;
  SearchReposSortSelectorBottomSheet((SearchReposSortSelectorBottomSheet));
  searchReposSortProvider ==> SearchReposSortSelectorBottomSheet;
  searchReposSortUpdater -.-> SearchReposSortSelectorBottomSheet;
  SliverRepoListView((SliverRepoListView));
  repoListViewStateProvider ==> SliverRepoListView;
  _LastIndicator((_LastIndicator));
  repoListViewStateProvider -.-> _LastIndicator;
  AvatarPreviewView((AvatarPreviewView));
  selectedRepoProvider ==> AvatarPreviewView;
  RepoFullNameText((RepoFullNameText));
  selectedRepoProvider ==> RepoFullNameText;
  SearchReposOrderToggleButton((SearchReposOrderToggleButton));
  repoListViewStateProvider ==> SearchReposOrderToggleButton;
  SearchReposOrderToggleButtonInternal((SearchReposOrderToggleButtonInternal));
  searchReposOrderProvider ==> SearchReposOrderToggleButtonInternal;
  searchReposOrderUpdater -.-> SearchReposOrderToggleButtonInternal;
  SliverQueryHistoriesListView((SliverQueryHistoriesListView));
  queryHistoriesProvider ==> SliverQueryHistoriesListView;
  _QueryHistoryListTile((_QueryHistoryListTile));
  queryHistoriesProvider -.-> _QueryHistoryListTile;
  searchReposQueryStringUpdater -.-> _QueryHistoryListTile;
  ReadmeMarkdown((ReadmeMarkdown));
  readmeContentProviderFamily ==> ReadmeMarkdown;
  ReadmeMarkdownInternal((ReadmeMarkdownInternal));
  launcher -.-> ReadmeMarkdownInternal;
  searchReposQueryStringUpdater[[searchReposQueryStringUpdater]];
  searchReposQueryStringProvider ==> searchReposQueryStringUpdater;
  queryHistoryRepositoryProvider ==> searchReposQueryStringUpdater;
  searchReposEnteringQueryStringUpdater[[searchReposEnteringQueryStringUpdater]];
  searchReposEnteringQueryStringProvider ==> searchReposEnteringQueryStringUpdater;
  searchReposEnteringQueryStringProvider -.-> searchReposEnteringQueryStringUpdater;
  launchUrlStateProvider[[launchUrlStateProvider]];
  themeProvider[[themeProvider]];
  routerProvider[[routerProvider]];
  isarQueryHistoryRepositoryProvider[[isarQueryHistoryRepositoryProvider]];
  isarProvider ==> isarQueryHistoryRepositoryProvider;
  isarProvider[[isarProvider]];
  githubHttpClientProvider[[githubHttpClientProvider]];
  githubAccessTokenProvider ==> githubHttpClientProvider;
  httpClientProvider ==> githubHttpClientProvider;
  githubAccessTokenProvider[[githubAccessTokenProvider]];
  httpClientProvider[[httpClientProvider]];
  githubRepoRepositoryProvider[[githubRepoRepositoryProvider]];
  githubApiProvider ==> githubRepoRepositoryProvider;
  githubHttpClientProvider ==> githubRepoRepositoryProvider;
  githubApiProvider[[githubApiProvider]];
  launcher[[launcher]];
  launchUrlStateProvider -.-> launcher;
  launchModeProvider -.-> launcher;
  launchModeProvider[[launchModeProvider]];
  selectedRepoProvider[[selectedRepoProvider]];
  searchReposSortProvider[[searchReposSortProvider]];
  appDataRepositoryProvider ==> searchReposSortProvider;
  searchReposSortUpdater[[searchReposSortUpdater]];
  searchReposSortProvider ==> searchReposSortUpdater;
  appDataRepositoryProvider ==> searchReposSortUpdater;
  appDataRepositoryProvider[[appDataRepositoryProvider]];
  searchReposQueryStringProvider[[searchReposQueryStringProvider]];
  searchReposInitQueryStringProvider ==> searchReposQueryStringProvider;
  searchReposInitQueryStringProvider[[searchReposInitQueryStringProvider]];
  queryHistoryRepositoryProvider[[queryHistoryRepositoryProvider]];
  searchReposEnteringQueryStringProvider[[searchReposEnteringQueryStringProvider]];
  searchReposQueryStringProvider ==> searchReposEnteringQueryStringProvider;
  repoListViewStateProvider[[repoListViewStateProvider]];
  searchReposQueryStringProvider ==> repoListViewStateProvider;
  searchReposSortProvider ==> repoListViewStateProvider;
  searchReposOrderProvider ==> repoListViewStateProvider;
  repoRepositoryProvider ==> repoListViewStateProvider;
  selectedRepoProviderFamily[[selectedRepoProviderFamily]];
  repoRepositoryProvider ==> selectedRepoProviderFamily;
  repoRepositoryProvider[[repoRepositoryProvider]];
  searchReposOrderProvider[[searchReposOrderProvider]];
  appDataRepositoryProvider ==> searchReposOrderProvider;
  searchReposOrderUpdater[[searchReposOrderUpdater]];
  searchReposOrderProvider ==> searchReposOrderUpdater;
  appDataRepositoryProvider ==> searchReposOrderUpdater;
  queryHistoriesProvider[[queryHistoriesProvider]];
  queryHistoryRepositoryProvider ==> queryHistoriesProvider;
  searchReposEnteringQueryStringProvider ==> queryHistoriesProvider;
  readmeContentProviderFamily[[readmeContentProviderFamily]];
  repoRepositoryProvider ==> readmeContentProviderFamily;
```

## フォルダ構成

```
├── config                                 アプリケーション、ルーター、テーマ、環境変数等の設定値
├── domain                                 ドメイン層
│   ├── entities                           ドメイン層で共通のエンティティクラス
│   │   └── input.dart
│   ├── exceptions.dart                    例外クラス
│   └── repositories
│       └── repo
│           ├── entities                   エンティティクラス
│           │   ├── repo.dart
│           │   ├── repo.freezed.dart
│           │   ├── search_repos_order.dart
│           │   ├── search_repos_result.dart
│           │   ├── search_repos_result.freezed.dart
│           │   ├── search_repos_sort.dart
│           │   └── values                 値オブジェクトクラス
│           │       ├── repo_count.dart
│           │       ├── repo_count.freezed.dart
│           │       ├── repo_language.dart
│           │       └── repo_language.freezed.dart
│           └── repo_repository.dart       リポジトリのインターフェース
├── infrastructure                         インフラストラクチャ層
│   └── github                             データソース毎にサブクラスを用意する
│       ├── api.dart
│       ├── http_client.dart
│       └── repo                           関心事毎にサブクラスを用意する
│           ├── json_objects               データソース内でのみ使うエンティティなど
│           │   ├── owner.dart
│           │   ├── owner.freezed.dart
│           │   ├── owner.g.dart
│           │   ├── repo.dart
│           │   ├── repo.freezed.dart
│           │   ├── repo.g.dart
│           │   ├── search_repos_result.dart
│           │   ├── search_repos_result.freezed.dart
│           │   └── search_repos_result.g.dart
│           └── repo_repository.dart       ドメイン層のインターフェースを実装したリポジトリの実体
├── localizations                          多言語ファイル
├── presentation                           プレゼンテーション層
│   ├── components                         共通のコンポーネント、状態もここに含める
│   └── pages                              ページ（画面）一式、機能毎にサブクラスを用意する
│       └── repo
│           ├── components                 機能毎のコンポーネント、状態もここに含める
│           ├── repo_index_page.dart
│           ├── repo_search_page.dart
│           └── repo_view_page.dart
└── utils                                    拡張機能、ロガーなどのユーティリティクラス
    ├── extensions.dart
    └── logger.dart
```

## 環境

|                | Version                          |
|----------------|----------------------------------|
| Flutter        | 3.0.1                            |
| Dart           | 2.17.1                           |

### コードの自動生成

- `localizations/*.json` ファイルを変更した場合や `freezed` を使った `dart` ファイルを変更した場合は次のコマンドを実行してください。

```bash
bin/flutter_gen
```

### 単体テスト（UnitTest / WidgetTest）

- ローカルで単体テストを行うためには事前に次のライブラリをインストールしてください。

```bash
# lcov のインストール
brew install lcov

# dart_dot_reporter のインストール
flutter pub global activate dart_dot_reporter
```

- 次のコマンドで単体テスト（静的解析 => テスト => カバレッジの結果を表示 ）を実行します。

```bash
bin/flutter_test
```

### API ドキュメント

- [API ドキュメント](https://susatthi.github.io/github-search/) で公開しています。

- 生成する場合は次のコマンドを実行してください。

```bash
bin/dartdoc
```

## CI

- [GitHub Actions](https://github.co.jp/features/actions) を利用して CI を構築しています。
  - プルリクエストが作成や更新された時、もしくは `main` または `develop` ブランチに `push` されたときに CI が発火します。

```mermaid
%%{init:{'theme':'base','themeVariables':{'primaryColor':'#f0f0f0','primaryTextColor':'#2f2f2f', 'lineColor':'#2f2f2f','textColor':'#2f2f2f','fontSize':'16px','nodeBorder':'0px'}}}%%
flowchart LR
    Start((開始)) --> AnalyzeUbuntu(Ubuntu静的解析)
    Start --> AnalyzeMacos(macOS静的解析)
    Start --> AnalyzeWindows(Windows静的解析)
    Start --> BuildAndroid(Androidビルド)
    Start --> BuildiOS(iOSビルド)
    Start --> BuildWeb(Webビルド)
    Start --> BuildMacOS(macOSビルド)
    Start --> BuildWindows(Windowsビルド)

    AnalyzeUbuntu --> TestUbuntu(Ubuntu単体テスト)
    TestUbuntu --> UploadCoverageUbuntu(Codecovに結果を送信)
    AnalyzeMacos ---> TestMacos(macOS単体テスト)
    AnalyzeWindows ---> TestWindows(Windows単体テスト)
    UploadCoverageUbuntu --> NotifySlack(Slackに結果を送信)
    TestMacos --> NotifySlack
    TestWindows --> NotifySlack
    BuildAndroid ----> NotifySlack
    BuildiOS ----> NotifySlack
    BuildWeb ----> NotifySlack
    BuildMacOS ----> NotifySlack
    BuildWindows ----> NotifySlack
    NotifySlack --> End((終了))

    classDef anchor fill:#4063DD, color:#ffffff;
    classDef testJob fill:#4063DD, color:#ffffff;
    classDef buildJob fill:#d32f2f, color:#ffffff;
    classDef reportJob fill:#437C40, color:#ffffff;
    %% class Start,End anchor;
    class AnalyzeUbuntu,TestUbuntu,UploadCoverageUbuntu,AnalyzeMacos,TestMacos,AnalyzeWindows,TestWindows testJob;
    class BuildAndroid,BuildiOS,BuildWeb,BuildMacOS,BuildWindows,CreateApiDoc,DeployGitHubPages buildJob;
    class NotifySlack reportJob;
```

## ライセンス

MIT
