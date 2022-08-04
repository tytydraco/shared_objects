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

  /// Append a string to the current string list.
  ///
  /// If the current string list is null, set the current string to the new
  /// string. See [List.add].
  Future<void> add(String text) async {
    await mutate((initial) {
      if (initial == null) return [text];
      initial.add(text);
      return List<String>.from(initial);
    });
  }

  /// Append multiple strings to the current string list.
  ///
  /// If the current string list is null, set the current string to the new
  /// strings. See [List.addAll].
  Future<void> addAll(Iterable<String> list) async {
    await mutate((initial) {
      if (initial == null) return list.toList();
      initial.addAll(list);
      return List<String>.from(initial);
    });
  }

  /// Remove a string to the current string list.
  ///
  /// Returns true if the string was removed from the list. See [List.remove].
  Future<bool> remove(String text) async {
    var removed = false;
    await mutate((initial) {
      if (initial == null) return initial;
      removed = initial.remove(text);
      return List<String>.from(initial);
    });

    return removed;
  }
}
