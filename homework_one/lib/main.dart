import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework 1 - Mobile Computing',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Homework 1 - Mobile Computing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _changeState(int idx) {
    for (int i = 0; i < 10; i++) {
      _open[i] = false;
    }
    _open[idx] = true;

    for (int i = 0; i < 10; i++) {
      _height[i] = 66.0;
    }
    _height[idx] = 190.0;
  }

  List<bool> _open = List.generate(10, (index) => false);
  // double _height = 66;
  List<double> _height = List.generate(10, (index) => 66.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'These are 10 containers:\nPlease Click on each container to open them.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'San Francisco',
                ),
              ),
            ),
            for (int i = 0; i < 10; i++)
              InkWell(
                onTap: () {
                  print(_open);
                  setState(() {
                    _changeState(i);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  height: _height[i],
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade500,
                      borderRadius: BorderRadius.circular(12.0)),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "A simple container number #${i + 1}",
                        style: const TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                      _open[i]
                          ? Column(
                              children: [
                                Text(
                                    'This is to show more info about container #${i + 1}'),
                                Text("And this is an image:\n"),
                                Image.asset(
                                  'assets/codecode.jpg',
                                  height: 80,
                                )
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              )
          ],
        )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.amber,
      //   onPressed: _makeCircleBigger,
      //   tooltip: 'Increment',
      //   child: const Icon(
      //     Icons.adjust,
      //     color: Colors.deepPurple,
      //   ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
