import 'package:flutter/material.dart';
import 'pieces string.dart';
import 'class Gameboard.dart';


void main() => runApp(Background());

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Board(),
          ),
        ),
      ),
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {


    return Center(
      child: Container(
        color: Colors.blueGrey,
        height: 400,
        width: 400,
        child: Square(),

    ),
    );
  }
}

class Square extends StatefulWidget {





  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  GameBoard Board = new GameBoard();

  @override
  Widget build(BuildContext context) {
   return ListView.builder(

      physics: NeverScrollableScrollPhysics(),
      itemCount: Board.gameBoard.length,
      itemBuilder: (BuildContext, int i) {
        return GestureDetector(
          onTap: (){

          },
          child: Row(
            children: Board.gameBoard[i],
          ),
        );
      },
    );
  }
}


