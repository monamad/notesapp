import 'package:flutter/material.dart';

import 'package:wordapp/presentation/widgets/add_new_word.dart';
import 'package:wordapp/presentation/widgets/language_filter.dart';
import 'package:wordapp/presentation/widgets/words_grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addNewNote(context),
      appBar: AppBar(
        title: const Text('Word App'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          LanguageFilter(),
          Expanded(child: WordsGrid()),
        ],
      ),
    );
  }

  FloatingActionButton addNewNote(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddNewWordDialog();
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
