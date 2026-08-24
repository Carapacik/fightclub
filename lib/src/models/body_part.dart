import 'dart:math';

enum BodyPart(final String label) {
  head('Head'),
  torso('Torso'),
  legs('Legs');

  static final Random _random = Random();

  static BodyPart get random => values[_random.nextInt(values.length)];
}
