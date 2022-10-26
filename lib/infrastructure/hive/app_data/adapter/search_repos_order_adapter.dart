import 'package:hive_flutter/adapters.dart';

import '../../../../domain/repository/repo/entity/search_repos_order.dart';

class SearchReposOrderAdapter extends TypeAdapter<SearchReposOrder> {
  @override
  int get typeId => 1;

  @override
  SearchReposOrder read(BinaryReader reader) {
    return SearchReposOrder.nameOf(reader.readString());
  }

  @override
  void write(BinaryWriter writer, SearchReposOrder obj) {
    writer.writeString(obj.name);
  }
}
