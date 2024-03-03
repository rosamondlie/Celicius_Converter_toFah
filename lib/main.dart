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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    double fahTemp = 0.0, celTemp = 0.0;
  bool isFah = true;
  var fahController = TextEditingController();
  var celController = TextEditingController();

  fahListener() {
    setState(() {
      fahTemp = double.parse(fahController.text);
      celTemp = convert(fahTemp, true);
      if (isFah) celController.text = celTemp.toString();
      isFah = true;
    });
  }

  celListener() {
    setState(() {
      celTemp = double.parse(celController.text);
      fahTemp = convert(celTemp, false);
      if (!isFah) fahController.text = fahTemp.toString();
      isFah = false;
    });
  }

  @override
  void initState() {
    fahController.addListener(fahListener);
    celController.addListener(celListener);
  }

  @override
  void dispose() {
    fahController.dispose();
    celController.dispose();
  }

  double convert(double temp, bool isF) {
    return isF ? (temp - 32) / (5 / 6) : (temp * 9 / 5) + 32;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    'Celcius',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    controller: celController,
                    decoration: InputDecoration(
                      suffixText: 'C',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    'Fahrenheit',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    controller: fahController,
                    decoration: InputDecoration(
                      suffixText: 'F',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
