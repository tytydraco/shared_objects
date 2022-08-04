import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_objects/shared_objects.dart';

// Demo using shared_objects to inject objects with persistable states via
// provider.

// Provide some shared objects to the entire app.
class SharedObjectProvider {
  final count = SharedInt('count');
  final toggle = SharedBool('toggle');

  Future<void> setDefaults() async {
    count.mutate((initial) => initial ?? 0);
    toggle.mutate((initial) => initial ?? false);
  }
}

Future<void> main() async {
  final sharedObjectProvider = SharedObjectProvider();
  await sharedObjectProvider.setDefaults();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Provider.value(
    value: sharedObjectProvider,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shared_objects',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _count = context
      .read<SharedObjectProvider>()
      .count;
  late final _toggle = context
      .read<SharedObjectProvider>()
      .toggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shared_objects'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              child: const Text('Increment'),
              onPressed: () async {
                await _count.add(1);
                setState(() {});
              },
            ),
            FutureBuilder(
              future: _count.get(),
              initialData: -1,
              builder: (context, snapshot) {
                final data = snapshot.data as int;
                return Text('Current count: $data');
              },
            ),
            FutureBuilder(
              future: _toggle.get(),
              initialData: false,
              builder: (context, snapshot) {
                final data = snapshot.data as bool;
                return Switch(
                  value: data,
                  onChanged: (newState) {
                    _toggle.set(newState);
                    setState(() {});
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
