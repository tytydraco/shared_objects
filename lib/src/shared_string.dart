import 'package:shared_objects/src/shared_object_base.dart';
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
}
