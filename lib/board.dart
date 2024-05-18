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

  int rowLength = 10;
  int collength = 15;

 Piece currentPiece = Piece(type: Tetromino.L);

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