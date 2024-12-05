import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_odc/db_helper.dart';
import 'package:test_odc/home.dart';
import 'package:test_odc/place.dart';



class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {

  GlobalKey<FormState> formKey  = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  String imagePath = "";
  bool imageExist = false;
  XFile? image;
  TextEditingController placeNameController = TextEditingController();
  TextEditingController placeCountryController = TextEditingController();
  TextEditingController placeCityController = TextEditingController();
  TextEditingController placeCategoryController = TextEditingController();
  TextEditingController placeDescriptionController = TextEditingController();
  TextEditingController placeNoteController = TextEditingController();

  final List<String> categories = [
    'Resto',
    'Bars',
    'Cafés',
    'Parcs',
    'Shop'
  ];

  
   final mySnack =  SnackBar(content: Container(
     color: Colors.white,
     child: Row(
       children: [
         Icon(Icons.check,size: 30,color: Colors.green,),
         SizedBox(width: 10,),
         Text("lieu enregistré",
          style: TextStyle(fontSize: 18,color: Colors.black),),
       ],
     ),
   ),
    backgroundColor: Colors.white,);

  Color main_color = Color.fromARGB(255,55,53,160);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: Icon(Icons.person,size: 28,color: Colors.white,),
          )
        ],
        leading: Icon(Icons.menu,size: 28,color: Colors.white,),
        title: Text("Ajouter un lieu",style: TextStyle(
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),),
        backgroundColor: main_color,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: formKey ,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,20,20,0),
                child: Column(
                            children: [

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        width: 200,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:
                            imageExist ?
                                ClipRRect(child: Image.file(File(imagePath),
                                  fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(15),)
                            :
                            IconButton(onPressed: () async {
                              // Pick an image.
                               final image_ = await picker.pickImage
                                (source: ImageSource.gallery);
                      
                               setState(() {
                                 if(image_ != null){
                                   image = image_;
                                   imagePath = image!.path;
                                   imageExist = true;
                                 }
                               });
                      
                            }, 
                                icon: Icon(
                                    Icons.add_a_photo,
                                   color: main_color,
                                   size: 50,
                                )),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          TextFormField(
                            controller: placeNameController,
                              decoration: InputDecoration(
                                label: Text("nom"),
                                filled: true,
                                fillColor: Colors.white,
                                // Bordure personnalisée
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.black
                                  ),
                      
                                ),
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "veuillez entrer le nom";
                              }
                              return null;
                            },
                          ),
                      
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: placeCountryController,
                              decoration: InputDecoration(
                                label: Text("pays"),
                                filled: true,
                                fillColor: Colors.white,
                                // Bordure personnalisée
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.black
                                  ),
                      
                                ),
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "veuillez entrer le pays";
                                }
                                return null;
                              }
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: placeCityController,
                              decoration: InputDecoration(
                                label: Text("ville"),
                                filled: true,
                                fillColor: Colors.white,
                                // Bordure personnalisée
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.black
                                  ),
                      
                                ),
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "veuillez entrer la ville";
                                }
                                return null;
                              }
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: 30,),
                              DropdownButtonFormField<String>(
                                validator: (value){
                                  if(value == null){
                                    return "veuillez choisir une catégorie";
                                  }
                                  return null;
                                },
                                hint: Text('catégorie'),
                                items: [
                                  for(var i in categories)
                                    DropdownMenuItem(value: i, child: Text(i)),

                                ],
                                onChanged: (value)  {
                                  placeCategoryController.text = value!;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.black), // Bordure verte
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                controller: placeNoteController,
                                  decoration: InputDecoration(
                                    label: Text("donner une note sur 5"),
                                    filled: true,
                                    fillColor: Colors.white,
                                    // Bordure personnalisée
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: Colors.black
                                      ),

                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                  ),
                              validator: (value){
                                RegExp regExp =  RegExp(
                                  r"^[0-5]$",
                                  caseSensitive: false,
                                  multiLine: false,
                                );

                                if (!regExp.hasMatch(value!.trim())) {
                                  return "note incorrecte";
                                }
                                else {
                                  return null;
                                }
                              },
                              ),
                              SizedBox(height: 10,),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: placeDescriptionController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: 'Modifier la description...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  // validator: (value){
                                  //   return controller.validateName(value!);
                                  // },
                                ),
                              ),
                             SizedBox(height: 40,),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if( formKey.currentState!.validate() ) {

                                    final place = Place(
                                      timestamps: DateTime.now().millisecondsSinceEpoch,
                                      imagePath: imagePath,
                                      name: placeNameController.text,
                                      country: placeCountryController.text,
                                      city: placeCityController.text,
                                      category: placeCategoryController.text,
                                      note: placeNoteController.text,
                                      desc: placeDescriptionController.text
                                    );
                                    ObjectBox.savePlace(place);
                                   ScaffoldMessenger.of(context).showSnackBar(mySnack);
                                    Navigator.popAndPushNamed(context,"/home",arguments: {
                                      "data":"Fariis"
                                    });
                                  
                                  }
                                },
                                icon: Icon(Icons.save, color: Colors.white),
                                label:Text('Enregistrer', style: TextStyle(color: Colors.white,
                                    fontSize: 15)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                                ),
                              )
                            ],
                          ),
              )),
        ),
      ),
    );
  }
}
