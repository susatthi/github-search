<p align="center">
<a href="https://github.com/susatthi/github-search/actions/workflows/flutter_ci.yaml"><img src="https://github.com/susatthi/github-search/actions/workflows/flutter_ci.yaml/badge.svg" alt="Flutter CI"></a>
<a href="https://codecov.io/gh/susatthi/github-search"><img src="https://codecov.io/gh/susatthi/github-search/branch/develop/graph/badge.svg?token=C48OG86U8O" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple" alt="MIT"></a>
<img width="100%" src="https://user-images.githubusercontent.com/13707135/165474118-d7a43467-7e8e-4dc7-9aed-2e1dd1456ea6.png">
</p>

# GitHub Search

> **:warning: 制限事項**  
> - 現在 Web 版がビルドできません。Isar 3.0.2 が Web をサポートしなくなったためです。詳細は [Issue](https://github.com/isar/isar/issues/686) をご参照ください。
> - 現在テストが通りません。ディレクトリ構造を変更したことにテストが追従できていません。対応中です。

[GitHub API](https://docs.github.com/ja/rest) を利用して GitHub のリポジトリを検索するアプリです。[株式会社ゆめみのFlutterエンジニアコードチェック](https://github.com/yumemi-inc/flutter-engineer-codecheck)の要件を満たすよう実装しています。

本アプリを通して自分なりの最適なアーキテクチャを確立し、リファレンスコードにすることを目的にしています。

> **:warning: 注意**  
> このアプリは `GitHub API` を利用するために GitHub の `アクセストークン` をアプリの内部でハードコーディングして保持する構成になっています。このアプリを公開すると悪意のある者に `アクセストークン` を抜き取られ悪用される恐れがありますのでお控え下さい。もちろん、手元でビルドして動かすことは問題ありません。

一覧(Light)|一覧(Dark)
--|--
![index-light](https://user-images.githubusercontent.com/13707135/183786156-c6506906-9eb1-419f-8466-fdbe907934f7.png)|![index-dark](https://user-images.githubusercontent.com/13707135/183786212-11334663-f095-4a22-a98a-13a4b5dde6c1.png)

デスクトップ|タブレット
--|--
![desktop](https://user-images.githubusercontent.com/13707135/183787423-b404c9d3-e1e6-4c57-bd96-4e4c5c06703a.png)|![tablet](https://user-images.githubusercontent.com/13707135/183787582-86eabebc-7d99-4961-ad6c-70c75f299725.png)


詳細|0件|エラー
--|--|--
![view](https://user-images.githubusercontent.com/13707135/183786405-5f925803-83ad-4066-a01e-f903d2b45148.png)|![empty](https://user-images.githubusercontent.com/13707135/183786643-bca0977e-f6e6-4a8c-a651-2a150163de07.png)|![error](https://user-images.githubusercontent.com/13707135/183786950-221a389c-8613-4b1d-8755-726f9b71654f.png)

![github_search_0_9_0_demo](https://user-images.githubusercontent.com/13707135/172117146-22d5f5b2-5e90-4d09-8060-8c1976b2b42a.gif)


## ビルド方法

#### ソースコードを clone
  
```bash
git clone https://github.com/susatthi/github-search.git
```

#### GitHub の個人アクセストークンを取得

本アプリで使用する GitHub の[個人アクセストークン](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)を取得して、カレントディレクトリで次のコマンドを実行してください。

```bash
# 引数で与えられた環境変数を基にビルドに必要な `lib/util/env/env.dart` を作成してくれます。
# 作成された `lib/util/env/env.dart` を直接編集しても大丈夫です。

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
|`web-release`     |Web 向けリリースビルド       |

## 技術スタック

- アプリの機能
  - GitHub リポジトリの検索と詳細表示
  - 検索結果の並び替えと [hive](https://pub.dev/packages/hive) を使ったデータの永続化
  - Sliver を使った無限スクロール対応
  - [isar](https://isar.dev/) を使った検索履歴の保存とサジェスト
- [go_router](https://pub.dev/packages/go_router) と [go_router_builder](https://pub.dev/packages/go_router_builder) を使ったルーティング
- [http](https://pub.dev/packages/http) を使った REST API の実装
- [fast_i18n](https://pub.dev/packages/fast_i18n) を使った多言語対応（日本語/英語）
- カスタムフォント対応
- [mocktail](https://pub.dev/packages/mocktail) を使った Unit / Widget テスト
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) を使ったアプリアイコン
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) を使ったスプラッシュ画面
- [responsive_framework](https://pub.dev/packages/responsive_framework) を使ったレスポンシブ対応
- [GitHub Actions](https://github.co.jp/features/actions) によるCI(自動テストと自動ビルド)
- ダークモード対応
- サポートするプラットフォーム
  - iOS / Android / Web / macOS / Windows

### 今後対応予定

- Integration テスト
- Riverpod 2 対応

### 対応しないこと

- Firebase 連携
- Flavor 対応（develop / staging / production などの環境分け）

## アーキテクチャ / パッケージ

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + [go_router](https://pub.dev/packages/go_router)
- [CODE WITH ANDREA](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) と [DDD](https://little-hands.hatenablog.com/entry/2018/12/10/ddd-architecture) のアーキテクチャを参考にして、本アプリは下記の３層アーキテクチャで実装しています。

![アーキテクチャ図](https://user-images.githubusercontent.com/13707135/200081763-c2809366-046d-4a82-8367-9bee5a751b90.png)

### Presentation 層

ユーザーとの I/F を担う層。Application 層と Domain 層に依存する。Infrastructure 層に依存してはいけない。

#### Widget

ページや UI 部品の Widget クラス群。State を監視（ watch / listen ）して UI に表現する。ユーザーイベントを検知して Service のメソッドを呼び出す。キャッシュが効かなくなるので直接 Repository Interface を呼び出してはいけない。画面遷移の実装は Widget のイベントハンドラー内で行ってよい。

#### Application 層

アプリケーションのロジックや状態を定義する層。Domain 層に依存する。Presentation 層と Infrastructure 層に依存してはいけない。

#### State

アプリのあらゆる状態。Domain 層の Entity そのものでもよいし、複数の Repository をまたいだ Entity を統合するクラスでもよい。State は `StateProvider` 等でラップされ Widget や他の State から参照される。

#### Service

ユーザーイベントを受け付けて、複数の Repository Interface を呼び出して Entity を受け取って State を更新するサービスクラス。Widget からのメソッド呼び出しや、依存する State の更新を契機に発火する。

### Domain 層

ドメインロジックやドメインオブジェクト（エンティティ）を定義する層。どの層にも依存してはいけない。

#### Entity

Repository Interface で扱うドメインオブジェクト（データの構造体）。入力値のバリデーションは Entity のコンストラクタで実装する。Infrastructure 層が投げる例外はドメイン層で定義する。

#### Repository Interface

データの永続化や外部サービス連携を担う Repository のインターフェース。集約毎に定義する。

### Infrastructure 層

データの永続化や外部サービス連携を担う層。Domain 層に依存する。Presentation 層と Application 層に依存してはいけない。

#### Repository Implements

Repository Interface の実装。Data Source を利用してデータの永続化を行う。

#### Data Source

様々なデータソース。Firebase だったり、API だったり、Hive だったり、SharedPreferences だったり、Isar だったりする。

## フォルダ構成

```  
├── application                              アプリケーション層
│   └── <関心事>
│       ├── <state>                          状態クラス群
│       └── <関心事>_service.dart             サービスクラス
├── domain                                   ドメイン層
│   ├── exceptions.dart                      例外クラス
│   └── repository
│       └── <集約>
│           ├── <集約>_repository.dart        リポジトリのインターフェースクラス
│           └── entity                       集約単位のエンティティ
├── infrastructure                           インフラストラクチャ層
│   └── <データソース>
│       └── <集約>
│           └── <集約>_repository.dart       リポジトリの実装
├── presentation
│   ├── app.dart                             アプリケーション
│   ├── router.dart                          ルーティング
│   ├── theme.dart                           テーマ
│   ├── component                            プレゼンテーション層で共通の Widget
│   └── page
│       └── <関心事>
│           ├── component                    画面単位の Widget
│           └── <関心事>_<CURD>page.dart      画面Widget
└── util                                     どの層からもアクセス可能な便利クラス（ロガー、拡張メソッドなど）
```

### ファイル分割の方針

基本的に **関心事** 毎にファイルを分割しています。例えば、Controller と State を別々のファイルに分けることはしません。ファイル名は **関心事.dart** とします。ファイル名 = クラス名とはしません。

## 環境

|                | Version                          |
|----------------|----------------------------------|
| Flutter        | 3.3.10                           |
| Dart           | 2.18.6                           |

### コードの自動生成

- `util/localization/*.json` ファイルを変更した場合や `freezed` を使った `dart` ファイルを変更した場合は次のコマンドを実行してください。

```bash
make build-runner
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
# 言語設定が英語のテスト
make test-en

# 言語設定が日本語のテスト
make test-ja
```

### API ドキュメント

- [API ドキュメント](https://susatthi.github.io/github-search/) で公開しています。

- 生成する場合は次のコマンドを実行してください。

```bash
make dartdoc
```

## CI

- [GitHub Actions](https://github.co.jp/features/actions) を利用して CI を構築しています。
  - プルリクエストが作成や更新された時、もしくは `main` または `develop` ブランチに `push` されたときに CI が発火します。

```mermaid
%%{init:{'theme':'base','themeVariables':{'primaryColor':'#f0f0f0','primaryTextColor':'#2f2f2f', 'lineColor':'#2f2f2f','textColor':'#2f2f2f','fontSize':'16px','nodeBorder':'0px'}}}%%
flowchart LR
    Start((開始)) --> AnalyzeUbuntu(Ubuntu静的解析)
    Start --> AnalyzeMacosEn(macOS英語静的解析)
    Start --> AnalyzeMacosJp(macOS日本語静的解析)
    Start --> AnalyzeWindows(Windows静的解析)
    Start --> BuildAndroid(Androidビルド)
    Start --> BuildiOS(iOSビルド)
    Start --> BuildWeb(Webビルド)
    Start --> BuildMacOS(macOSビルド)
    Start --> BuildWindows(Windowsビルド)

    AnalyzeUbuntu ---> TestUbuntu(Ubuntu単体テスト)
    AnalyzeMacosEn ---> TestMacosEn(macOS英語単体テスト)
    AnalyzeMacosJp --> TestMacosJp(macOS日本語単体テスト)
    TestMacosJp --> UploadCoverageMacosJp(Codecovに結果を送信)
    AnalyzeWindows ---> TestWindows(Windows単体テスト)
    UploadCoverageMacosJp --> NotifySlack(Slackに結果を送信)
    TestUbuntu --> NotifySlack
    TestMacosEn --> NotifySlack
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
    class AnalyzeUbuntu,TestUbuntu,UploadCoverageMacosJp,AnalyzeMacosEn,AnalyzeMacosJp,TestMacosEn,TestMacosJp,AnalyzeWindows,TestWindows testJob;
    class BuildAndroid,BuildiOS,BuildWeb,BuildMacOS,BuildWindows,CreateApiDoc,DeployGitHubPages buildJob;
    class NotifySlack reportJob;
```

## ライセンス

MIT
