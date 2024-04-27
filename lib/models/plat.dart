import 'package:flutter/cupertino.dart';

class Plat {

  String nom;
 double prix;
  String description;
  final AssetImage image;

 Plat({
     required this.nom,
     required this.prix,
    required this.description,
     required this.image,
  });
}