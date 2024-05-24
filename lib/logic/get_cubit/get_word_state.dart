part of '../get_cubit/get_word_cubit.dart';

@immutable
sealed class GetWordState {}

final class GetWordInitial extends GetWordState {}

final class GetWordLoading extends GetWordState {}

final class GetWordLoaded extends GetWordState {
  final List<Word> words;
  GetWordLoaded(this.words);
}

final class GetWordfailed extends GetWordState {
  final String error;
  GetWordfailed(this.error);
}
