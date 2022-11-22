import 'dart:math';

extension ListExtension<T> on List<T> {
  T get oneRandom {
    if (length == 1) return this[0];
    return this[Random().nextInt(length)];
  }
}
