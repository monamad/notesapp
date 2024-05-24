import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/presentation/widgets/filter_button_icon.dart';

class LanguageFilter extends StatelessWidget {
  const LanguageFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWordCubit, GetWordState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${GetWordCubit.get(context).languagefilter.name.characters.first.toUpperCase() + GetWordCubit.get(context).languagefilter.name.substring(1)} Words ',
                  style: const TextStyle(fontSize: 30),
                ),
                const FilterButtonIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
