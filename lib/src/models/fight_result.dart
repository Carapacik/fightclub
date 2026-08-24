enum FightResult(final String label) {
  won('Won'),
  lost('Lost'),
  draw('Draw');

  static FightResult fromStorage(String value) => values.firstWhere((result) => result.label == value);

  static FightResult? calculate({required int playerLives, required int enemyLives}) =>
      switch ((playerLives, enemyLives)) {
        (0, 0) => draw,
        (0, _) => lost,
        (_, 0) => won,
        _ => null,
      };
}
