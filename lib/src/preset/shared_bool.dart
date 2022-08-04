import 'package:shared_objects/src/base/shared_object_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [bool] that is directly integrated with [SharedPreferences].
class SharedBool extends SharedObjectBase<bool> {
  /// Creates a new [SharedBool] given an [id].
  SharedBool(super.id);

  final _sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> set(bool? value) async {
    final instance = await _sharedPrefs;
    if (value == null) {
      await instance.remove(id);
    } else {
      await instance.setBool(id, value);
    }
  }

  @override
  Future<bool?> get() async {
    final instance = await _sharedPrefs;
    return instance.getBool(id);
  }
}
