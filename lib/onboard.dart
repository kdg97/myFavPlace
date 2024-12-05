import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddPlace extends StatelessWidget {
  const AddPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddPlaces(),
    );
  }
}


class AddPlaces extends StatefulWidget {
  const AddPlaces({super.key});

  @override
  State<AddPlaces> createState() => _AddPlaceStates();
}

class _AddPlaceStates extends State<AddPlaces> {
  GlobalKey<FormState> formKey  = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool fileExist = false;

  Future<void> getImage() async {
    final image_ = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(image_ != null) {
        image = image_;
        fileExist = true;
      }});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un lieu'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Diviser en deux colonnes
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Première colonne
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [

                      GestureDetector(
                          onTap: ()  async {
                            getImage();
                          },
                          child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),

                              ),
                              child: !fileExist?
                              Icon(Icons.add_a_photo_rounded,size: 40,color: Colors.black,):
                              Image.file(File(image!.path))
                          )),
                      SizedBox(height: 16,)
                    ],
                  ),
                ),
                // Deuxième colonne
                Expanded(
                  flex: 4,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [

                        SizedBox(
                          width: 180, // Réduction de la taille
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nom du produit',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.green), // Bordure verte
                              ),
                            ),
                            validator: (value){

                            },
                          ),
                        ),
                        SizedBox(height: 16), // Espacement
                        SizedBox(
                          width: 180, // Réduction de la taille
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prix (FCFA)',

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.green), // Bordure verte
                              ),
                            ),
                            validator: (value){
                            },

                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: 180, // Réduction de la taille
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Quantité',

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.green), // Bordure verte
                              ),
                            ),
                            validator: (value){
                            },

                          ),
                        ),
                        SizedBox(height: 16), // Espacement
                        // Dropdown pour les catégories
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,15,0),
                          child: SizedBox(
                            width: double.infinity, // Réduction de la taille
                            child: DropdownButtonFormField<String>(
                              validator: (value){

                              },
                              hint: Text('Domaine'),
                              items: [
                                for(var i in ["Bars","Resto"])
                                  DropdownMenuItem(value: i, child: Text(i)),
                              ],
                              onChanged: (value) async {

                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.green), // Bordure verte
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16), // Espacement
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,15,0),
                          child: SizedBox(
                            width:double.infinity, // Réduction de la taille
                            child: DropdownButtonFormField<String>(
                              validator: (value){

                              },
                              hint: Text('Catégorie'),
                              items: [
                                for(var i in ["Cafés,Parcs"])
                                  DropdownMenuItem(value: i, child: Text(i)),
                              ],
                              onChanged: (value) {

                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.green), // Bordure verte
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Espacement
            // Conteneur pour modifier la description
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
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
            SizedBox(height: 16), // Espacement
            // Boutons Enregistrer et Supprimer
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if( formKey.currentState!.validate() ) {
                    }
                  },
                  icon: Icon(Icons.save, color: Colors.white),
                  label: false
                      ?  CircularProgressIndicator(color: Colors.blueAccent)
                      : Text('Enregistrer', style: TextStyle(color: Colors.white,
                      fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  ),
                ),
                SizedBox(width: 15,),
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(Icons.cancel_outlined, color: Colors.white),
                  label: Text('Annuler', style: TextStyle(color: Colors.white,
                      fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
