import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:birthdayreminder/persons/person_controller.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return PersonScreenState();
  }
}

class PersonScreenState extends State<PersonScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController databornController = TextEditingController();

  String? validationForm(value) {
    if (value == null || value.isEmpty) {
      return 'Заполните поле';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              controller: nameController,
              validator: (value) => validationForm(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Имя',
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              controller: middlenameController,
              validator: (value) => validationForm(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Отчество',
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              controller: surnameController,
              validator: (value) => validationForm(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Фамилию',
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              controller: databornController,
              validator: (value) => validationForm(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Дата рождения',
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 200,
            child: TextFormField(
              controller: descriptionController,
              validator: (value) => validationForm(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Описание',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final personController =
                    Provider.of<PersonController>(context, listen: false);

                personController.createCard(
                  nameController.text,
                  surnameController.text,
                  middlenameController.text,
                  DateTime.parse(databornController.text),
                  descriptionController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Карточка сохранена'),
                  ),
                );

                nameController.clear();
                surnameController.clear();
                middlenameController.clear();
                databornController.clear();
                descriptionController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Что-то пошло не так')),
                );
              }
            },
            child: const Text('Создать карточку'),
          ),
        ],
      ),
    );
  }
}
