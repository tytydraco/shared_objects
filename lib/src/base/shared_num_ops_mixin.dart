import 'package:shared_objects/shared_objects.dart';

/// Arithmetic operations for a numerical [SharedObjectBase].
mixin SharedNumOpsMixin<T extends num> on SharedObjectBase<T> {
  /// Add a numerical value to the current value.
  Future<void> add(T value) async {
    final initial = await get();
    if (initial == null) return;
    final result = initial + value;
    await set(result as T);
  }

  /// Subtract a numerical value from the current value.
  Future<void> sub(T value) async {
    final initial = await get();
    if (initial == null) return;
    final result = initial - value;
    await set(result as T);
  }

  /// Multiply a numerical value by the current value.
  Future<void> mul(T value) async {
    final initial = await get();
    if (initial == null) return;
    final result = initial * value;
    await set(result as T);
  }

  /// Divide a numerical value from the current value.
  ///
  /// If [T] is an [int], use integer division.
  Future<void> div(T value) async {
    final initial = await get();
    if (initial == null) return;

    // Use integer division if dealing with integers.
    final num result;
    if (T == int) {
      result = initial ~/ value;
    } else {
      result = initial / value;
    }

    await set(result as T);
  }
}
