// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hubo/piece.dart';
import 'package:hubo/pixel.dart';
import 'package:hubo/values.dart';


List<List<Tetromino?>>  gameBoard = List.generate(
  collength,
   (i) => List.generate(
     rowLength,
     
     (j) => null,
   ),
   );

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {


 Piece currentPiece = Piece(type: Tetromino.L);

 @override
 void initState(){
  super.initState();

  startGame();
 }

 void startGame() {
  currentPiece.initializePiece();

  Duration frameRate = Duration(milliseconds: 800);
  gameLoop(frameRate);
 }

 void gameLoop(Duration frameRate) {
  Timer.periodic(
    frameRate,
    (timer) {
      setState(() {

        checkLanding();

        currentPiece.movePiece(Direction.down);
      });
    }
  );
 }

 bool checkCollision(Direction direction) {
  for (int i = 0; i < currentPiece.position.length; i++) {
  
  int row = (currentPiece.position[i] / rowLength).floor();
  int col = currentPiece.position[i] % rowLength;

  if (direction == Direction.left) {
    col -= 1;

  }else if(direction == Direction.right) {
    col += 1;
  }else if (direction == Direction.down) {
   row += 1;
 }
   
   if (row >= collength || col < 0 || col >= rowLength) {
     return true;
  }
  }
 return false;
 }

void checkLanding(){

  if (checkCollision(Direction.down)) {

    for (int i = 0; i < currentPiece.position.length; i++) {

    int row = (currentPiece.position[i] / rowLength).floor();
    int col = currentPiece.position[i] % rowLength;
    if (row>=0 && col>=0){
      gameBoard[row][col] = currentPiece.type;
    }
    }
    createNewPiece();
  }
}

void createNewPiece(){
   
   Random rand = Random();

   Tetromino randomType = 
       Tetromino.values[rand.nextInt(Tetromino.values.length)];
       currentPiece = Piece(type: randomType);
       currentPiece.initializePiece();
}

void moveLeft(){
  if (!checkCollision(Direction.left)) {
    setState(() {
      currentPiece.movePiece(Direction.left);
    });
  }
}

void moveRight(){
    if (!checkCollision(Direction.right)) {
    setState(() {
      currentPiece.movePiece(Direction.right);
    });
  }

}

void rotatePiece(){
  setState(() {
    currentPiece.rotatePiece();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * collength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength),
               itemBuilder: (context, index) {
            
                 int row = (index/ rowLength).floor();
                 int col = index % rowLength;
            
                if (currentPiece.position.contains(index)) {
               return Pixel(
                color: currentPiece.color,
               child: index,
               );
                }
                
                else if (gameBoard[row][col] != null ){
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(color: tetrominoColors[tetrominoType], child:'');
                }
            
            
                 else {
                  return Pixel(
                    color: Colors.grey[900],
                    child: index,
                  );
                }
               },
               ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            
                IconButton(
                  onPressed: moveLeft,
                  color:Colors.white,
                   icon: Icon(Icons.arrow_back_ios)),
            
                IconButton(
                  onPressed: rotatePiece,
                   color:Colors.white,
                   icon: Icon(Icons.rotate_right)),
            
                IconButton(
                  onPressed: moveRight,
                   color:Colors.white,
                   icon: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
