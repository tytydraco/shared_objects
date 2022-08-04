import 'package:flutter_test/flutter_test.dart';
import 'package:shared_objects/src/preset/shared_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Shared string', () {
    SharedPreferences.setMockInitialValues({});
    final sharedString = SharedString('my_string');

    test('Initialized to null', () async {
      expect(
        await sharedString.get(),
        null,
      );
    });

    test('Set new value', () async {
      await expectLater(
        () => sharedString.set('new_value'),
        returnsNormally,
      );
    });

    test('Ensure get() is accurate with shared preferences', () async {
      final sharedPrefs = await SharedPreferences.getInstance();

      expect(
        sharedPrefs.getString('my_string'),
        await sharedString.get(),
      );
    });

    test('Ensure stored value is accurate', () async {
      expect(
        await sharedString.get(),
        'new_value',
      );
    });

    test('Append', () async {
      await sharedString.append(' with new text');
      expect(
        await sharedString.get(),
        'new_value with new text',
      );
    });

    test('Delete value', () async {
      await sharedString.set(null);

      expect(
        await sharedString.get(),
        null,
      );
    });
  });
}
