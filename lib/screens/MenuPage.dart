import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> _plats = [];

  @override
  void initState() {
    super.initState();
    _fetchPlatsFromFirebase();
  }

  Future<void> _fetchPlatsFromFirebase() async {
    // Récupérer la référence à la collection "plat" dans votre base de données Firebase
    CollectionReference platCollection =
    FirebaseFirestore.instance.collection('plat');

    // Récupérer les documents de la collection
    QuerySnapshot platSnapshot = await platCollection.get();

    // Parcourir les documents et ajouter les plats à la liste
    List<String> plats = [];
    platSnapshot.docs.forEach((doc) {
      String plat = doc['nom']; // Remplacez 'nom' par le nom du champ contenant le nom du plat dans votre base de données
      plats.add(plat);
    });

    setState(() {
      _plats = plats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView.builder(
        itemCount: _plats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_plats[index]),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Ajouter le plat à la commande
                // Code à implémenter
              },
            ),
          );
        },
      ),
    );
  }
}
