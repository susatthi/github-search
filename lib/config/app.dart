import 'package:flutter/material.dart';
import 'package:github_search/ui/page/repositories/index_page.dart';

class GithubSearchApp extends StatelessWidget {
  const GithubSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GithubSearch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RepositoriesIndexPage(),
    );
  }
}
