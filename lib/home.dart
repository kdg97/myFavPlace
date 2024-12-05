// Importation du package principal de Flutter pour les widgets et le design
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_odc/db_helper.dart';
import 'package:test_odc/functions.dart';
import 'package:test_odc/place.dart';



class MyFavPlacesScreen extends StatefulWidget {

   MyFavPlacesScreen({super.key});

  @override
  State<MyFavPlacesScreen> createState() => _MyFavPlacesScreenState();
}

class _MyFavPlacesScreenState extends State<MyFavPlacesScreen> {

  Color main_color = Color.fromARGB(255, 58, 94, 183);
  final List<String> categories = [
    'Tous',
    'Resto',
    'Bars',
    'Cafés',
    'Parcs',
    'Shop'
  ];

  List<Place> places = [];


  int selectedCategoryIndex = 0;
  bool isMoonOrSun = false;
  String temperature = "";

  void getPlaces(){
   places =  ObjectBox.getAllPlaces();
   setState(() {});
  }

  Future<void> setTemperature() async {
    temperature =  await getTemperature();
    setState(() {});
  }
  Future<void> setISMoonOrSun() async {
    isMoonOrSun = await  isSunny();
    setState(() {});
  }


  @override
  void initState() {
    super.initState();

    getPlaces();

    WidgetsBinding.instance.addPostFrameCallback((_){
      setISMoonOrSun();
      setTemperature();
    });
  }

  @override
  Widget build(BuildContext context) {
   final data = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic> ;

    return Scaffold(

      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 58, 94, 183),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(220),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bienvenue ${data["data"]}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),


                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MyFavPlace",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,15,0),
                        child: Column(
                          children: [
                            Text("$temperature °C",style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight:FontWeight.bold
                            ),),
                            SizedBox(width: 10,),

                            !isMoonOrSun?
                            Icon(Icons.nightlight_rounded,size: 40,
                              color: Colors.yellow,)
                                :
                            Icon(Icons.sunny,size: 40,
                              color: Colors.yellow,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        hintText: 'Rechercher un lieu...',
                        filled: true,
                        fillColor: Colors.white,
                        // Bordure personnalisée
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        actions: [
          // Bouton de profil
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            )),
      ),
      // Corps de l'application
      body: Column(
        children: [
          SizedBox(height: 20,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                myButton(categories[0],Colors.white,Colors.black),
                myButton(categories[1],Color.fromARGB(255, 58, 94, 183),Colors.white),
                myButton(categories[2],Colors.white,Colors.black),
                myButton(categories[3],Colors.white,Colors.black),
                myButton(categories[4],Colors.white,Colors.black),
              ],
            ),
          ),

          SizedBox(height: 20,),
          // Champ de recherche
          Expanded(
            child:
            places.length == 0 ?
                Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aucun lieux enregistrés",style:
                      TextStyle(fontSize: 24,color: Colors.black),),
                    Image(image: AssetImage("assets/images/liste.png"),
                    width: 400,
                    height: 250,)
                  ],
                ))
            :
            ListView.builder(
                itemCount: places.length,
                itemBuilder:(BuildContext context,int index){
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        places[index].imagePath == ""?
                            Container(
                                height: 100,
                            width: 200,
                            color: main_color,
                                child: Center(
                                    child: Text("Pas d'image",style:
                                    TextStyle(fontSize: 20,color: Colors.white),)),)
                        :
                        Container(
                          width: 400,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.file(File(places[index].imagePath),
                            fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(places[index].name,style:
                                  GoogleFonts.lobster(fontSize: 25,fontWeight: FontWeight.bold),),

                                  Row(
                                    children: [
                                      Icon(Icons.update_outlined,size: 25,color: main_color,),
                                      SizedBox(width: 5,),
                                      Text("${GetTimeAgo.
                                      parse(DateTime.fromMillisecondsSinceEpoch
                                        (places[index].timestamps))}"
                                        ,style: TextStyle(
                                          fontStyle: FontStyle.italic
                                      ),),
                                      SizedBox(width: 10,),
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Description: ",style:
                              GoogleFonts.baloo2(fontSize: 18,fontWeight: FontWeight.bold),),

                              Text(places[index].desc
                                ,style:
                                GoogleFonts.roboto(fontSize: 14),
                              ),

                              Row(
                                children: [
                                  Icon(Icons.location_on,size: 35,color: main_color,),
                                  TextButton(onPressed: (){},
                                    child: Text("${places[index].country},"
                                        "${places[index].city}",style: TextStyle(
                                        fontWeight: FontWeight.bold,fontSize: 18
                                    ),),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                    for(var i = 0; i < int.parse(places[index].note);i++)
                                      Icon(Icons.star,color: Colors.orange,size: 30,),

                                    for(var i = 0; i < 5-int.parse(places[index].note);i++)
                                    Icon(Icons.star,size: 30,)
                                ],
                              ),
                              SizedBox(height: 10,),
                              TextButton(onPressed: (){}, child:
                              Row(
                                children: [
                                  Text("Allez sur la carte"),
                                  SizedBox(width: 5,),
                                  Icon(Icons.map_rounded,size: 30,color: main_color,)
                                ],
                              ))
                            ],
                          ),
                        )

                      ],
                    ),
                  );
                } ),
          ),
        ],
      ),
      // Barre de navigation en bas
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        selectedItemColor: main_color,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
      ),
      // Bouton d'action flottant
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,"/addPlace");
        },
        backgroundColor: Color.fromARGB(255, 58, 94, 183),
        child: const Icon(Icons.add,size: 24,color: Colors.white,),
      ),
    );
  }

  Widget myButton(String content,Color color,Color textColor){
    return Padding(
      padding: const EdgeInsets.fromLTRB(5,0,5,0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(content,style: TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.bold
        ),),
        style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.fromLTRB(20, 10, 20, 10)
            ),
            backgroundColor: WidgetStateProperty.all<Color>(color),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: main_color, width: 2)))),
      ),
    );
  }
}
