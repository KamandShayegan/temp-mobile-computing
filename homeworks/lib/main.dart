import 'package:flutter/material.dart';
import 'package:homework_one/local_notifications.dart';
import 'package:homework_one/notif.dart';
import 'package:homework_one/second_page.dart';
import 'package:homework_one/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  // Initialize SharedPreferences
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homeworks - Mobile Computing',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Homeworks - Mobile Computing'),
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
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Settings()));
            },
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MyNotifications())),
                  child: Text('HW-4')),
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
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(12.0)),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "A simple container number #${i + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        _open[i]
                            ? Column(
                                children: [
                                  Text(
                                      'This is to show more info about container #${i + 1}'),
                                  Text("And this is an image:\n"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/codecode.jpg',
                                        height: 80,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => SecondPage(
                                                        idx: i + 1)));
                                          },
                                          child: Text('more'))
                                    ],
                                  )
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
