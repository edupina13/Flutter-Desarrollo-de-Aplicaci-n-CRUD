// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/auto_repository.dart';
import 'presentation/cubit/auto_cubit.dart'; // Asegúrate de que esta ruta sea correcta
import 'presentation/screens/auto_get_all_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AutoRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AutoCubit(
              autoRepository: RepositoryProvider.of<AutoRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Auto CRUD',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: AutoGetAllScreen(),
        ),
      ),
    );
  }
}