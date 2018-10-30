import 'package:flutter/material.dart';

import 'package:youtube_clone_app/src/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: Home(),
    );
  }
}