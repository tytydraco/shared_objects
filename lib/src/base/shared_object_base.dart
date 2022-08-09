import 'package:shared_preferences/shared_preferences.dart';

/// An extensible class that persists an object to [SharedPreferences].
abstract class SharedObjectBase<T> {
  /// Creates a new [SharedObjectBase] given an [id].
  const SharedObjectBase(this.id);

  /// A unique [SharedPreferences] key.
  final String id;

  /// Set the value of this object using [SharedPreferences].
  ///
  /// If the value is null, delete this key.
  Future<void> set(T? value);

  /// Get the value of this object using [SharedPreferences].
  Future<T?> get();

  /// Get the value of this object using [SharedPreferences]. If the value is
  /// null, return the value from the [orElse] handler instead.
  Future<T> getOrElse(T Function() orElse) async => await get() ?? orElse();

  /// Get the non-nullable value of this object using [SharedPreferences].
  ///
  /// Only use this method if the value is guaranteed to not be null.
  Future<T> getNotNull() async => (await get())!;

  /// Modify the current value given a handler function.
  ///
  /// The handler function is provided the current value, and returns a new,
  /// updated value.
  Future<void> mutate(T? Function(T? initial) handler) async {
    final initial = await get();
    final result = handler(initial);
    if (initial != result) await set(result);
  }
}
