import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/logic/write_cubit/write_cubit_cubit.dart';
import 'package:wordapp/presentation/widgets/color_widget.dart';
import 'package:wordapp/presentation/widgets/costum_form.dart';
import 'package:wordapp/presentation/widgets/done_button.dart';
import 'package:wordapp/presentation/widgets/selected_language_widget.dart';

class AddNewWordDialog extends StatefulWidget {
  const AddNewWordDialog({super.key});

  @override
  State<AddNewWordDialog> createState() => _CustomAlartDialogState();
}

class _CustomAlartDialogState extends State<AddNewWordDialog> {
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            color: Color(WriteCubit.get(context).color),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectedLanguageWidget(
                    isArabic: WriteCubit.get(context).isarabic,
                    backgroundColorCodes: WriteCubit.get(context).color),
                ColorWidget(selectedColor: WriteCubit.get(context).color),
                CostumForm(
                  formKey: formKey,
                  label: 'New Word',
                ),
                DoneButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      WriteCubit.get(context).addWord();
                    }
                  },
                ),
              ],
            ),
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
