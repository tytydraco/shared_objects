import 'package:shared_objects/src/shared_object_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [double] that is directly integrated with [SharedPreferences].
class SharedDouble extends SharedObjectBase<double> {
  /// Creates a new [SharedDouble] given an [id].
  SharedDouble(super.id);

  final _sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> set(double? value) async {
    final instance = await _sharedPrefs;
    if (value == null) {
      await instance.remove(id);
    } else {
      await instance.setDouble(id, value);
    }
  }

  @override
  Future<double?> get() async {
    final instance = await _sharedPrefs;
    return instance.getDouble(id);
  }
}
