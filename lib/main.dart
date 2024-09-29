import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:birthdayreminder/persons/person_controller.dart';
import 'package:birthdayreminder/persons/person_repository.dart';
import 'persons/person_screen.dart';
import 'objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectbox = await ObjectBox.create();

  final personRepository = PersonRepository(objectbox.store);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PersonController(personRepository)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Testing'),
        ),
        body: const PersonScreen(),
      ),
    );
  }
}
