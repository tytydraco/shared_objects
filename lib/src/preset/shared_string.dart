import 'package:shared_objects/src/base/shared_object_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [String] that is directly integrated with [SharedPreferences].
class SharedString extends SharedObjectBase<String> {
  /// Creates a new [SharedString] given an [id].
  SharedString(super.id);

  final _sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> set(String? value) async {
    final instance = await _sharedPrefs;
    if (value == null) {
      await instance.remove(id);
    } else {
      await instance.setString(id, value);
    }
  }

  @override
  Future<String?> get() async {
    final instance = await _sharedPrefs;
    return instance.getString(id);
  }

  /// Append some text to the current string.
  ///
  /// If the current string is null, set the current string to the new text.
  Future<void> append(String text) async {
    await mutate((initial) {
      if (initial == null) return text;
      return initial + text;
    });
  }
}
