import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/app_data/app_data_repository.dart';
import '../../domain/repositories/app_data/entities/app_data_key.dart';

/// アプリデータコントローラー
abstract class AppDataController<T> extends StateNotifier<T> {
  AppDataController({
    required this.appDataRepository,
    required this.appDataKey,
  }) : super(
          appDataRepository.get<T>(appDataKey),
        ) {
    // Streamを監視して都度反映する
    appDataRepository.listen<T>(appDataKey).listen(
      (value) {
        state = value;
      },
    );
  }

  final AppDataRepository appDataRepository;
  final AppDataKey appDataKey;

  /// 更新する
  void update(T value) {
    appDataRepository.set<T>(appDataKey, value);
  }
}
