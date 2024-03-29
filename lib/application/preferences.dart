import 'package:aedex/domain/repositories/preferences.repository.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/infrastructure/preferences.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preferences.g.dart';

@riverpod
PreferencesRepository _preferencesRepository(
  _PreferencesRepositoryRef ref,
) =>
    PreferencesRepositoryImpl();

@riverpod
Future<HivePreferencesDatasource> _getPreferences(
  _GetPreferencesRef ref,
) async {
  return ref.watch(_preferencesRepositoryProvider).getPreferences();
}

@riverpod
Future<bool> _isLogsActived(
  _IsLogsActivedRef ref,
) async {
  final preferences =
      await ref.watch(_preferencesRepositoryProvider).getPreferences();
  return preferences.isLogsActived();
}

abstract class PreferencesProviders {
  static final getPreferences = _getPreferencesProvider;
  static final isLogsActived = _isLogsActivedProvider;
  static final preferencesRepository =
      _preferencesRepositoryProvider; //FIXME : Repository should not be exposed. Use a AsyncNotifier Provider to hold the settings. That way, settings changes will correctly notify widgets (ex: [AppBarMainScreen]).
}
