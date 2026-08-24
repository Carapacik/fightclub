import 'package:fightclub/src/models/fight_result.dart';
import 'package:flutter/foundation.dart';

@immutable
class const FightHistory({
  required final int won,
  required final int lost,
  required final int draw,
  final FightResult? lastResult,
}) {
  FightHistory add(FightResult result) => switch (result) {
    FightResult.won => FightHistory(won: won + 1, lost: lost, draw: draw, lastResult: result),
    FightResult.lost => FightHistory(won: won, lost: lost + 1, draw: draw, lastResult: result),
    FightResult.draw => FightHistory(won: won, lost: lost, draw: draw + 1, lastResult: result),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FightHistory &&
          runtimeType == other.runtimeType &&
          (won, lost, draw, lastResult) == (other.won, other.lost, other.draw, other.lastResult);

  @override
  int get hashCode => (won, lost, draw, lastResult).hashCode;
}
