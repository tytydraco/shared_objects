import 'package:shared_preferences/shared_preferences.dart';

/// An extensible class that persists an object to [SharedPreferences].
abstract class SharedObjectBase<T> {
  /// Creates a new [SharedObjectBase] given an [id].
  SharedObjectBase(this.id);

  /// A unique [SharedPreferences] key.
  final String id;

  /// Set the value of this object using [SharedPreferences].
  ///
  /// If the value is null, delete this key.
  Future<void> set(T? value);

  /// Get the value of this object using [SharedPreferences].
  Future<T?> get();
}
