import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/models/word_model/word.dart';
import 'package:wordapp/presentation/widgets/excption_widget.dart';
import 'package:wordapp/presentation/widgets/loding_indecator.dart';
import 'package:wordapp/presentation/widgets/word_box.dart';

class WordsGrid extends StatelessWidget {
  const WordsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWordCubit, GetWordState>(builder: (context, state) {
      if (state is GetWordfailed) {
        return _erorrWidget(state.error);
      } else if (state is GetWordLoaded) {
        if (state.words.isEmpty) {
          return _emptyWidget();
        }
        return _wordsGridWidget(context, state.words);
      } else {
        return _lodingWidget();
      }
    });
  }

  Widget _emptyWidget() {
    return const ExcptionWidget(
      icondata: Icons.hourglass_empty,
      message: 'No words found',
    );
  }

  Widget _erorrWidget(error) {
    return ExcptionWidget(
      icondata: Icons.error,
      message: error,
    );
  }

  GridView _wordsGridWidget(BuildContext context, List<Word> words) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width / 300,
          crossAxisCount: 2,
        ),
        itemCount: words.length,
        itemBuilder: (context, index) {
          return WordBox(
            word: words[index],
          );
        });
  }

  Widget _lodingWidget() {
    return const LoadingIndicator();
  }
}
