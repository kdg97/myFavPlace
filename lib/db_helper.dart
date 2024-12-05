import 'package:objectbox/objectbox.dart';
import 'package:test_odc/place.dart';
import 'objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';



class ObjectBox {

  static late Store store;

  ObjectBox._create(store){
    ObjectBox.store = store;
  }
   // Add any additional setup code, e.g. build queries.

 static Future<ObjectBox> create() async {
   final docsDir = await getApplicationDocumentsDirectory();
   // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
   final store = await openStore(directory: p.join(docsDir.path, "db-place"));
   return ObjectBox._create(store);
 }

  static Future<void> savePlace(Place place) async {
     final box = ObjectBox.store.box<Place>();
     final id = box.put(place);
     print(id);
  }
  static Place getPlace(int id)  {
    final box = ObjectBox.store.box<Place>();
    Place place = box.get(id)!;
    return place;
  }

  static List<Place> getAllPlaces(){
    final query = ObjectBox.store.box<Place>();
    final List<Place> places = query.getAll();
    return places;
  }



}