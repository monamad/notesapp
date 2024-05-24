import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wordapp/constans.dart';
import 'package:wordapp/models/word_model/word.dart';

part 'write_cubit_state.dart';

class WriteCubit extends Cubit<WriteCubitState> {
  static WriteCubit get(context) => BlocProvider.of(context);

  final box = Hive.box<List>(savedwords);
  String inputtext = '';
  bool isarabic = false;
  int color = 0xFF008000;

  WriteCubit() : super(WriteCubitInitial());
  void updateWord(String theWord) {
    inputtext = theWord;
  }

  void updateColor(int color) {
    this.color = color;
    emit(WriteCubitInitial());
  }

  void updateIsArabic(bool isarabic) {
    this.isarabic = isarabic;
    emit(WriteCubitInitial());
  }

  void addWord() {
    _tryAndCatchBlock(() {
      List<Word> words = getWordsFromDatabase();
      words.add(Word(
        id: words.length,
        color: color,
        theWord: inputtext,
        isarabic: isarabic,
      ));
      box.put(savedwords, words);
    });
  }

  void deleteWord(int index) {
    _tryAndCatchBlock(() {
      List<Word> words = getWordsFromDatabase();
      words.removeAt(index);
      for (int i = index; i < words.length; i++) {
        words[i] = words[i].decrementId();
      }
      box.put(savedwords, words);
    });
  }

  void addSimilarWord(int wordIndex) {
    _tryAndCatchBlock(() {
      List<Word> words = getWordsFromDatabase();
      words[wordIndex] = words[wordIndex].addsimilarWord(inputtext, isarabic);
      box.put(savedwords, words);
    });
  }

  void deleteSimilarWord(
      int wordIndex, int similarWordIndex, isarabicsimilarWord) {
    _tryAndCatchBlock(() {
      List<Word> words = getWordsFromDatabase();
      words[wordIndex] = words[wordIndex]
          .deletesimilarWord(similarWordIndex, isarabicsimilarWord);
      box.put(savedwords, words);
    });
  }

  void addExample(int wordIndex, isarabicsimilarWord) {
    _tryAndCatchBlock(() {
      List<Word> words = getWordsFromDatabase();
      words[wordIndex] =
          words[wordIndex].addExapmle(inputtext, isarabicsimilarWord);
      box.put(savedwords, words);
    });
  }

  void deleteExample(int wordIndex, int exampleIndex) {
    _tryAndCatchBlock(() {
      List<Word> words = getWordsFromDatabase();
      words[wordIndex] = words[wordIndex].deleteExapmle(exampleIndex, isarabic);
      box.put(savedwords, words);
    });
  }

  void _tryAndCatchBlock(VoidCallback function) {
    emit(WriteCubitLoading());
    try {
      function.call();
      emit(WriteCubitLoaded());
    } catch (e) {
      emit(WriteCubitFailed(e.toString()));
    }
  }

  List<Word> getWordsFromDatabase() {
    List<Word> words =
        List.from(box.get(savedwords, defaultValue: [])!.cast<Word>());
    return words;
  }
}
