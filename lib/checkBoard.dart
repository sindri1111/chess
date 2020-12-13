import 'package:flutter/material.dart';
//import 'package:secondchess/pieceClass.dart';

import 'ChessPiecesClasses.dart';

class CheckerEngine {

  List<List<ChessPieceAct>> gameBoard = [];
  int moveCount = 0;



  CheckerEngine() {
    initEmptyTiles();
    addPieces();


  }

  void initEmptyTiles() {
    for (int i = 0; i < 8; i++) {
      gameBoard.add([]);
      for (int j = 0; j < 8; j++) {
        gameBoard[i].add(
            ChessPieceAct(
                pieceColor: PieceColor.empty,
                piece: ChessPiece.empty,
                isActive: false),
        );
      }
    }
  }

  void addPieces() {
    //Adds black rooks
    gameBoard[0][0].piece = ChessPiece.bRook;
    gameBoard[0][7].piece = ChessPiece.bRook;
    gameBoard[0][0].pieceColor = PieceColor.black;
    gameBoard[0][7].pieceColor = PieceColor.black;

    //Adds black knights
    gameBoard[0][1].piece = ChessPiece.bKnight;
    gameBoard[0][6].piece = ChessPiece.bKnight;
    gameBoard[0][1].pieceColor = PieceColor.black;
    gameBoard[0][6].pieceColor = PieceColor.black;

    //Adds black bishops
    gameBoard[0][2].piece = ChessPiece.bBishop;
    gameBoard[0][5].piece = ChessPiece.bBishop;
    gameBoard[0][2].pieceColor = PieceColor.black;
    gameBoard[0][5].pieceColor = PieceColor.black;

    //Adds black queen
    gameBoard[0][3].piece = ChessPiece.bQueen;
    gameBoard[0][3].pieceColor = PieceColor.black;


    //Adds black king
    gameBoard[0][4].piece = ChessPiece.bKing;
    gameBoard[0][4].pieceColor = PieceColor.black;

    //Adds black pawns
    for (int i = 0; i < gameBoard[1].length; i++) {
      gameBoard[1][i].piece = ChessPiece.bPawn;
      gameBoard[1][i].pieceColor = PieceColor.black;
    }

    //Adds white pawns
    for (int i = 0; i < gameBoard[6].length; i++) {
      gameBoard[6][i].piece = ChessPiece.wPawn;
      gameBoard[6][i].pieceColor = PieceColor.white;
    }

    //Adds white rooks
    gameBoard[7][0].piece = ChessPiece.wRook;
    gameBoard[7][7].piece = ChessPiece.wRook;
    gameBoard[7][7].pieceColor = PieceColor.white;
    gameBoard[7][0].pieceColor = PieceColor.white;

    //Adds white knights
    gameBoard[7][1].piece = ChessPiece.wKnight;
    gameBoard[7][6].piece = ChessPiece.wKnight;
    gameBoard[7][1].pieceColor = PieceColor.white;
    gameBoard[7][6].pieceColor = PieceColor.white;

    //Adds white bishops
    gameBoard[7][2].piece = ChessPiece.wBishop;
    gameBoard[7][5].piece = ChessPiece.wBishop;
    gameBoard[7][2].pieceColor = PieceColor.white;
    gameBoard[7][5].pieceColor = PieceColor.white;

    //Adds white queen
    gameBoard[7][3].piece = ChessPiece.wQueen;
    gameBoard[7][3].pieceColor = PieceColor.white;

    //Adds white king
    gameBoard[7][4].piece = ChessPiece.wKing;
    gameBoard[7][4].pieceColor = PieceColor.white;
  }






  void activateTile(int row, int col){
    for(int i = 0; i < gameBoard.length; i++){
      for(int j = 0; j < gameBoard[i].length; j++){
        gameBoard[i][j].isActive = false;
      }
    }
    if(gameBoard[row][col].piece != ChessPiece.empty) {
      if (gameBoard[row][col].pieceColor == PieceColor.white &&
          whiteToMove() == true) {
        gameBoard[row][col].isActive = true;
      } else if (gameBoard[row][col].pieceColor == PieceColor.black &&
          whiteToMove() == false) {
        gameBoard[row][col].isActive = true;
      }
    }
  }

  void moveActivePieceToSquare(int row, int col){
    for(int i = 0; i < gameBoard.length; i++){
      for(int j = 0; j < gameBoard[i].length; j++){
        if(gameBoard[i][j].isActive == true){
          if(gameBoard[row][col].piece == ChessPiece.empty) {
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;
            print(moveCount);
            print(whiteToMove());
          }else if(whiteToMove() == true && gameBoard[row][col].pieceColor == PieceColor.black){
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;
          }else if(whiteToMove() == false && gameBoard[row][col].pieceColor == PieceColor.white){
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;
          }
        }
      }
    }

  }

  bool whiteToMove(){
    if(moveCount % 2 != 0){
      return false;
    }
    return true;
  }

  void deActivateAllTiles(){
    for(int i = 0; i < gameBoard.length; i++){
      for(int j = 0; j < gameBoard[i].length; j++){
          gameBoard[i][j].isActive = false;
      }
    }
  }












}



class ChessPieceAct{
  ChessPiece piece;
  bool isActive;
  PieceColor pieceColor;


  ChessPieceAct({this.isActive, this.piece,this.pieceColor});



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

enum PieceColor{
  white,
  black,
  empty,
}


