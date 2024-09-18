import '/objectbox.g.dart';
import '/models/person_model.dart';

class PersonRepository {
  final Store _store;

  PersonRepository(this._store);

//добавляем новую запись
  void addPerson(Person person) {
    final box = _store.box<Person>();

    box.put(person);
  }

//получаем день рождения
  List<Person> getPersonBirthday(int day, int month) {
    final box = _store.box<Person>();

    final query = box
        .query(
            Person_.dayOfBirth.equals(day) & Person_.monthOfBirth.equals(month))
        .build();

    final mathcingPersons = query.find();

    query.close();

    return mathcingPersons;
  }

//получаем все карточки

  List<Person> getAllPersons(Person person) {
    final box = _store.box<Person>();

    return box.getAll();
  }

//удаляем карточку

  void deleteCardPerson(Person person) {
    final box = _store.box<Person>();

    box.remove(person.id);
  }

// изменение карточки

  void updatePersonCard(Person updatePerson) {
    final box = _store.box<Person>();

    var personFromDb = box.get(updatePerson.id);

    if (personFromDb != null) {
      personFromDb.name = updatePerson.name;
      personFromDb.surname = updatePerson.surname;
      personFromDb.middlename = updatePerson.middlename;
      personFromDb.description = updatePerson.description;
      personFromDb.dayOfBirth = updatePerson.dayOfBirth;
      personFromDb.monthOfBirth = updatePerson.monthOfBirth;
      personFromDb.yearOfBirth = updatePerson.yearOfBirth;
      box.put(personFromDb);
    }
  }
}
