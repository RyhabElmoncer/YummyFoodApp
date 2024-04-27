import 'package:flutter/material.dart';

import 'Utilisateur.dart';

class InfosClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic argument = ModalRoute.of(context)?.settings.arguments;

    if (argument is Utilisateur) {
      final Utilisateur utilisateur = argument;

      return Scaffold(
        appBar: AppBar(
          title: Text('${utilisateur.prenom} ${utilisateur.nom}'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nom : ${utilisateur.nom}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Prénom : ${utilisateur.prenom}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Adresse : ${utilisateur.adresse}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Numéro de téléphone : ${utilisateur.numeroTelephone}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erreur'),
        ),
        body: Center(
          child: Text('Une erreur est survenue.'),
        ),
      );
    }
  }
}