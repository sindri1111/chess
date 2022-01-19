import 'package:flutter/material.dart';
//import 'package:secondchess/pieceClass.dart';



class CheckerEngine {
  List<List<ChessPieceObj>> gameBoard = [];
  int moveCount = 0;
  bool whiteKingHasMoved = false;
  bool blackKingHasMoved = false;



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

  void activateTile(int row, int col) {
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        gameBoard[i][j].isActive = false;
      }
    }
    if (gameBoard[row][col].piece != ChessPiece.empty) {
      if (gameBoard[row][col].pieceColor == PieceColor.white &&
          whiteToMove() == true ) {
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
  void moveActivePieceToSquare(int row, int col) {
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j].isActive) {
          if (gameBoard[row][col].piece == ChessPiece.empty &&
              legalMove(row, col)) {
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;
          } else if (whiteToMove() &&
              gameBoard[row][col].pieceColor == PieceColor.black &&
              legalMove(row, col)) {
            gameBoard[row][col].piece = gameBoard[i][j].piece;
            gameBoard[row][col].pieceColor = gameBoard[i][j].pieceColor;
            gameBoard[i][j].piece = ChessPiece.empty;
            gameBoard[i][j].pieceColor = PieceColor.empty;
            moveCount++;
          } else if (!whiteToMove() &&
              gameBoard[row][col].pieceColor == PieceColor.white &&
              legalMove(row, col)) {
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
  bool whiteToMove() {
    if (moveCount % 2 != 0) {
      return false;
    }
    return true;
  }

  //Kinda pointless but, this function gets executed if you double tap the screen and it
  //just deactivates all the tiles
  void deActivateAllTiles() {
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        gameBoard[i][j].isActive = false;
      }
    }
  }

  //This function takes the input of the location you want to move the active piece to,
  //and checks what piece it is and if the piece is allowed to move there,
  //if so then the function returns a true statement, if not it returns false
  bool legalMove(int row, int col) {
    int activeRow;
    int activeCol;

    //loops through the list and finds the active piece, and assigns it to the variables above,
    //could've had the activeRow and activeCol as inputs to the function but i like for loops :)
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j].isActive == true) {
          activeRow = i;
          activeCol = j;
        }
      }
    }




    //--------------Legal moves for white pawn---------------//

    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wPawn) {
      if (getWhitePawnKillTarget(row, col, activeRow, activeCol) == true) {
        return true;
      }
      if (gameBoard[activeRow - 1][activeCol].pieceColor == PieceColor.black) {
        // this checks to see if there is a piece in front of the pawn, if so the pawn cant move forward
        return false; //
      }
      if (col == activeCol) {
        if(activeRow == 1 && row == 0 && gameBoard[row][col].piece == ChessPiece.empty){
          // Queens the pawn if it reaches the right destination
          gameBoard[activeRow][activeCol].piece = ChessPiece.wQueen;
        }
        if (activeRow == 6) {
          //This checks to see if the white pawn is on row 6,
          if (row == activeRow - 2 || row == activeRow - 1) {
            //if it is it can either move 1 or 2 squares up.
            return true;
          }
        } else if (activeRow != 6) {
          if (row == activeRow - 1) {
            //Tells the pawn it can only move one square ahead
            return true;
          }
        }
        return false;
      }
      return false;
    }

    //--------------Legal moves for black pawn---------------//

    if (gameBoard[activeRow][activeCol].piece == ChessPiece.bPawn) {
      if (getBlackPawnKillTarget(row, col, activeRow, activeCol) == true) {
        return true;
      }
      if (gameBoard[activeRow + 1][activeCol].pieceColor == PieceColor.white) {
        return false;
      }
      if (col == activeCol) {
        if(activeRow == 6 && row == 6){
          gameBoard[activeRow][activeCol].piece = ChessPiece.bQueen;
        }
        //these conditionals are basically the same as,
        if (activeRow == 1) {
          //the white pawn conditionals but inverted.
          if (row == activeRow + 2 || row == activeRow + 1) {
            return true;
          }
        } else if (activeRow != 1) {
          if (row == activeRow + 1) {
            return true;
          }
        }
        return false;
      }
      return false;
    }

    //--------------Legal moves for white and black knights---------------//

    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wKnight ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bKnight) {
      if (row == activeRow - 2 && col == activeCol - 1) {
        return true;
      }
      if (row == activeRow - 2 && col == activeCol + 1) {
        return true;
      }
      if (row == activeRow + 2 && col == activeCol - 1) {
        return true;
      }
      if (row == activeRow + 2 && col == activeCol + 1) {
        return true;
      }

      if (row == activeRow - 1 && col == activeCol - 2) {
        return true;
      }
      if (row == activeRow - 1 && col == activeCol + 2) {
        return true;
      }
      if (row == activeRow + 1 && col == activeCol - 2) {
        return true;
      }
      if (row == activeRow + 1 && col == activeCol + 2) {
        return true;
      }
      return false;
    }

    //--------------Legal moves for white and black rooks---------------//

    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wRook ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bRook) {
      //loops through the row that the rook wants to move in and checks if there are any pieces,
      //in between the location where he is and where he wants to go to, if there is then legalMove returns false
      if (row == activeRow) {
        for (int i = col + 1; i < activeCol; i++) {
          if (gameBoard[row][i].piece != ChessPiece.empty) {
            return false;
          }
        }
        for (int i = activeCol + 1; i < col; i++) {
          if (gameBoard[row][i].piece != ChessPiece.empty) {
            return false;
          }
        }

        return true;
      }
      // does the same as above but just loops through the column instead
      if (activeCol == col) {
        for (int i = row + 1; i < activeRow; i++) {
          if (gameBoard[i][col].piece != ChessPiece.empty) {
            return false;
          }
        }
        for (int i = activeRow + 1; i < row; i++) {
          if (gameBoard[i][col].piece != ChessPiece.empty) {
            return false;
          }
        }

        return true;
      }

      return false;
    }

    //--------------Legal moves for white and black bishop---------------//

    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wBishop ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bBishop) {
      if (getDiagonal(row, col, activeRow, activeCol, true)) { //check getDiagonal documentation
        return true;
      }
      if (getDiagonal(row, col, activeRow, activeCol, false)) {
        return true;
      }

      return false;
    }

    //--------------Legal moves for white and black Queen---------------//
    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wQueen ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bQueen) {
      //uses the same algorithms as the bishops and rooks use

      if (getDiagonal(row, col, activeRow, activeCol, true)) {
        return true;
      }
      if (getDiagonal(row, col, activeRow, activeCol, false)) {
        return true;
      }
      if (row == activeRow) {
        for (int i = col + 1; i < activeCol; i++) {
          if (gameBoard[row][i].piece != ChessPiece.empty) {
            return false;
          }
        }
        for (int i = activeCol + 1; i < col; i++) {
          if (gameBoard[row][i].piece != ChessPiece.empty) {
            return false;
          }
        }

        return true;
      }
      if (activeCol == col) {
        for (int i = row + 1; i < activeRow; i++) {
          if (gameBoard[i][col].piece != ChessPiece.empty) {
            return false;
          }
        }
        for (int i = activeRow + 1; i < row; i++) {
          if (gameBoard[i][col].piece != ChessPiece.empty) {
            return false;
          }
        }

        return true;
      }

      return false;
    }
    //--------------Legal moves for white and black King---------------//

    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wKing ||
        gameBoard[activeRow][activeCol].piece == ChessPiece.bKing) {


      if (kingLegalMoves(row, col, activeRow, activeCol,
          gameBoard[activeRow][activeCol].pieceColor)) {
        return true;
      }


      return false;
    }

    return true;
  }

  //these two boolean functions below (getWhitePawnKillTarget() and getBlackPawnKillTarget())
  //they check to see if there is an enemy piece 1 diagonal from them, up or down depending if it's
  //white or black to move, if so the function returns a true statement

  bool getWhitePawnKillTarget(int row, int col, int activeRow, int activeCol) {
    if (gameBoard[row][col].pieceColor == PieceColor.black) {
      if (row == activeRow - 1 && col == activeCol - 1 && activeRow == 1) {
        gameBoard[activeRow][activeCol].piece = ChessPiece.wQueen;
        return true;
      } else if (row == activeRow - 1 && col == activeCol + 1 && activeRow == 1) {
        gameBoard[activeRow][activeCol].piece = ChessPiece.wQueen;
        return true;
      }
      if (row == activeRow - 1 && col == activeCol - 1) {
        return true;
      } else if (row == activeRow - 1 && col == activeCol + 1) {
        return true;
      }
    } else {
      return false;
    }
  }
  bool getBlackPawnKillTarget(int row, int col, int activeRow, int activeCol) {
    if (gameBoard[row][col].pieceColor == PieceColor.white) {
      if (row == activeRow + 1 && col == activeCol + 1 && activeRow == 6) {
        gameBoard[activeRow][activeCol].piece = ChessPiece.bQueen;
        return true;
      } else if (row == activeRow + 1 && col == activeCol - 1 && activeRow == 6) {
        gameBoard[activeRow][activeCol].piece = ChessPiece.bQueen;
        return true;
      }
      if (row == activeRow + 1 && col == activeCol + 1) {
        return true;
      } else if (row == activeRow + 1 && col == activeCol - 1) {
        return true;
      }
    } else {
      return false;
    }
  }



  bool kingLegalMoves(
      int row, int col, int activeRow, int activeCol, PieceColor pieceColor) {
    bool isLegal = false;

    //up
    if (row == activeRow - 1 && col == activeCol) {
      isLegal = true;
    }
    //down
    if (row == activeRow + 1 && col == activeCol) {
      isLegal = true;
    }
    //up right
    if (row == activeRow - 1 && col == activeCol + 1) {
      isLegal = true;
    }
    //up left
    if (row == activeRow - 1 && col == activeCol - 1) {
      isLegal = true;
    }
    //left
    if (row == activeRow && col == activeCol - 1) {
      isLegal = true;
    }
    //right
    if (row == activeRow && col == activeCol + 1) {
      isLegal = true;
    }
    //down left
    if (row == activeRow + 1 && col == activeCol - 1) {
      isLegal = true;
    }
    //down right
    if (row == activeRow + 1 && col == activeCol + 1) {
      isLegal = true;
    }
    //this algorithm below allows the kings to castle either king or queen side,
    //they are only allowed to castle if they have not moved and if there are no,
    //pieces between the rook and king
    if (gameBoard[activeRow][activeCol].piece == ChessPiece.wKing) {
      if (activeRow == row && col == activeCol + 2) {
        if (whiteKingHasMoved == false) {
          if (gameBoard[7][5].piece == ChessPiece.empty &&
              gameBoard[7][6].piece == ChessPiece.empty &&
              gameBoard[7][7].piece == ChessPiece.wRook) {
            gameBoard[7][7].piece = ChessPiece.empty;
            gameBoard[7][7].pieceColor = PieceColor.empty;
            gameBoard[7][5].piece = ChessPiece.wRook;
            gameBoard[7][5].pieceColor = PieceColor.white;
            isLegal = true;
          }
        }
      }
      if (activeRow == row && col == activeCol - 2) {
        if (whiteKingHasMoved == false) {
          if (gameBoard[7][3].piece == ChessPiece.empty &&
              gameBoard[7][2].piece == ChessPiece.empty &&
              gameBoard[7][1].piece == ChessPiece.empty &&
              gameBoard[7][0].piece == ChessPiece.wRook) {
            gameBoard[7][0].piece = ChessPiece.empty;
            gameBoard[7][0].pieceColor = PieceColor.empty;
            gameBoard[7][3].piece = ChessPiece.wRook;
            gameBoard[7][3].pieceColor = PieceColor.white;
            isLegal = true;
          }
        }
      }
    }
    if (gameBoard[activeRow][activeCol].piece == ChessPiece.bKing) {
      if (activeRow == row && col == activeCol + 2) {
        if (blackKingHasMoved == false) {
          if (gameBoard[0][5].piece == ChessPiece.empty &&
              gameBoard[0][6].piece == ChessPiece.empty &&
              gameBoard[0][7].piece == ChessPiece.bRook) {
            gameBoard[0][7].piece = ChessPiece.empty;
            gameBoard[0][7].pieceColor = PieceColor.empty;
            gameBoard[0][5].piece = ChessPiece.bRook;
            gameBoard[0][5].pieceColor = PieceColor.black;
            isLegal = true;
          }
        }
      }
      if (activeRow == row && col == activeCol - 2) {
        if (blackKingHasMoved == false) {
          if (gameBoard[0][3].piece == ChessPiece.empty &&
              gameBoard[0][2].piece == ChessPiece.empty &&
              gameBoard[0][1].piece == ChessPiece.empty &&
              gameBoard[0][0].piece == ChessPiece.bRook) {
            gameBoard[0][0].piece = ChessPiece.empty;
            gameBoard[0][0].pieceColor = PieceColor.empty;
            gameBoard[0][3].piece = ChessPiece.bRook;
            gameBoard[0][3].pieceColor = PieceColor.black;
            isLegal = true;
          }
        }
      }
    }


    //If everything is legal above and the king is about to move,
    //then these statement below tell the program that the king has moved,
    // and therefor the king cannot castle
    if (pieceColor == PieceColor.white && isLegal == true) {
      whiteKingHasMoved = true;
    }
    if (pieceColor == PieceColor.black && isLegal == true) {
      blackKingHasMoved = true;
    }
    return isLegal;
  }





//the getDiagonal function was by far the challenging function

  bool getDiagonal(
      int row, int col, int activeRow, int activeCol, bool forward) {
    List<ChessPiece> chessPieceDiagList = [];



    List<int> rowCol;
    //the rowColLoop function gives the activeRow and the activeCol a -1 increment,
    //until either one reaches 0, then we get the index of where to start the diagonal loop,
    //to get the other diagonal i just flip the board
    if (!forward) {
      rowCol = rowColLoop(activeRow, 7 - activeCol);
    } else {
      rowCol = rowColLoop(activeRow, activeCol);
    }


    int x = rowCol[0];
    int y = rowCol[1];

    bool isLegal = false;


    //this is where i start adding all of the pieces to the diagonal list,
    //if the location that user is trying to move the piece to has the the right index,
    //then the isLegal boolean becomes true
    while (true) {
      if (forward) {
        chessPieceDiagList.add(gameBoard[x][y].piece);
        if (row == x && col == y) {
          isLegal = true;
        }
      } else {
        chessPieceDiagList.add(gameBoard[x][7 - y].piece);
        if (row == x && 7 - col == y) {
          isLegal = true;
        }
      }

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


    //if the the piece is being moved in the right diagonal then it passes the diagonal list into,
    //another function, check the documentation on the ChecksPieceList function
    if (isLegal == true) {
      if (!checksPieceList(chessPieceDiagList, row, col, activeRow, activeCol,
          gameBoard[activeRow][activeCol].piece)) {
        isLegal = false;
      }
    }

    return isLegal;
  }


  //this function below loops through the diagonal list and checks the pieces,
  //in between the active piece and where it wants to go, if there are no pieces in between,
  //then the move is legal and the function returns a true statement

  bool checksPieceList(List<ChessPiece> diagList, int row, int col,
      int activeRow, int activeCol, ChessPiece activePiece) {
    List<ChessPiece> inBetweenList = [];
    List<ChessPiece> finishedList = [];

    if (row > activeRow) {
      for (int i = 0; i < diagList.length; i++) {
        if (diagList[i] == activePiece) {
          int j = i;
          while (j < diagList.length) {
            inBetweenList.add(diagList[j]);

            j++;
          }

          break;
        }
      }
      for (int i = 0; i < row - activeRow; i++) {
        finishedList.add(inBetweenList[i]);
      }

      for (int i = 1; i < finishedList.length; i++) {
        if (finishedList[i] != ChessPiece.empty) {
          return false;
        }
      }
    }
    if (row < activeRow) {
      for (int i = diagList.length - 1; i >= 0; i--) {
        if (diagList[i] == activePiece) {
          int j = i;
          while (j >= 0) {
            inBetweenList.add(diagList[j]);

            j--;
          }

          break;
        }
      }
      for (int i = 0; i < activeRow - row; i++) {
        finishedList.add(inBetweenList[i]);
      }

      for (int i = 1; i < finishedList.length; i++) {
        if (finishedList[i] != ChessPiece.empty) {
          return false;
        }
      }
    }

    return true;
  }

  List<int> rowColLoop(int activeRow, int activeCol) {
    List<int> rowCol = [];

    while (true) {
      if (activeRow == 0 || activeCol == 0) {
        break;
      }
      if (activeRow > 0) {
        activeRow--;
      } else {
        break;
      }
      if (activeCol > 0) {
        activeCol--;
      } else {
        break;
      }
      if (activeRow == 0 || activeCol == 0) {
        break;
      }
    }
    rowCol.add(activeRow);
    rowCol.add(activeCol);

    return rowCol;
  }
}

class ChessPieceObj {
  //This is the main class for all of the pieces in the list

  ChessPiece piece; //This is used to tell each piece what moves they are allowed to make
  bool isActive; //This boolean is important as it is used to move each piece
  PieceColor
      pieceColor; //This one basically divides the pieces in separate teams of black and white, and of course white pieces can only capture black pieces and vice versa

  ChessPieceObj({this.isActive, this.piece, this.pieceColor});
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

enum PieceColor {
  white,
  black,
  empty,
}

