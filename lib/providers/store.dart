import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

final sharedPreferencesRepositoryProvider = Provider<GameData>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  if (prefs == null) {
    throw UnimplementedError();
  }
  return GameData(prefs);
});
