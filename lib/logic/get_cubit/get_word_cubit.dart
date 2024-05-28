import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordapp/constans.dart';
import 'package:wordapp/models/word_model/word.dart';
part 'get_word_state.dart';

class GetWordCubit extends Cubit<GetWordState> {
  static GetWordCubit get(context) => BlocProvider.of(context);
  GetWordCubit() : super(GetWordInitial());

  final box = Hive.box<List>(savedwords);

  Languagefilter languagefilter = Languagefilter.all;
  Sortedby sortedby = Sortedby.time;
  Sortorder sortorder = Sortorder.descending;
  void setLanguageFilter(Languagefilter languagefilter) {
    this.languagefilter = languagefilter;
    getWords();
  }

  void setSortedby(Sortedby sortedby) {
    this.sortedby = sortedby;
    getWords();
  }

  void setSortorder(Sortorder sortorder) {
    this.sortorder = sortorder;
    getWords();
  }

  void getWords() async {
    try {
      emit(GetWordLoading());
      final List<dynamic> words =
          List.from(box.get(savedwords, defaultValue: [])!);

      emit(GetWordLoaded(_applAllfilters(words.cast<Word>())));
    } catch (e) {
      emit(GetWordfailed('Failed to load words'));
    }
  }

  List<Word> _applyLanguageFilter(List<Word> words) {
    if (languagefilter == Languagefilter.all) {
      return words;
    } else {
      bool isFilterdArbic = languagefilter == Languagefilter.arabic;
      return words
          .where((element) => element.isarabic == isFilterdArbic)
          .toList();
    }
  }

  List<Word> _applySortedby(List<Word> words) {
    if (sortedby == Sortedby.wordLength) {
      words.sort((a, b) => a.theWord.length.compareTo(b.theWord.length));
    }
    return _applySortorder(words);
  }

  List<Word> _applAllfilters(List<Word> words) {
    words = _applyLanguageFilter(words);
    words = _applySortedby(words);
    return words;
  }

  List<Word> _applySortorder(List<Word> words) {
    if (sortorder == Sortorder.ascending) {
      return words.reversed.toList();
    }
    return words;
  }
}

enum Languagefilter { english, arabic, all }

enum Sortedby { time, wordLength }

enum Sortorder { ascending, descending }
