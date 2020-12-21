import 'package:flutter/material.dart';
import 'gameBoard.dart';

void main() {
  runApp(MyApp());
}

// This is the root of the application

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: Scaffold(
        body: GameBoard(),


      ),

    );
  }
}