import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'di.dart';
import 'presentation/screen/main_screen.dart';

void main() async {
  //инициализация зависимостей
  await DI.initializeDependencies();

  runApp(const ProviderScope(child: MyApp()));
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainBallScreen(),
    );
  }
}
