import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stand_cup/squad.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stand cup',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          background: Color.fromARGB(255, 230, 207, 2),
          brightness: Brightness.dark,
          error: Color.fromARGB(255, 230, 2, 2),
          onBackground: Color.fromARGB(255, 0, 0, 0),
          onError: Color.fromARGB(255, 0, 0, 0),
          onPrimary: Color.fromARGB(255, 7, 7, 7),
          onSecondary: Color.fromARGB(255, 5, 5, 5),
          onSurface: Color.fromARGB(255, 0, 0, 0),
          primary: Color.fromARGB(255, 59, 145, 2),
          secondary: Color.fromARGB(255, 101, 243, 6),
          surface: Color.fromARGB(255, 174, 223, 141),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'stand cup page'),
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
  dynamic squads = {};

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    // WindowManager.instance.setFullScreen(true);
    return Scaffold(
        body: GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 1200, childAspectRatio: 7.0, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemCount: squads.length,
      itemBuilder: (BuildContext ctx, index) {
        return Squad(index: index, name: squads["$index"]["name"], intBeers: squads["$index"]["beers"], callback: writeJson);
      },
    )
        // ListView.builder(
        //   itemCount: squads.length,
        //   itemBuilder: (context, index) {
        //     return Squad(index: index, name: squads["$index"]["name"], intBeers: squads["$index"]["beers"], callback: writeJson);
        //   },
        // ),
        );
  }

  void readJson() {
    var response = File('assets/log.json').readAsStringSync();
    final data = json.decode(response);
    setState(() {
      squads = data;
    });
  }

  void writeJson(index, beers) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    squads["$index"]["beers"] = beers;
    var file = encoder.convert(squads);
    File('assets/log.json').writeAsStringSync(file);
  }
}
