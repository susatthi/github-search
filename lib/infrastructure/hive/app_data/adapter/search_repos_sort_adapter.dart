import 'package:hive_flutter/adapters.dart';

import '../../../../domain/repository/repo/entity/search_repos_sort.dart';

class SearchReposSortAdapter extends TypeAdapter<SearchReposSort> {
  @override
  int get typeId => 0;

  @override
  SearchReposSort read(BinaryReader reader) {
    return SearchReposSort.nameOf(reader.readString());
  }

  @override
  void write(BinaryWriter writer, SearchReposSort obj) {
    writer.writeString(obj.name);
  }
}
