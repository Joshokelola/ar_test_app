import 'dart:convert';

import 'package:heritage_quest/models/treasures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData {
  final SharedPreferences _prefs;

  GameData(this._prefs);

  Future<int> getScore() async {
    return _prefs.getInt('score') ?? 0;
  }

  Future<void> setScore(int score) async {
    await _prefs.setInt('score', score);
  }

  Future<void> saveTreasures(List<Treasure> treasures) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        treasures.map((person) => jsonEncode(person.toJson())).toList();
    await prefs.setStringList('treasure_list', jsonStringList);
  }

  Future<List<Treasure>> getTreasureList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('treasure_list');

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => Treasure.fromJson(jsonDecode(jsonString)))
          .toList();
    }

    return [];
  }

  Future<List<String>> getCollectedArtifacts() async {
    return _prefs.getStringList('artifacts') ?? [];
  }

  Future<void> setCollectedArtifacts(List<String> artifacts) async {
    await _prefs.setStringList('artifacts', artifacts);
  }
}
