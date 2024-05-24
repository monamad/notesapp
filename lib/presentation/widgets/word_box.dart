import 'package:flutter/material.dart';

class WordBox extends StatelessWidget {
  final int color;
  final String word;

  const WordBox({super.key, required this.color, required this.word});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'word ',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
