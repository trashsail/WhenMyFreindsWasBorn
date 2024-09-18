import 'package:flutter/material.dart';
import '/objectbox.g.dart';
import 'dart:core';
import '../models/person_model.dart';

class BirthdayReminderModel extends ChangeNotifier {
  final Store _store;

  String name = '';

  String? surname;

  String? middlename;

  String? description;

  DateTime databorn;

  BirthdayReminderModel(
    this._store,
    this.name,
    this.databorn, {
    this.description,
    this.surname,
    this.middlename,
  });

//карточка для создания

  void createCard() {
    var person = Person();

    person.name = name;

    person.surname = surname ?? '';

    person.middlename = middlename ?? '';

    person.dayOfBirth = databorn.day;

    person.monthOfBirth = databorn.month;

    person.yearOfBirth = databorn.year;

    person.description = description ?? '';

    final box = _store.box<Person>();

    box.put(person); //добавляем запись в бд

    notifyListeners();
  }

  void getDataFromDb() {
    DateTime now = DateTime.now();

    int todayDay = now.day;

    int todayMonth = now.month;

    final box = _store.box<Person>();

    final query = box
        .query(Person_.dayOfBirth.equals(todayDay) &
            Person_.monthOfBirth.equals(todayMonth))
        .build();

    final matchingPersons = query.find();

    query.close();

    if (matchingPersons.isEmpty) {
      return;
    } else {
      compareDate(matchingPersons);
    }
  }

  int _calculateAge(DateTime birthDate) {
    DateTime now = DateTime.now();

    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

//функция сравнения дат

  void compareDate(List<Person> persons) {
    for (var person in persons) {
      DateTime birthDate = DateTime(
        person.yearOfBirth,
        person.monthOfBirth,
        person.dayOfBirth,
      );

      int age = _calculateAge(birthDate);
    }

    void rewriteCard() {
      var person = Person();
    }
  }
}
