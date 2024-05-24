import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/presentation/widgets/custom_box.dart';

class FilterWordsDialog extends StatelessWidget {
  const FilterWordsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWordCubit, GetWordState>(
      builder: (context, state) => Dialog(
          shape: const RoundedRectangleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _labelText('Language'),
                _getLanguageFilter(context),
                _labelText('Sorted by'),
                _getSortedbyFilter(context),
                _labelText('Sort type'),
                _getSortTypefilter(context),
              ],
            ),
          )),
    );
  }

  Widget _getSortTypefilter(BuildContext context) {
    return _getFillerField(items: [
      'Ascending',
      'Descending'
    ], isSelected: [
      GetWordCubit.get(context).sortorder == Sortorder.ascending,
      GetWordCubit.get(context).sortorder == Sortorder.descending
    ], ontap: [
      () {
        GetWordCubit.get(context).setSortorder(Sortorder.ascending);
      },
      () {
        GetWordCubit.get(context).setSortorder(Sortorder.descending);
      }
    ]);
  }

  Widget _getSortedbyFilter(BuildContext context) {
    return _getFillerField(items: [
      'Time',
      'Word Length'
    ], isSelected: [
      GetWordCubit.get(context).sortedby == Sortedby.time,
      GetWordCubit.get(context).sortedby == Sortedby.wordLength
    ], ontap: [
      () {
        GetWordCubit.get(context).setSortedby(Sortedby.time);
      },
      () {
        GetWordCubit.get(context).setSortedby(Sortedby.wordLength);
      }
    ]);
  }

  Widget _getLanguageFilter(BuildContext context) {
    return _getFillerField(
      items: ['Arabic', 'English', 'All'],
      isSelected: [
        GetWordCubit.get(context).languagefilter == Languagefilter.arabic,
        GetWordCubit.get(context).languagefilter == Languagefilter.english,
        GetWordCubit.get(context).languagefilter == Languagefilter.all
      ],
      ontap: [
        () {
          GetWordCubit.get(context).setLanguageFilter(Languagefilter.arabic);
        },
        () {
          GetWordCubit.get(context).setLanguageFilter(Languagefilter.english);
        },
        () {
          GetWordCubit.get(context).setLanguageFilter(Languagefilter.all);
        }
      ],
    );
  }

  Widget _getFillerField(
      {required List<String> items,
      required List<VoidCallback> ontap,
      required List<bool> isSelected}) {
    return Row(
      children: items.asMap().entries.map((entry) {
        int index = entry.key;
        String item = entry.value;
        return CustomBox(
          text: item.characters.first.toUpperCase() + item.substring(1),
          isSelected: isSelected[index],
          ontap: ontap[index],
        );
      }).toList(),
    );
  }

  Text _labelText(text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
