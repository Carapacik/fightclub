import 'package:fightclub/src/models/fight_history.dart';
import 'package:fightclub/src/models/fight_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension type const FightHistoryStorage(SharedPreferencesAsync _preferences) {
  static const _lastResultKey = 'last_fight_result';
  static const _wonKey = 'stats_won';
  static const _lostKey = 'stats_lost';
  static const _drawKey = 'stats_draw';

  Future<FightHistory> load() async {
    final String? rawLastResult = await _preferences.getString(_lastResultKey);
    return FightHistory(
      won: await _preferences.getInt(_wonKey) ?? 0,
      lost: await _preferences.getInt(_lostKey) ?? 0,
      draw: await _preferences.getInt(_drawKey) ?? 0,
      lastResult: rawLastResult == null ? null : FightResult.fromStorage(rawLastResult),
    );
  }

  Future<void> save(FightResult result) async {
    final FightHistory history = await load();
    final FightHistory updatedHistory = history.add(result);
    await Future.wait([
      _preferences.setString(_lastResultKey, result.label),
      _preferences.setInt(_wonKey, updatedHistory.won),
      _preferences.setInt(_lostKey, updatedHistory.lost),
      _preferences.setInt(_drawKey, updatedHistory.draw),
    ]);
  }
}
