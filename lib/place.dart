

import 'package:objectbox/objectbox.dart';

@Entity()
class Place {
  @Id()
  int id = 0;
  String name;
  String country;
  String city;
  String category;
  String note;
  String desc;
  String imagePath;
  int timestamps;

  Place({required this.name,
    required this.country,required this.city,
    required this.note,required this.desc,required this.category,
  required this.imagePath,required this.timestamps});
}