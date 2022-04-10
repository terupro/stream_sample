import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coming Out',
      theme: ThemeData(
        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 45)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<int?> numberStream;

  @override
  void initState() {
    super.initState();
    numberStream = getNumbers();
  }

  Stream<int?> getNumbers() async* {
    await Future.delayed(const Duration(seconds: 1));
    yield 3;

    await Future.delayed(const Duration(seconds: 1));
    yield 2;

    await Future.delayed(const Duration(seconds: 1));
    yield 1;

    await Future.delayed(const Duration(seconds: 1));
    yield 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coming Out')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            numberStream = getNumbers();
          });
        },
      ),
      body: Center(
        child: StreamBuilder<int?>(
          stream: numberStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Stream is null');
              case ConnectionState.waiting:
                return const Text('Are you Ready?');
              case ConnectionState.active:
                if (snapshot.hasData) {
                  int number = snapshot.data!;
                  return Text('$number');
                } else {
                  return const Text('No data!');
                }
              case ConnectionState.done:
                if (snapshot.hasData) {
                  int number = snapshot.data!;
                  return const Text('チョコ食べたい');
                } else {
                  return const Text('No data!');
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
