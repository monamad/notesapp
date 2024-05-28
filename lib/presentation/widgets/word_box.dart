import 'package:flutter/material.dart';
import 'package:wordapp/models/word_model/word.dart';

class WordBox extends StatelessWidget {
  final Word word;

  const WordBox({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(word.color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            word.theWord,
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
