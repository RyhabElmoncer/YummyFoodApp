import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/plat.dart';

class MenuAdminPage extends StatefulWidget {
  @override
  _MenuAdminPageState createState() => _MenuAdminPageState();
}

class _MenuAdminPageState extends State<MenuAdminPage> {
  final _formKey = GlobalKey<FormState>();
  late String searchQuery;

  List<Plat> _plats = [
    Plat(
      nom: 'Pizza',
      prix: 10,
      description: 'Une délicieuse pizza',
      image: AssetImage('images/pizza.jpg'),
    ),
    Plat(
      nom: 'Hamburger',
      prix: 8,
      description: 'Un hamburger bien juteux',
      image: AssetImage('images/hamburger.jpg'),
    ),
    Plat(
      nom: 'Desert',
      prix: 60,
      description: 'Desert',
      image: AssetImage('images/dessert.jpg'),
    ),
  ];

  late Plat _platEnCoursDeModification;
  late File _image;
  final picker = ImagePicker();

  Future<void> _prendrePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Aucune image sélectionnée.');
      }
    });
  }

  void _ajouterPlat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un plat'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nom',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom du plat';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _plats.add(
                          Plat(
                            nom: value,
                            prix: _platEnCoursDeModification.prix,
                            description: _platEnCoursDeModification.description,
                            image: _platEnCoursDeModification.image,
                          ),
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Prix',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le prix du plat';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _plats.add(
                          Plat(
                            nom: _platEnCoursDeModification.nom,
                            prix: double.parse(value),
                            description: _platEnCoursDeModification.description,
                            image: _platEnCoursDeModification.image,
                          ),
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la description du plat';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _plats.add(
                          Plat(
                            nom: _platEnCoursDeModification.nom,
                            prix: _platEnCoursDeModification.prix,
                            description: value,
                            image: _platEnCoursDeModification.image,
                          ),
                        );
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _prendrePhoto(ImageSource.camera);
                    },
                    child: Text('Prendre une photo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _prendrePhoto(ImageSource.gallery);
                    },
                    child: Text('Choisir une photo'),
                  ),
                  _image == null
                      ? Text('Aucune image sélectionnée.')
                      : Image.file(_image),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {});
                  Navigator.of(context).pop();
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _modifierPlat(Plat plat) {
    _platEnCoursDeModification = plat;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier le plat'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    initialValue: plat.nom,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom du plat';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        plat.nom = value;
                      }
                    },
                  ),
                  TextFormField(
                    initialValue: plat.prix.toString(),
                    decoration: InputDecoration(
                      labelText: 'Prix',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le prix du plat';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        plat.prix = double.parse(value);
                      }
                    },
                  ),
                  TextFormField(
                    initialValue: plat.description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la description du plat';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        plat.description = value;
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _prendrePhoto(ImageSource.camera);
                    },
                    child: Text('Prendre une photo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _prendrePhoto(ImageSource.gallery);
                    },
                    child: Text('Choisir une photo'),
                  ),
                  _image == null
                      ? Image(image: plat.image)
                      : Image.file(_image),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {});
                  Navigator.of(context).pop();
                }
              },
              child: Text('Modifier'),
            ),
          ],
        );
      },
    );
  }

  void _supprimerPlat(Plat plat) {
    setState(() {
      _plats.remove(plat);
    });
  }

  @override
  void initState() {
    super.initState();
    searchQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Admin'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white60,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher plat...',
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _plats.length,
              itemBuilder: (BuildContext context, int index) {
                if (searchQuery.isNotEmpty &&
                    !_plats[index]
                        .nom
                        .toLowerCase()
                        .contains(searchQuery)) {
                  return SizedBox();
                }

                return ListTile(
                  title: Text(_plats[index].nom),
                  subtitle: Text('\€ ${_plats[index].prix}'),
                  leading: Image(
                    image: _plats[index].image,
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 50.0,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _modifierPlat(_plats[index]);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          _supprimerPlat(_plats[index]);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ajouterPlat();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
