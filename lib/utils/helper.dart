import 'package:flutter/material.dart';
//class helper  pour obtenir des dimensions d'écran, des chemins des images  et des thèmes de texte.
class Helper {
  //getScreenwidth renvoi largeur et hauteur  de screen
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static String getAssetName(String fileName, String type) {
    return "assets/images/$type/$fileName";
    //chemin des images :$type ::type de l'images viruel ou real **fileName:: nom de l'image
  }
//getTheme ::renvoi theme de texte
  static TextTheme getTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }
}
