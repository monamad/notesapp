import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/presentation/widgets/add_new_word.dart';
import 'package:wordapp/presentation/widgets/language_filter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetWordCubit>(context).getWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addNewNote(context),
      appBar: AppBar(
        title: const Text('Word App'),
        centerTitle: true,
      ),
      body: const LanguageFilter(),
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
