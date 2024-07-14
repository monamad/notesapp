import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/logic/write_cubit/write_word_cubit.dart';
import 'package:wordapp/presentation/widgets/costum_form.dart';
import 'package:wordapp/presentation/widgets/done_button.dart';
import 'package:wordapp/presentation/widgets/selected_language_widget.dart';

class AddNewDateToWord extends StatefulWidget {
  final int color;
  final bool isExample;
  final int wordIndex;
  const AddNewDateToWord(
      {super.key,
      required this.color,
      required this.isExample,
      required this.wordIndex});

  @override
  State<AddNewDateToWord> createState() => _AddNewDateToWordState();
}

class _AddNewDateToWordState extends State<AddNewDateToWord> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteCubit, WriteCubitState>(
      listener: (context, state) {
        if (state is WriteCubitLoaded) {
          Navigator.pop(context);
        } else if (state is WriteCubitFailed) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Dialog(
          child: Container(
            color: Color(widget.color),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SelectedLanguageWidget(
                  isArabic: WriteCubit.get(context).isarabic,
                  backgroundColorCodes: widget.color),
              CostumForm(
                formKey: formKey,
                label: (widget.isExample) ? 'New example' : 'New Similar Word',
              ),
              DoneButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      (widget.isExample)
                          ? WriteCubit.get(context).addExample(widget.wordIndex)
                          : WriteCubit.get(context)
                              .addSimilarWord(widget.wordIndex);
                      GetWordCubit.get(context).getWords();
                    }
                  },
                  color: widget.color)
            ]),
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }
}
