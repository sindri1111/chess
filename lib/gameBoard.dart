import 'checkBoard.dart';
import 'gameTile.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'gameTile.dart';

class GameBoard extends StatefulWidget {
  CheckerEngine engine = CheckerEngine();

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {


  void _activateTile(int row, int col){
    setState(() {
      widget.engine.activateTile(row, col);
    });
  }
  void _movePiece(int row, int col){
    setState(() {
      widget.engine.moveActivePieceToSquare(row, col);
    });
  }
  void deActivateAllTiles(){
    setState(() {
      widget.engine.deActivateAllTiles();
    });

  }





  @override
  Widget build(BuildContext context) {
    return createBoard(widget.engine.gameBoard,_activateTile,_movePiece, deActivateAllTiles);
  }
}

Widget createBoard(
  List<List<ChessPieceAct>> gameTiles,Function activateTile,
    Function movePiece, Function deActivateAllTiles

) {

  List<Widget> col = [];

  int count = 0;

  for(int i = 0; i < gameTiles.length; i++){
    List<Widget> row = [];
    for(int j = 0; j < gameTiles[i].length; j++){

      row.add(
          RenderTile(
            row: i,
            col: j,
            currentPiece: gameTiles[i][j].piece,
            color: tileColor(i, count) == true ? kBlackTile : kWhiteTile,
            isActive: gameTiles[i][j].isActive,
            activateTile: activateTile,
            movePiece: movePiece,
            deActivateAllTiles: deActivateAllTiles,
            pieceColor: gameTiles[i][j].pieceColor,

          ),
      );
      count++;
    }
    col.add(
        Row(children: row, mainAxisAlignment: MainAxisAlignment.center,
        ),
    );

  }
  return Column(
    children: col, mainAxisAlignment: MainAxisAlignment.center,
  );

}
























bool tileColor(int row, int counter) {

  if(row == 0) {
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 1) {
    counter++;
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 2) {
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 3) {
    counter++;
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 4) {
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 5) {
    counter++;
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 6) {
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  if(row == 7) {
    counter++;
    if (counter % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
}

