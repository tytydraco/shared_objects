import 'dart:math' as math;

import 'package:shared_objects/src/base/shared_object_base.dart';

/// Arithmetic operations for a numerical [SharedObjectBase].
mixin SharedNumOpsMixin<T extends num> on SharedObjectBase<T> {
  /// Add a numerical value to the current value.
  Future<void> add(T value) async {
    await mutate((initial) {
      if (initial == null) return initial;
      return initial + value as T;
    });
  }

  /// Subtract a numerical value from the current value.
  Future<void> sub(T value) async {
    await mutate((initial) {
      if (initial == null) return initial;
      return initial - value as T;
    });
  }

  /// Multiply a numerical value by the current value.
  Future<void> mul(T value) async {
    await mutate((initial) {
      if (initial == null) return initial;
      return initial * value as T;
    });
  }

  /// Divide a numerical value from the current value.
  ///
  /// If [T] is an [int], use integer division.
  Future<void> div(T value) async {
    await mutate((initial) {
      if (initial == null) return initial;
      if (T == int) return initial ~/ value as T;
      return initial / value as T;
    });
  }

  /// Raise the current value to a numerical value exponent. See [math.pow].
  Future<void> pow(T value) async {
    await mutate((initial) {
      if (initial == null) return initial;
      return math.pow(initial, value) as T;
    });
  }
}
