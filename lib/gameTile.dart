import 'package:flutter/material.dart';
import 'constants.dart';

import 'checkBoard.dart';


class RenderTile extends StatelessWidget {

  PieceColor pieceColor;
  ChessPiece currentPiece;
  String image;
  int row;
  int col;
  Function putPawn;
  Function activateTile;
  Function movePiece;
  Function deActivateAllTiles;
  Color color;
  bool isActive;

  RenderTile({
    this.row,
    this.col,
    this.currentPiece,
    this.color,
    this.putPawn,
    this.isActive,
    this.activateTile,
    this.movePiece,
    this.deActivateAllTiles,
    this.pieceColor
  });

//this.inactiveState
  @override
  Widget build(BuildContext context) {
    String piece;
    ChessPiecesImages pieceImage = new ChessPiecesImages();
    if (currentPiece == ChessPiece.empty) {
      piece = pieceImage.empty;
    } else if (currentPiece == ChessPiece.bPawn){
      piece = pieceImage.bPawn;
    }else if (currentPiece == ChessPiece.bRook){
      piece = pieceImage.bRook;
    }else if (currentPiece == ChessPiece.bKnight){
      piece = pieceImage.bKnight;
    }else if (currentPiece == ChessPiece.bBishop){
      piece = pieceImage.bBishop;
    }else if (currentPiece == ChessPiece.bKing){
      piece = pieceImage.bKing;
    }else if (currentPiece == ChessPiece.bQueen){
      piece = pieceImage.bQueen;
    }else if (currentPiece == ChessPiece.wPawn){
      piece = pieceImage.wPawn;
    }else if (currentPiece == ChessPiece.wRook){
      piece = pieceImage.wRook;
    }else if (currentPiece == ChessPiece.wKnight){
      piece = pieceImage.wKnight;
    }else if (currentPiece == ChessPiece.wBishop){
      piece = pieceImage.wBishop;
    }else if (currentPiece == ChessPiece.wQueen){
      piece = pieceImage.wQueen;
    }else if (currentPiece == ChessPiece.wKing){
      piece = pieceImage.wKing;
    }
    return GestureDetector(

      onTap: () {

        movePiece(row, col);
        activateTile(row, col);







      },
      onDoubleTap: () {
        deActivateAllTiles();
      },
      child: Container(
        width: 52,
        height: 52,
        color: isActive == true ? kActiveCardColor : color,
        child: Image(image: AssetImage(piece),)
      ),
    );
  }
}

class ChessPiecesImages {

  //white chess pieces
  String wPawn = 'images/Chess_plt45.svg.png';
  String wKing = 'images/Chess_klt45.svg.png';
  String wQueen = 'images/Chess_qlt45.svg.png';
  String wRook = 'images/1280px-Chess_rlt45.svg.png';
  String wBishop = 'images/Chess_blt45.svg.png';
  String wKnight = 'images/Chess_nlt45.svg.png';
  String empty = '';


//black chess pieces

  String bPawn = 'images/1280px-Chess_pdt45.svg.png';
  String bKing = 'images/1280px-Chess_kdt45.svg.png';
  String bQueen = 'images/Chess_qdt45.svg.png';
  String bRook = 'images/Chess_rdt45.svg.png';
  String bBishop = 'images/Chess_bdt45.svg.png';
  String bKnight = 'images/Chess_ndt45.svg.png';

}