import 'package:flutter_test/flutter_test.dart';
import 'package:shared_objects/shared_objects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Shared bool', () {
    SharedPreferences.setMockInitialValues({});
    final sharedBool = SharedBool('my_bool');

    test('Initialized to null', () async {
      expect(
        await sharedBool.get(),
        null,
      );
    });

    test('Set new value', () async {
      await expectLater(
        () => sharedBool.set(true),
        returnsNormally,
      );
    });

    test('Ensure get() is accurate with shared preferences', () async {
      final sharedPrefs = await SharedPreferences.getInstance();

      expect(
        sharedPrefs.getBool('my_bool'),
        await sharedBool.get(),
      );
    });

    test('Ensure stored value is accurate', () async {
      expect(
        await sharedBool.get(),
        true,
      );
    });

    test('Delete value', () async {
      await sharedBool.set(null);

      expect(
        await sharedBool.get(),
        null,
      );
    });
  });
}
