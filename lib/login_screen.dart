
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255,55,53,160),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                width: 400,
                height: 200,
                image: AssetImage("assets/images/logo_.png")),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Découvrez MyFavPlace, l’appli pour sauvegarder et '
                    'retrouver facilement vos lieux préférés',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF0072c6),
                fixedSize: Size(325, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Row(
                children: [
                  Image(
                      width: 25,
                      height: 25,
                      image: AssetImage("assets/images/face_.png")),
                  SizedBox(width: 15,),
                  Text('Se connecter avec Facebook',
                    style: TextStyle(
                      color:Color.fromARGB(255,55,53,152),
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255,55,53,152),
                fixedSize: Size(325, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      width: 25,
                      height: 25,
                      image: AssetImage("assets/images/google.png")),
                  SizedBox(width: 15,),
                  Text('Se connecter Google',
                    style: TextStyle(
                      color: Color.fromARGB(255,55,53,152),
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {

              },
              child: Text(
                'Vous avez deja un compte ? Se connecter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

            SizedBox(height: 10,),
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/home",arguments: {"data":"Fariis"});
              },
              child: Text(
                'continuer sans se connexter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.blueAccent,
            //     backgroundColor: Colors.white,
            //     maximumSize: Size(160, 50),
            //   ),
            //   onPressed: () {
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text("C'est parti", style: TextStyle(fontSize: 18,
            //           fontWeight: FontWeight.bold, color: Colors.black)),
            //       Icon(Icons.arrow_forward_rounded,color: Colors.black,)
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}