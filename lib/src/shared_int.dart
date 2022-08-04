import 'package:shared_objects/src/shared_object_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An [int] that is directly integrated with [SharedPreferences].
class SharedInt extends SharedObjectBase<int> {
  /// Creates a new [SharedInt] given an [id].
  SharedInt(super.id);

  final _sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> set(int? value) async {
    final instance = await _sharedPrefs;
    if (value == null) {
      await instance.remove(id);
    } else {
      await instance.setInt(id, value);
    }
  }

  @override
  Future<int?> get() async {
    final instance = await _sharedPrefs;
    return instance.getInt(id);
  }
}
