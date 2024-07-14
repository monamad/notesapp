import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/logic/write_cubit/write_word_cubit.dart';
import 'package:wordapp/models/word_model/word.dart';
import 'package:wordapp/presentation/widgets/add_button.dart';
import 'package:wordapp/presentation/widgets/add_new_data_to_word.dart';
import 'package:wordapp/presentation/widgets/excption_widget.dart';
import 'package:wordapp/presentation/widgets/in_word_section.dart';
import 'package:wordapp/presentation/widgets/loding_indecator.dart';

class WordDetails extends StatefulWidget {
  final Word word;
  const WordDetails({super.key, required this.word});

  @override
  State<WordDetails> createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  late Word word;
  @override
  void initState() {
    super.initState();
    word = widget.word;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(word.color),
        centerTitle: true,
        title: const Text('Word Details'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Color(word.color),
            ),
            onPressed: () => _removeWord(context, word.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: BlocBuilder<GetWordCubit, GetWordState>(
          builder: (context, state) {
            if (state is GetWordLoaded) {
              int index =
                  state.words.indexWhere((element) => element.id == word.id);
              word = state.words[index];
              return _successState(context);
            } else if (state is GetWordfailed) {
              return const ExcptionWidget(
                  icondata: Icons.error, message: 'Failed to load word data');
            } else {
              return const LoadingIndicator();
            }
          },
        ),
      ),
    );
  }

  ListView _successState(BuildContext context) {
    return ListView(
      children: [
        showWord(),
        const SizedBox(
          height: 20,
        ),
        showSection(
          label: 'similar words',
          isExample: false,
          context: context,
        ),
        const SizedBox(
          height: 20,
        ),
        showSection(
          label: 'Examples',
          context: context,
          isExample: true,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget showWord() {
    return Column(
      children: [
        sectionLabel('word'),
        InWordSection(
          text: word.theWord,
          isarabic: word.isarabic,
          color: word.color,
        ),
      ],
    );
  }

  Widget showSection(
      {required String label, required bool isExample, context}) {
    return Column(
      children: [
        Row(
          children: [
            sectionLabel(label),
            const Spacer(),
            AddButton(
                color: word.color, onTap: () => _addnewdata(isExample, context))
          ],
        ),
        Column(
          children: (isExample)
              ? showSectiondata(
                  word.arexpamples, word.engexpamples, context, 'Examples')
              : showSectiondata(word.arsimilarWords, word.engsimilarWords,
                  context, 'similar words'),
        ),
      ],
    );
  }

  Widget showExampleSection(context) {
    return Column(
      children: [
        Row(
          children: [
            sectionLabel('Examples'),
            const Spacer(),
            AddButton(
              color: word.color,
              onTap: () => _addnewdata(true, context),
            )
          ],
        ),
        Column(
          children: showSectiondata(
              word.arexpamples, word.engexpamples, context, 'Examples'),
        ),
      ],
    );
  }

  List<Widget> showSectiondata(
    List<String> arsectiondata,
    List<String> ensectiondata,
    context,
    sectionname,
  ) {
    List<Widget> sectionWidgets = [];
    for (int i = 0; i < arsectiondata.length; i++) {
      sectionWidgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 12),
        child: InWordSection(
            text: arsectiondata[i],
            isarabic: true,
            color: word.color,
            removeword: createRemovewordFunction(true, sectionname, i)),
      ));
    }

    for (int i = 0; i < ensectiondata.length; i++) {
      sectionWidgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 12),
        child: InWordSection(
            text: ensectiondata[i],
            isarabic: false,
            color: word.color,
            removeword: createRemovewordFunction(false, sectionname, i)),
      ));
    }
    return sectionWidgets;
  }

  void Function() createRemovewordFunction(bool isArabic, sectionname, int i) {
    return () {
      if (sectionname == 'Examples') {
        WriteCubit.get(context).deleteExample(word.id, i, isArabic);
      } else {
        WriteCubit.get(context).deleteSimilarWord(word.id, i, isArabic);
      }
      GetWordCubit.get(context).getWords();
    };
  }

  Text sectionLabel(String text) {
    return Text(text,
        style: TextStyle(
          fontSize: 25,
          color: Color(word.color),
        ));
  }

  void _removeWord(context, id) {
    WriteCubit.get(context).deleteWord(id);
    Navigator.pop(context);
  }

  void _addnewdata(bool isExample, context) {
    showDialog(
        context: context,
        builder: (_) {
          return AddNewDateToWord(
            wordIndex: word.id,
            isExample: isExample,
            color: word.color,
          );
        });
  }
}
