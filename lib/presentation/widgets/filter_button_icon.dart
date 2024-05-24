import 'package:flutter/material.dart';
import 'package:wordapp/presentation/widgets/filter_dialog_words.dart';

class FilterButtonIcon extends StatelessWidget {
  const FilterButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const FilterWordsDialog();
          },
        );
      },
      icon: const Icon(Icons.filter_list),
    );
  }
}
