import 'dart:math';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:chess_tryout/Ugly algorithms.dart';
import 'pieces string.dart';
import 'constants.dart';

const kBlackTile = Color(0xffB58962);
const kWhiteTile = Color(0xffF0DAB5);

class GameBoard {
  List<List<GameTile>> gameBoard = [];
  ChessPiecesImages chessPiecesImages = ChessPiecesImages();
  ChessPiece piece;
  //int count = 0;

  GameBoard() {
    boardInit();
    addPieces();
    assignTileColor();

  }


  void setGameTilesToInactive(int row, int col){
    for(int i = 0; i < gameBoard.length;i++){
      for(int j = 0; j < gameBoard[i].length;j++) {
        gameBoard[i][j].isActive = false;
      }
    }
    gameBoard[row][col].isActive = true;
  }

  Widget assignEnumsToPieceImage(ChessPiece piece){
    Widget image;
    if(piece == ChessPiece.wQueen){
      image = Image(image: AssetImage(chessPiecesImages.wQueen),);
    }else if(piece == ChessPiece.wKing){
      image = Image(image: AssetImage(chessPiecesImages.wKing),);
    }else if(piece == ChessPiece.wRook){
      image = Image(image: AssetImage(chessPiecesImages.wRook),);
    }else if(piece == ChessPiece.wBishop){
      image = Image(image: AssetImage(chessPiecesImages.wBishop),);
    }else if(piece == ChessPiece.wKnight){
      image = Image(image: AssetImage(chessPiecesImages.wKnight),);
    }else if(piece == ChessPiece.wPawn){
      image = Image(image: AssetImage(chessPiecesImages.wPawn),);
    }else if(piece == ChessPiece.bKing){
      image = Image(image: AssetImage(chessPiecesImages.bKing),);
    }else if(piece == ChessPiece.bQueen){
      image = Image(image: AssetImage(chessPiecesImages.bQueen),);
    }else if(piece == ChessPiece.bRook){
      image = Image(image: AssetImage(chessPiecesImages.bRook),);
    }else if(piece == ChessPiece.bKnight){
      image = Image(image: AssetImage(chessPiecesImages.bKnight),);
    }else if(piece == ChessPiece.bBishop){
      image = Image(image: AssetImage(chessPiecesImages.bBishop),);
    }else if(piece == ChessPiece.bPawn){
      image = Image(image: AssetImage(chessPiecesImages.bPawn),);
    }
    return image;
  }

  void assignTileColor(){
    for(int row = 0; row < gameBoard.length;row++){
      for(int col = 0;col < gameBoard[row].length;col++){
        gameBoard[row][col].activeColor = kActiveCardColor;
      }
    }
  }



  void addPieces(){
    //Adds black rooks
    gameBoard[0][0].piece = ChessPiece.bRook;
    gameBoard[0][7].piece = ChessPiece.bRook;

    //Adds black knights
    gameBoard[0][1].piece = ChessPiece.bKnight;
    gameBoard[0][6].piece = ChessPiece.bKnight;

    //Adds black bishops
    gameBoard[0][2].piece = ChessPiece.bBishop;
    gameBoard[0][5].piece = ChessPiece.bBishop;

    //Adds black queen
    gameBoard[0][3].piece = ChessPiece.bQueen;
    
    //Adds black king
    gameBoard[0][4].piece = ChessPiece.bKing;
    
    //Adds black pawns
    for(int i = 0; i < gameBoard[1].length; i++){
      gameBoard[1][i].piece = ChessPiece.bPawn;
    }


    //Adds white pawns
    for(int i = 0; i < gameBoard[6].length; i++){
      gameBoard[6][i].piece = ChessPiece.wPawn;
    }

    //Adds white rooks
    gameBoard[7][0].piece = ChessPiece.wRook;
    gameBoard[7][7].piece = ChessPiece.wRook;

    //Adds white knights
    gameBoard[7][1].piece = ChessPiece.wKnight;
    gameBoard[7][6].piece = ChessPiece.wKnight;

    //Adds white bishops
    gameBoard[7][2].piece = ChessPiece.wBishop;
    gameBoard[7][5].piece = ChessPiece.wBishop;

    //Adds white queen
    gameBoard[7][3].piece = ChessPiece.wQueen;

    //Adds white king
    gameBoard[7][4].piece = ChessPiece.wKing;

    for(int row = 0; row < gameBoard.length; row++){
      for(int col = 0; col < gameBoard[row].length; col++){
        gameBoard[row][col].pieceImage = assignEnumsToPieceImage(gameBoard[row][col].piece);
      }
    }
  }

  void boardInit() {
    int counter = 0;
    for (int row = 0; row < 8; row++) {
      gameBoard.add([]);
      for (int col = 0; col < 8; col++) {

        if (counter % 2 != 0) {
            //Black tile
            gameBoard[row].add(
              GameTile(
                color: kBlackTile,
                piece: ChessPiece.empty,
                gameBoard: this,
                row: row,
                col: col,
              ),
            );
          } else {
            //White tile
            gameBoard[row].add(
              GameTile(
                color: kWhiteTile,
                piece: ChessPiece.empty,
                gameBoard: this,
                row: row,
                col: col,

              ),
            );
          }

        if (counter == 7 && row < 1) {
          counter--;
        } else if (counter == 14 && row < 2) {
          counter--;
        } else if (counter == 21 && row < 3) {
          counter--;
        } else if (counter == 28 && row < 4) {
          counter--;
        } else if (counter == 35 && row < 5) {
          counter--;
        } else if (counter == 42 && row < 6) {
          counter--;
        } else if (counter == 49 && row < 7) {
          counter--;
        } else if (counter == 56 && row < 8) {
          counter--;
        }
        counter++;
      }
    }
  }

}

class GameTile extends StatefulWidget {
  GameTile({this.color, this.pieceImage,this.piece, this.row, this.col,this.gameBoard,this.isActive,this.activeColor});
  Color color;
  Widget pieceImage;
  ChessPiece piece;
  int row;
  int col;
  GameBoard gameBoard;
  bool isActive;
  Color activeColor;

  /*


  Widget tempPieceImage;
  ChessPiece tempPiece;
  int count = 0;
  ChessPiecesImages images;
   */




  //ChessPiecesImages chessPiecesImages = ChessPiecesImages();


  @override
  _GameTileState createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  Function onPress;

  @override


  Widget build(BuildContext context) {
    return Expanded(

      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: (){
            //print('${widget.piece}');
            //print(widget.color == kBlackTile,);
            //print(widget.isActive);


            setState(() {
              widget.gameBoard.setGameTilesToInactive(widget.row, widget.col);

              for(int i = 0; i < widget.gameBoard.gameBoard.length; i++){
                for(int j = 0; j < widget.gameBoard.gameBoard[i].length; j++){
                  print(widget.gameBoard.gameBoard[i][j].isActive);
                }
              }
            });


          },
          child: Draggable(
            feedback: Container(
              child: widget.pieceImage,
              width: 50,
              height: 50,
            ),

            childWhenDragging: Container(
              color: widget.isActive == true ? widget.activeColor : widget.color,
            ),
            child: Container(
              child: widget.pieceImage,
              color: widget.isActive == true ? widget.activeColor : widget.color,
            ),
          ),
        ),
      ),
     );
  }
}

enum ChessPiece {
  wPawn,
  wKnight,
  wBishop,
  wRook,
  wQueen,
  wKing,
  empty,
  bPawn,
  bKnight,
  bBishop,
  bRook,
  bQueen,
  bKing,

}
