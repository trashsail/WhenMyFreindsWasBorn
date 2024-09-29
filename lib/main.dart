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
        title: const Text('Создание карточки'),
      ),
      body: const Center(
        child: PersonScreen(),
      ),
    ));
  }
}

//scaffold, material, materialApp, cupertino
class CallbackForm extends StatefulWidget {
  const CallbackForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return CallbackFormState(); // что это я сделал
  }
}

class CallbackFormState extends State<CallbackForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final numberPattern = RegExp(r'^[]$');
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Заполните поле';
                } else if (value.length > 50) {
                  return 'Поле не может быть больше 50 символов';
                } else {
                  return null;
                }
              },
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Заполните поле';
                } else if (!emailPattern.hasMatch(value)) {
                  return 'Введите корректный email';
                } else {
                  return null;
                }
              },
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Заполните поле';
                } else if (value.length >= 250) {
                  return 'Введите не больше 250 символов';
                } else {
                  return null;
                }
              },
              controller: messageController,
              decoration: const InputDecoration(
                labelText: 'Сообщение',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              controller: numberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Заполните поле';
                } else if (value.length > 10) {
                  return 'Неправильный номер';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Телефон',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Сообщение отправлено'),
                  ),
                );
              }
            },
            child: const Text('Отправить'),
          ),
        ],
      ),
    );
  }
}
