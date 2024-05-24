import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wordapp/constans.dart';
import 'package:wordapp/logic/get_cubit/get_word_cubit.dart';
import 'package:wordapp/logic/write_cubit/write_cubit_cubit.dart';

import 'package:wordapp/models/word_model/word_adapter.dart';
import 'package:wordapp/presentation/styles/themes_manger.dart';
import 'package:wordapp/presentation/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<List>(savedwords);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WriteCubit()),
        BlocProvider(
          create: (context) => GetWordCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemesManager.appTheme(),
        home: HomeView(),
      ),
    );
  }
}
