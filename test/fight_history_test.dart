import 'package:fightclub/src/models/fight_history.dart';
import 'package:fightclub/src/models/fight_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses value equality and matching record-based hash codes', () {
    const first = FightHistory(won: 2, lost: 1, draw: 3, lastResult: FightResult.won);
    const second = FightHistory(won: 2, lost: 1, draw: 3, lastResult: FightResult.won);

    expect(first, second);
    expect(first.hashCode, second.hashCode);
  });

  test('adds the latest result to the matching counter', () {
    const history = FightHistory(won: 0, lost: 0, draw: 0);

    expect(history.add(FightResult.won), const FightHistory(won: 1, lost: 0, draw: 0, lastResult: FightResult.won));
    expect(history.add(FightResult.lost), const FightHistory(won: 0, lost: 1, draw: 0, lastResult: FightResult.lost));
    expect(history.add(FightResult.draw), const FightHistory(won: 0, lost: 0, draw: 1, lastResult: FightResult.draw));
  });
}
