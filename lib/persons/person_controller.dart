import 'package:flutter/material.dart';

import '../models/person_model.dart';
import 'person_repository.dart';

class PersonController extends ChangeNotifier {
  final PersonRepository personRepository;

  PersonController(this.personRepository);

  //карточка для создания
  void createCard(
    String name,
    String? surname,
    String? middlename,
    DateTime databorn,
    String? description,
  ) {
    var person = Person();
    person.name = name;
    person.surname = surname ?? '';
    person.middlename = middlename ?? '';
    person.dayOfBirth = databorn.day;
    person.monthOfBirth = databorn.month;
    person.yearOfBirth = databorn.year;
    person.description = description ?? '';

    personRepository.addPerson(person);
    notifyListeners();
  }

  //изменение карточки
  void updateCard(
    int id,
    String name,
    String? surname,
    String? middlename,
    DateTime databorn,
    String? description,
  ) {
    var person = Person();
    person.id = id;
    person.name = name;
    person.surname = surname ?? '';
    person.middlename = middlename ?? '';
    person.dayOfBirth = databorn.day;
    person.monthOfBirth = databorn.month;
    person.yearOfBirth = databorn.year;
    person.description = description ?? '';

    personRepository.updatePersonCard(person);
    notifyListeners();
  }

  //удаление карточки
  void deleteCard(Person person) {
    personRepository.deleteCard(person);
    notifyListeners();
  }

  //удаление карточек
  void deleteAllCards(Person person) {
    personRepository.deleteAllCards();
    notifyListeners();
  }
}
