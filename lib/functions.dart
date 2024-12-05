import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



Future<bool> checkInternetConnexion() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}



  Future<dynamic> sendGetRequest(String url) async {

    final response = await http.get(
        Uri.parse(url)
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<dynamic> sendPostRequest(Object donneesAEnvoyer,String url) async {

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(donneesAEnvoyer),
     );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

Future<Map<String,dynamic>> sendPostRequestAdvanced(String bodyJson, String url) async {
  // verifier l'état de la connexion
  bool res = await checkInternetConnexion();
  if (!res) {
    return {
      "status": false,
      "message": "Impossible de se connecter à internet",
      "data": ""
    };
  }
  // utiliser un try catch
  try {
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyJson,
    );
    return {"status": true, "message": "données recues", "data": response.body};

  } catch (e) {
    return {
      "status": false,
      "message": "une erreur est survenue veuillez réessayer",
      "data": ""
    };
  }
}


Future<bool> isSunny() async {
  String url = "http://api.openweathermap.org/data"
      "/2.5/weather?q=ouagadougou&"
      "appid=ed1bccfe3b52b20eae393a83f2fed50e&units=metric";

      dynamic response = await  sendGetRequest(url);

  int sunrise = response["sys"]["sunrise"];
  int sunset  = response["sys"]["sunset"];
  int currentTime = response["dt"];

  return sunset >= currentTime && currentTime >= sunrise;
}

Future<String> getTemperature() async {
  String url = "http://api.openweathermap.org/data"
      "/2.5/weather?q=ouagadougou&"
      "appid=ed1bccfe3b52b20eae393a83f2fed50e&units=metric";

  dynamic response = await  sendGetRequest(url);
  return response["main"]["temp"].toString();
}







