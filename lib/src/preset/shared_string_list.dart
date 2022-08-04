import 'package:shared_objects/src/base/shared_object_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [List] of [String]s that is directly integrated with [SharedPreferences].
class SharedStringList extends SharedObjectBase<List<String>> {
  /// Creates a new [SharedStringList] given an [id].
  SharedStringList(super.id);

  final _sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> set(List<String>? value) async {
    final instance = await _sharedPrefs;
    if (value == null) {
      await instance.remove(id);
    } else {
      await instance.setStringList(id, value);
    }
  }

  @override
  Future<List<String>?> get() async {
    final instance = await _sharedPrefs;
    return instance.getStringList(id);
  }
}
