import 'package:flutter/material.dart';
import 'package:test_odc/add_place.dart';
import 'package:test_odc/shared_preferences.dart';

import 'db_helper.dart';
import 'home.dart';
import 'login_screen.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesDB.createSharedPreferenceDb();
  objectbox = await ObjectBox.create();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  Map<String, WidgetBuilder> routes = {
    "/":(context)=>LoginScreen(),
    "/home":(context)=>MyFavPlacesScreen(),
    "/addPlace":(context)=>const AddPlace()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'MyFavPlace',
    );
  }
}
