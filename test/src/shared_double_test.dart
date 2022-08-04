import 'package:flutter_test/flutter_test.dart';
import 'package:shared_objects/shared_objects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Shared double', () {
    SharedPreferences.setMockInitialValues({});
    final sharedDouble = SharedDouble('my_double');

    test('Initialized to null', () async {
      expect(
        await sharedDouble.get(),
        null,
      );
    });

    test('Set new value', () async {
      await expectLater(
        () => sharedDouble.set(1.23),
        returnsNormally,
      );
    });

    test('Ensure get() is accurate with shared preferences', () async {
      final sharedPrefs = await SharedPreferences.getInstance();

      expect(
        sharedPrefs.getDouble('my_double'),
        await sharedDouble.get(),
      );
    });

    test('Ensure stored value is accurate', () async {
      expect(
        await sharedDouble.get(),
        1.23,
      );
    });

    test('Arithmetic operations', () async {
      await sharedDouble.add(100);
      expect(
        await sharedDouble.get(),
        within(distance: 0.0001, from: 101.23),
      );

      await sharedDouble.sub(100);
      expect(
        await sharedDouble.get(),
        within(distance: 0.0001, from: 1.23),
      );

      await sharedDouble.mul(2);
      expect(
        await sharedDouble.get(),
        within(distance: 0.0001, from: 2.46),
      );

      await sharedDouble.div(2);
      expect(
        await sharedDouble.get(),
        within(distance: 0.0001, from: 1.23),
      );

      await sharedDouble.pow(2);
      expect(
        await sharedDouble.get(),
        within(distance: 0.0001, from: 1.5129),
      );
    });

    test('Delete value', () async {
      await sharedDouble.set(null);

      expect(
        await sharedDouble.get(),
        null,
      );
    });
  });
}
