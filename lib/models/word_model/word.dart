class Word {
  final String theWord;
  final int id;
  final int color;
  final bool isarabic;
  final List<String> arsimilarWords;
  final List<String> engsimilarWords;
  final List<String> arexpamples;
  final List<String> engexpamples;
  Word({
    required this.id,
    required this.color,
    required this.theWord,
    required this.isarabic,
    this.arexpamples = const [],
    this.engexpamples = const [],
    this.arsimilarWords = const [],
    this.engsimilarWords = const [],
  });

  Word decrementId() {
    return Word(
        id: id - 1,
        color: color,
        theWord: theWord,
        isarabic: isarabic,
        arsimilarWords: arsimilarWords,
        engsimilarWords: engsimilarWords,
        arexpamples: arexpamples,
        engexpamples: engexpamples);
  }

  Word addExapmle(String example, bool isarabic) {
    List<String> newExapmle = _intializeNewExample(isarabic);

    newExapmle.add(example);

    return _returnNewExapmle(isarabic, newExapmle);
  }

  Word deletesimilarWord(int wordid, isarabic) {
    List<String> newsimilarWords = _intializeNewSimilarWords(isarabic);
    newsimilarWords.removeAt(wordid);
    return _returnNewSimilarWord(isarabic, newsimilarWords);
  }

  Word addsimilarWord(String similarWord, bool isarabic) {
    List<String> newsimilarWords =
        _intializeNewSimilarWords(isarabic); //with old data
    newsimilarWords.add(similarWord);
    return _returnNewSimilarWord(isarabic, newsimilarWords);
  }

  Word _returnNewSimilarWord(bool isarabic, List<String> newsimilarWords) {
    return Word(
        id: id,
        color: color,
        theWord: theWord,
        isarabic: this.isarabic,
        arsimilarWords: (isarabic) ? newsimilarWords : arsimilarWords,
        engsimilarWords: (isarabic) ? engsimilarWords : newsimilarWords,
        arexpamples: arexpamples,
        engexpamples: engexpamples);
  }

  Word deleteExapmle(int wordind, isarabic) {
    List<String> newExapmle = _intializeNewExample(isarabic);
    newExapmle.removeAt(wordind);
    return _returnNewExapmle(isarabic, newExapmle);
  }

  List<String> _intializeNewSimilarWords(bool isarabic) {
    if (isarabic) {
      return List.from(arsimilarWords);
    } else {
      return List.from(engsimilarWords);
    }
  }

  List<String> _intializeNewExample(
    bool isarabic,
  ) {
    if (isarabic) {
      return List.from(arexpamples);
    } else {
      return List.from(engexpamples);
    }
  }

  Word _returnNewExapmle(bool isarabic, List<String> newExapmle) {
    return Word(
        id: id,
        color: color,
        theWord: theWord,
        isarabic: this.isarabic,
        arsimilarWords: arsimilarWords,
        engsimilarWords: engsimilarWords,
        arexpamples: (isarabic) ? newExapmle : arexpamples,
        engexpamples: (isarabic) ? engexpamples : newExapmle);
  }
}
