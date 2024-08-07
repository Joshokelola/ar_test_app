import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  final SharedPreferences _prefs;

  SharedPreferencesRepository(this._prefs);

  Future<int> getScore() async {
    return _prefs.getInt('score') ?? 0;
  }

  Future<void> setScore(int score) async {
    await _prefs.setInt('score', score);
  }

  Future<List<String>> getCollectedArtifacts() async {
    return _prefs.getStringList('artifacts') ?? [];
  }

  Future<void> setCollectedArtifacts(List<String> artifacts) async {
    await _prefs.setStringList('artifacts', artifacts);
  }
}
