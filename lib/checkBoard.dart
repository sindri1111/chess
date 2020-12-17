import 'package:flutter/material.dart';
//import 'package:secondchess/pieceClass.dart';

import 'ChessPiecesClasses.dart';



class CheckerEngine {

  List<List<ChessPieceObj>> gameBoard = [];
  int moveCount = 0;



  CheckerEngine() {
    initializeEmptyTiles();
    addPieces();


  }

  void initializeEmptyTiles() {
    for (int i = 0; i < 8; i++) {
      gameBoard.add([]);
      for (int j = 0; j < 8; j++) {
        gameBoard[i].add(
            ChessPieceObj(
                pieceColor: PieceColor.empty,
                piece: ChessPiece.empty,
                isActive: false),
        );
      }
    }
  }

  //this function below places all of the right pieces to the right squares at the beginning of the match
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





  //This function below loops through the gameBoard list and makes all of the pieces inactive,
  //and then activates the piece that the user clicks on, it also makes sure that,
  //if it's white to move the white pieces can only be activated and vice versa,
  //also you can't activate empty squares.

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

  
  //this function moves the activePiece to the desired location and uses the,
  //legalMove() and whiteToMove() functions to get confirmation to be executed and,
  //also tells the white pieces that they cannot capture their own pieces and vice versa. 
  void moveActivePieceToSquare(int row, int col){
    for(int i = 0; i < gameBoard.length; i++){
      for(int j = 0; j < gameBoard[i].length; j++){
        if(gameBoard[i][j].isActive){
          if(gameBoard[row][col].piece == ChessPiece.empty && legalMove(row, col)) {
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;


          }else if(whiteToMove() && gameBoard[row][col].pieceColor == PieceColor.black && legalMove(row, col)){
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;
          }else if(!whiteToMove() && gameBoard[row][col].pieceColor == PieceColor.white && legalMove(row, col)){
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


  //If the moveCount integer is an even number it's white to move, else it's black to move
  bool whiteToMove(){
    if(moveCount % 2 != 0){
      return false;
    }
    return true;
  }

  //Kinda pointless but, this function gets executed if you double tap the screen and it
  //just deactivates all the tiles
  void deActivateAllTiles(){
    for(int i = 0; i < gameBoard.length; i++){
      for(int j = 0; j < gameBoard[i].length; j++){
          gameBoard[i][j].isActive = false;
      }
    }
  }

  
  //This function takes the input of the location you want to move the active piece to,
  //and checks what piece it is and if the piece is allowed to move there,
  //if so then the function returns a true statement, if not it returns false
  bool legalMove(int row, int col){

    int activeRow;
    int activeCol;

    //loops through the list and finds the active piece, and assigns it to the variables above,
    //could've had the activeRow and activeCol as inputs to the function but i like for loops :) 
    for(int i = 0; i < gameBoard.length;i++){
      for(int j = 0; j < gameBoard[i].length; j++){
        if(gameBoard[i][j].isActive == true){
          activeRow = i;
          activeCol = j;
        }
      }
    }


    //--------------Legal moves for white pawn---------------//

    if(gameBoard[activeRow][activeCol].piece == ChessPiece.wPawn){

      if(getWhitePawnKillTarget(row, col, activeRow, activeCol) == true){
        return true;
      }
      if(gameBoard[activeRow - 1][activeCol].pieceColor == PieceColor.black){ // this checks to see if there is a,
        return false;                                                         //piece in front of the pawn, if so the pawn cant move forward
      }
      if(col == activeCol) {
        if (activeRow == 6) {                                    //This checks to see if the white pawn is on row 6,
          if (row == activeRow - 2 || row == activeRow - 1) {   //if it is it can either move 1 or 2 squares up.
            return true;
          }
        }else if(activeRow != 6){
          if(row == activeRow -1){ //Tells the pawn it can only move one square ahead
            return true;
          }
        }
        return false;
      }
      return false;
    }


    //--------------Legal moves for black pawn---------------//

    if(gameBoard[activeRow][activeCol].piece == ChessPiece.bPawn){

      getDiagonal(row, col, activeRow, activeCol, false);

      if(getBlackPawnKillTarget(row, col, activeRow, activeCol) == true){
        return true;
      }
      if(gameBoard[activeRow + 1][activeCol].pieceColor == PieceColor.white){
        return false;                                                             
      }
      if(col == activeCol) {                                      //these conditionals are basically the same as,
        if (activeRow == 1) {                                     //the white pawn conditionals but inverted.
          if (row == activeRow + 2 || row == activeRow + 1) {
            return true;
          }
        }else if(activeRow != 1){
          if(row == activeRow +1){
            return true;
          }
        }
        return false;
      }
      return false;
    }


    //--------------Legal moves for white and black knights---------------//

    if(gameBoard[activeRow][activeCol].piece == ChessPiece.wKnight ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bKnight){

      if(row == activeRow - 2 && col == activeCol - 1){
        return true;
      }
      if(row == activeRow - 2 && col == activeCol + 1){
        return true;
      }
      if(row == activeRow + 2 && col == activeCol - 1){
        return true;
      }
      if(row == activeRow + 2 && col == activeCol + 1){       
        return true;
      }

      if(row == activeRow - 1 && col == activeCol - 2){
        return true;
      }
      if(row == activeRow - 1 && col == activeCol + 2){
        return true;
      }
      if(row == activeRow + 1 && col == activeCol - 2){
        return true;
      }
      if(row == activeRow + 1 && col == activeCol + 2){
        return true;
      }
      return false;
    }
    
    
    //--------------Legal moves for white and black rooks---------------//
    
    if(gameBoard[activeRow][activeCol].piece == ChessPiece.wRook ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bRook){


      getDiagonal(row, col, activeRow, activeCol, false);

      if(row == activeRow){
        for(int i = col + 1; i < activeCol ; i++){
          if(gameBoard[row][i].piece != ChessPiece.empty){
            return false;
          }
        }
        for(int i = activeCol + 1; i < col ; i++){
          if(gameBoard[row][i].piece != ChessPiece.empty){
            return false;
          }
        }


        return true;
      }
      if(activeCol == col){

        for(int i = row + 1; i < activeRow ; i++){
          if(gameBoard[i][col].piece != ChessPiece.empty){
            return false;
          }
        }
        for(int i = activeRow + 1; i < row ; i++){
          if(gameBoard[i][col].piece != ChessPiece.empty){
            return false;
          }
        }

        return true;
      }



      return false;
    }

    //--------------Legal moves for white and black bishop---------------//

    if(gameBoard[activeRow][activeCol].piece == ChessPiece.wBishop ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bBishop){






      return false;
    }

    //--------------Legal moves for white and black Queen---------------//
    if(gameBoard[activeRow][activeCol].piece == ChessPiece.wQueen ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bQueen){

      getDiagonal(row, col, activeRow, activeCol, false);

      return false;
    }

    return true;
  }



  //these two boolean functions below (getWhitePawnKillTarget() and getBlackPawnKillTarget())
  //they check to see if there is an enemy piece 1 diagonal from them, up or down depending if it's
  //white or black to move, if so the function returns a true statement

  bool getWhitePawnKillTarget(int row, int col, int activeRow, int activeCol){

    if(gameBoard[row][col].pieceColor == PieceColor.black) {
      if(row == activeRow - 1 && col == activeCol - 1) {
        return true;
      }else if(row == activeRow - 1 && col == activeCol + 1){
        return true;
      }
    }else{
      return false;
    }

  }

  bool getBlackPawnKillTarget(int row, int col, int activeRow, int activeCol){

    if(gameBoard[row][col].pieceColor == PieceColor.white) {
      if(row == activeRow + 1 && col == activeCol + 1) {
        return true;
      }else if(row == activeRow + 1 && col == activeCol - 1){
        return true;
      }
    }else{
      return false;
    }

  }








  bool getDiagonal(int row, int col, int activeRow, int activeCol, bool forward){

    List<ChessPiece> chessPieceDiagList = [];

    List<int> rowCol;
    if(!forward){
      rowCol = rowColLoop(activeRow, 7 - activeCol);
    }else{
      rowCol = rowColLoop(activeRow, activeCol);
    }




    int x = rowCol[0];
    int y = rowCol[1];


      while (true){
        if(forward) {
          chessPieceDiagList.add(gameBoard[x][y].piece);
        }else{
          chessPieceDiagList.add(gameBoard[x][7 - y].piece);
        }
        if(forward) {
          if (x < 8) {
            x++;
          } else {
            break;
          }
          if (y < 8) {
            y++;
          } else {
            break;
          }
          if (x == 8 || y == 8) {
            break;
          }
        }else{
          if (x < 8) {
            x++;
          } else {
            break;
          }
          if (y < 8) {
            y++;
          } else {
            break;
          }
          if (x == 8 || y == 8) {
            break;
          }
        }
      }






    print(chessPieceDiagList);


    return false;
  }
  List<int> rowColLoop(int activeRow, int activeCol){

    List<int> rowCol = [];

    while(true){
      if(activeRow == 0 || activeCol == 0){
        break;
      }
      if(activeRow > 0) {
        activeRow--;
      }else{
        break;
      }
      if(activeCol > 0) {
        activeCol--;
      }else{
        break;
      }
      if(activeRow  == 0|| activeCol == 0){
        break;
      }
    }
    rowCol.add(activeRow);
    rowCol.add(activeCol);

    return rowCol;
  }


}



class ChessPieceObj{
  //This is the main class for all of the pieces in the list

  ChessPiece piece; //This is used to tell each piece what moves they are allowed to make
  bool isActive; //This boolean is important as it is used to move each piece
  PieceColor pieceColor; //This one basically divides the pieces in separate teams of black and white, and of course white pieces can only capture black pieces and vice versa

  ChessPieceObj({this.isActive, this.piece,this.pieceColor});
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



//shit algorithm if all else fails

/*
      if(row > activeRow && col > activeCol){ //down right
        if(row == activeRow + 1 && col == activeCol + 1) {
          return true;
        }
        if(row == activeRow + 2 && col == activeCol + 2) {
          return true;
        }
        if(row == activeRow + 3 && col == activeCol + 3) {
          return true;
        }
        if(row == activeRow + 4 && col == activeCol + 4) {
          return true;
        }
        if(row == activeRow + 5 && col == activeCol + 5) {
          return true;
        }
        if(row == activeRow + 6 && col == activeCol + 6) {
          return true;
        }
        if(row == activeRow + 7 && col == activeCol + 7) {
          return true;
        }
      }
      if(row > activeRow && col < activeCol){
        if(row == activeRow + 1 && col == activeCol - 1) {
          return true;
        }
        if(row == activeRow + 2 && col == activeCol - 2) {
          return true;
        }
        if(row == activeRow + 3 && col == activeCol - 3) {
          return true;
        }
        if(row == activeRow + 4 && col == activeCol - 4) {
          return true;
        }
        if(row == activeRow + 5 && col == activeCol - 5) {
          return true;
        }
        if(row == activeRow + 6 && col == activeCol - 6) {
          return true;
        }
        if(row == activeRow + 7 && col == activeCol - 7) {
          return true;
        }

      }



 */



