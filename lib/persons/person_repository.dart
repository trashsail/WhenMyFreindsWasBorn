import '/objectbox.g.dart';
import '/models/person_model.dart';

class PersonRepository {
  final Store _store;

  PersonRepository(this._store);

  //добавляем новую запись, а в контроллере описываем, что конкретно добавляем
  void addPerson(Person person) {
    final box = _store.box<Person>();
    box.put(person);
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

  //удаляем карточку
  void deleteCard(Person person) {
    final box = _store.box<Person>();
    box.remove(person.id);
  }

  void deleteAllCards() {
    final box = _store.box<Person>();
    box.removeAll();
  }
}
