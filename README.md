# shared_objects

A wrapper around shared_preferences to streamline persistable data.

# Concept

Creating a persistable value usually requires some boilerplate code. For example:

```dart
import 'package:shared_preferences/shared_preferences.dart';

String? _value;

Future<void> setValue(String newValue) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.setString('name', newValue);
}

Future<String?> getValue() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getString('name');
}
```

The `shared_objects` package aims to reduce that boilerplate code into a more concise implementation. For example:

```dart
import 'package:shared_objects/shared_objects.dart';

final value = SharedString('name');
await value.set('newValue');
await value.get();
```

# Getting started

Add the dependency to your project using the following command: `flutter pub add shared_objects`.

# Usage

The base class that defines a persistable object is the explicitly-typed `SharedObjectBase` class. All persistable
objects are defined with the following components:

* `id`: A unique `String` key associated with this object.
* `set(T?)`: Asynchronously set the new value of this object. If the new value is `null`, the objects contents are
  deleted, and the `id` is removed from the `SharedPreferences` map.
* `get()`: Asynchronously get the current value of this object.
* `mutate(T? Function(T?))`: Asynchronously modify the value of this object by passing a function. The function is given
  the initial value of the object via `get()`, and must return an updated value. If the initial value equals the updated
  value, no change is made, which skips a call to `set(T?)`.

The package already includes several extensions of the base class for convenience. This includes the following classes:

* `SharedBool`: A persistable `bool`.
* `SharedDouble`: A persistable `double` with some arithmetic extensions (`add`, `sub`, `mul`, `div`, `pow`).
* `SharedInt`: A persistable `int` with some arithmetic extensions (`add`, `sub`, `mul`, `div`, `pow`).
* `SharedString`: A persistable `String` with an `append` extension.
* `SharedStringList`: A persistable `List<String>` with some list extensions (`add`, `addAll`, `remove`).
