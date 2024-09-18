import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  @Id()
  int id = 0;

  String name = '';
  String surname = '';
  String middlename = '';
  String description = '';

  int dayOfBirth = 0;
  int monthOfBirth = 0;
  int yearOfBirth = 0;
}
