

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDB {

 static late  SharedPreferences prefs;

 static Future<void> createSharedPreferenceDb() async {
    prefs = await SharedPreferences.getInstance();
 }

 static String? getTemperatureFromLocalDb(SharedPreferences prefs){
   return  prefs.getString("temperature") ;
 }

 static Future<void> setTemperature(String temperature,SharedPreferences prefs) async {
   await prefs.setString('temperature', temperature);
 }


}