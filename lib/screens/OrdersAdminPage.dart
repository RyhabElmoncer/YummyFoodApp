import 'package:flutter/material.dart';

class OrdersAdminPage extends StatefulWidget {
  @override
  _OrdersAdminPageState createState() => _OrdersAdminPageState();
}

class _OrdersAdminPageState extends State<OrdersAdminPage> {
  List<String> _commandesEnCours = [
    "Pizza",
    "Burger",
    "Salade",
  ];

  List<String> _commandesTermines = [
  "Pâtes",
  "Riz",
  "Sandwich"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commandes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _commandesEnCours.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_commandesEnCours[index]),
                  trailing: ElevatedButton(
                    child: Text('Terminer'),
                    onPressed: () {
                      setState(() {
                        String commande = _commandesEnCours.removeAt(index);
                        _commandesTermines.add(commande);
                      });
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
              itemCount: _commandesTermines.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_commandesTermines[index]),
                  trailing: ElevatedButton(
                    child: Text('Supprimer'),
                    onPressed: () {
                      setState(() {
                        _commandesTermines.removeAt(index);
                      });
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
}