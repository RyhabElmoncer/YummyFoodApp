import 'package:flutter/material.dart';

class RapportsPage extends StatefulWidget {
  @override
  _RapportsPageState createState() => _RapportsPageState();
}

class _RapportsPageState extends State<RapportsPage> {
  List<double> _ventes = [100.0, 200.0, 150.0, 300.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapports de Vente'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Text('Total des Ventes : ${_ventes.reduce((a, b) => a + b)}'),
          Expanded(
            child: ListView.builder(
              itemCount: _ventes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Vente ${index + 1}'),
                  subtitle: Text('${_ventes[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}