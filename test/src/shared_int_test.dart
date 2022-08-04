import 'package:flutter_test/flutter_test.dart';
import 'package:shared_objects/shared_objects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Shared int', () {
    SharedPreferences.setMockInitialValues({});
    final sharedInt = SharedInt('my_int');

    test('Initialized to null', () async {
      expect(
        await sharedInt.get(),
        null,
      );
    });

    test('Set new value', () async {
      await expectLater(
        () => sharedInt.set(123),
        returnsNormally,
      );
    });

    test('Ensure get() is accurate with shared preferences', () async {
      final sharedPrefs = await SharedPreferences.getInstance();

      expect(
        sharedPrefs.getInt('my_int'),
        await sharedInt.get(),
      );
    });

    test('Ensure stored value is accurate', () async {
      expect(
        await sharedInt.get(),
        123,
      );
    });

    test('Arithmetic operations', () async {
      await sharedInt.add(100);
      expect(
        await sharedInt.get(),
        223,
      );

      await sharedInt.sub(100);
      expect(
        await sharedInt.get(),
        123,
      );

      await sharedInt.mul(2);
      expect(
        await sharedInt.get(),
        246,
      );

      await sharedInt.div(2);
      expect(
        await sharedInt.get(),
        123,
      );

      await sharedInt.pow(2);
      expect(
        await sharedInt.get(),
        15129,
      );
    });

    test('Delete value', () async {
      await sharedInt.set(null);

      expect(
        await sharedInt.get(),
        null,
      );
    });
  });
}
