import 'package:flutter/material.dart';

class CommandesAdminPage extends StatefulWidget {
  @override
  _CommandesAdminPageState createState() => _CommandesAdminPageState();
}

class _CommandesAdminPageState extends State<CommandesAdminPage> {
  List<Commande> _commandesEnCours = [
    Commande("Pizza", 2, "Sabee", DateTime.now()),
    Commande("Burger", 1, "Ahmed", DateTime.now().subtract(Duration(days: 1))),
    Commande("Salade", 3, "Ryhab", DateTime.now().subtract(Duration(days: 2))),
  ];

  List<Commande> _commandesTerminees = [];

   late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commandes'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _rafraichirCommandes();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'Date de commande (jj/mm/aaaa)',
              ),
              onSubmitted: (value) {
                _filtrerCommandes(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _commandesEnCours.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_commandesEnCours[index].plat),
                  subtitle: Text("Quantité : ${_commandesEnCours[index].quantite}, Client : ${_commandesEnCours[index].client}, Date : ${_commandesEnCours[index].dateCommande.toLocal()}"),
                  trailing: ElevatedButton(
                    child: Text('Terminer'),
                    onPressed: () {
                      _terminerCommande(index);
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _commandesTerminees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_commandesTerminees[index].plat),
                  subtitle: Text("Quantité : ${_commandesTerminees[index].quantite}, Client : ${_commandesTerminees[index].client}, Date : ${_commandesTerminees[index].dateCommande.toLocal()}"),
                  trailing: ElevatedButton(
                    child: Text('Supprimer'),
                    onPressed: () {
                      _supprimerCommande(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _terminerCommande(int index) {
    setState(() {
      Commande commande = _commandesEnCours.removeAt(index);
      _commandesTerminees.add(commande);
    });
  }

  void _supprimerCommande(int index) {
    setState(() {
      _commandesTerminees.removeAt(index);
    });
  }

  void _filtrerCommandes(String dateString) {
    DateTime? date = DateTime.tryParse(dateString);
    if (date != null) {
      setState(() {
        _commandesEnCours = _commandesEnCours.where((commande) => commande.dateCommande.isAfter(date)).toList();
        _commandesTerminees = _commandesTerminees.where((commande) => commande.dateCommande.isAfter(date)).toList();
      });
    }
  }

  void _rafraichirCommandes() {
    setState(() {
      _commandesEnCours = [
        Commande("Pizza", 2, "Sabee", DateTime.now()),
        Commande("Burger", 1, "Ahmed", DateTime.now().subtract(Duration(days: 1))),
        Commande("Salade", 3, "Ryhab", DateTime.now().subtract(Duration(days: 2))),
      ];
      _commandesTerminees = [];
    });
  }
}

class Commande {
  String plat;
  int quantite;
  String client;
  DateTime dateCommande;

  Commande(this.plat, this.quantite, this.client, this.dateCommande);
}