import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'All words',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: gridViewBuilder(context),
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton addNewNote(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/addWord');
      },
      child: const Icon(Icons.add),
    );
  }

  Widget gridViewBuilder(context) {
    return BlocBuilder<GetWordCubit, GetWordState>(builder: (context, state) {
      if (state is GetWordLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetWordLoaded) {
        return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: MediaQuery.of(context).size.width / 300,
              crossAxisCount: 2,
            ),
            children: (state.words.map((e) => Card(
                  child: Column(
                    children: [
                      Text(e.theWord),
                      Text(e.isarabic.toString()),
                      Text(e.engexpamples.toString()),
                    ],
                  ),
                ))).toList());
      } else {
        return const Center(
          child: Text('Error'),
        );
      }
    });
  }
}
