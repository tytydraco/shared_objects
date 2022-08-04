import 'package:flutter_test/flutter_test.dart';
import 'package:shared_objects/src/preset/shared_string_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Shared string list', () {
    SharedPreferences.setMockInitialValues({});
    final sharedStringList = SharedStringList('my_string_list');

    test('Initialized to null', () async {
      expect(
        await sharedStringList.get(),
        null,
      );
    });

    test('Set new value', () async {
      await expectLater(
        () => sharedStringList.set(['1', '2', '3']),
        returnsNormally,
      );
    });

    test('Ensure get() is accurate with shared preferences', () async {
      final sharedPrefs = await SharedPreferences.getInstance();

      expect(
        sharedPrefs.getStringList('my_string_list'),
        await sharedStringList.get(),
      );
    });

    test('Ensure stored value is accurate', () async {
      expect(
        await sharedStringList.get(),
        ['1', '2', '3'],
      );
    });

    test('Delete value', () async {
      await sharedStringList.set(null);

      expect(
        await sharedStringList.get(),
        null,
      );
    });
  });
}
