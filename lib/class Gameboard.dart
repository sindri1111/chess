import 'package:flutter/material.dart';
import 'main.dart';

class GameBoard{

  List<List<Widget>> gameBoard = [];



   GameBoard() {
    seed();
  }


  void seed(){
    for (int row = 0; row < 8; row++) {
      gameBoard.add([]);
      for (int col = 0; col < 8; col++) {
        gameBoard[row].add(
          GameTile(),
        );
      }

    }
  }
}

class GameTile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(

          child: Text('suh'),

        ),
      ),


    );
  }
}