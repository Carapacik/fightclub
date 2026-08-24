import 'package:fightclub/src/data/fight_history_storage.dart';
import 'package:fightclub/src/models/body_part.dart';
import 'package:fightclub/src/models/fight_result.dart';
import 'package:flutter/foundation.dart';

class FightController(final FightHistoryStorage _storage) extends ChangeNotifier {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  BodyPart _enemyDefends = BodyPart.random;
  BodyPart _enemyAttacks = BodyPart.random;
  int playerLives = maxLives;
  int enemyLives = maxLives;
  String roundSummary = '';

  bool get canPlay => defendingBodyPart != null && attackingBodyPart != null && !isFinished;

  bool get isFinished => playerLives == 0 || enemyLives == 0;

  void selectDefendingBodyPart(BodyPart value) {
    if (isFinished) {
      return;
    }
    defendingBodyPart = value;
    notifyListeners();
  }

  void selectAttackingBodyPart(BodyPart value) {
    if (isFinished) {
      return;
    }
    attackingBodyPart = value;
    notifyListeners();
  }

  Future<void> playRound() async {
    if (!canPlay) {
      return;
    }

    final BodyPart attack = attackingBodyPart!;
    final enemyLosesLife = attack != _enemyDefends;
    final playerLosesLife = defendingBodyPart != _enemyAttacks;

    if (enemyLosesLife) {
      enemyLives--;
    }
    if (playerLosesLife) {
      playerLives--;
    }

    final FightResult? result = FightResult.calculate(playerLives: playerLives, enemyLives: enemyLives);
    roundSummary = switch (result) {
      FightResult.draw => 'Draw',
      FightResult.won => 'You won',
      FightResult.lost => 'You lost',
      null => [
        if (enemyLosesLife) "You hit enemy's ${attack.label.toLowerCase()}." else 'Your attack was blocked.',
        if (playerLosesLife) 'Enemy hit your ${_enemyAttacks.label.toLowerCase()}.' else "Enemy's attack was blocked.",
      ].join('\n'),
    };

    _enemyDefends = BodyPart.random;
    _enemyAttacks = BodyPart.random;
    defendingBodyPart = null;
    attackingBodyPart = null;
    notifyListeners();

    if (result != null) {
      await _storage.save(result);
    }
  }
}
