import 'dart:math';

import 'package:flutter/material.dart';
import 'constants.dart';

import 'checkBoard.dart';


class RenderTile extends StatelessWidget {

  PieceColor pieceColor;
  ChessPiece currentPiece;
  String image;
  int row;
  int col;
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
    //ChessPiecesImages pieceImage = new ChessPiecesImages();

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
        child: Image(image: AssetImage(returnPieceImage(currentPiece)),)
      ),
    );
  }
}


String returnPieceImage(ChessPiece currentPiece){
  String piece;
  if (currentPiece == ChessPiece.empty) {
    piece = '';
  } else if (currentPiece == ChessPiece.bPawn){
    piece = 'images/1280px-Chess_pdt45.svg.png';
  }else if (currentPiece == ChessPiece.bRook){
    piece = 'images/Chess_rdt45.svg.png';
  }else if (currentPiece == ChessPiece.bKnight){
    piece = 'images/Chess_ndt45.svg.png';
  }else if (currentPiece == ChessPiece.bBishop){
    piece = 'images/Chess_bdt45.svg.png';
  }else if (currentPiece == ChessPiece.bKing){
    piece = 'images/1280px-Chess_kdt45.svg.png';
  }else if (currentPiece == ChessPiece.bQueen){
    piece = 'images/Chess_qdt45.svg.png';
  }else if (currentPiece == ChessPiece.wPawn){
    piece = 'images/Chess_plt45.svg.png';
  }else if (currentPiece == ChessPiece.wRook){
    piece = 'images/1280px-Chess_rlt45.svg.png';
  }else if (currentPiece == ChessPiece.wKnight){
    piece = 'images/Chess_nlt45.svg.png';
  }else if (currentPiece == ChessPiece.wBishop){
    piece = 'images/Chess_blt45.svg.png';
  }else if (currentPiece == ChessPiece.wQueen){
    piece = 'images/Chess_qlt45.svg.png';
  }else if (currentPiece == ChessPiece.wKing){
    piece = 'images/Chess_klt45.svg.png';
  }
  return piece;
}




