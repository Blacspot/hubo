// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hubo/piece.dart';
import 'package:hubo/pixel.dart';
import 'package:hubo/values.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {


 Piece currentPiece = Piece(type: Tetromino.T);

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
        currentPiece.movePiece(Direction.down);
      });
    }
  );
 }

 bool checkCollision(Direction direction) {
  for (int i = 0; i < currentPiece.position.length; i++) {
  }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowLength * collength,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowLength),
         itemBuilder: (context, index) {
          if (currentPiece.position.contains(index)) {
         return Pixel(
          color: Colors.yellow,
         child: index,
         );
          } else {
            return Pixel(
              color: Colors.grey[900],
              child: index,
            );
          }
         },
         ),
    );
  }
}