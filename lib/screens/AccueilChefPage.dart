import 'package:flutter/material.dart';

class ChefPage extends StatefulWidget {
  static const routeName = "/ChefPage";

  @override
  _ChefPageState createState() => _ChefPageState();
}

class _ChefPageState extends State<ChefPage> {
  Map<String, int> produitsDisponibles = {
    'Pizza': 10,
    'Burger': 8,
    'Salade': 6,
  };

  List<Order> pendingOrders = [
    Order('Pizza', OrderStatus.inProgress, 1),
    Order('Burger', OrderStatus.inProgress, 1),
    Order('Salade', OrderStatus.inProgress, 1),
  ];

  List<Order> filteredOrders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue Chef'),
        actions: [
          IconButton(
            icon: Icon(Icons.inventory),
            onPressed: () {
              _showProduitsDisponiblesDialog(context);
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  filteredOrders = pendingOrders.where((order) =>
                      order.item.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Code pour déconnecter l'utilisateur
              // Naviguer vers la page de connexion
              Navigator.pushNamed(context, '/connexion');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredOrders.isNotEmpty ? filteredOrders.length : pendingOrders.length,
        itemBuilder: (context, index) {
          Order order = filteredOrders.isNotEmpty ? filteredOrders[index] : pendingOrders[index];
          return ListTile(
            title: Text('${order.item} (${produitsDisponibles[order.item]} disponibles)'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.statusToString()),
                for (var comment in order.comments)
                  Row(
                    children: [
                      Text('- $comment'),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditCommentDialog(context, order, comment);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            order.comments.remove(comment);
                          });
                        },
                      ),
                    ],
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('En préparation'),
                  onPressed: order.status == OrderStatus.inProgress
                      ? () {
                    setState(() {
                      // Mettre à jour l'état de la commande
                      _updateOrderStatus(order, OrderStatus.inPreparation);
                      // Diminuer le stock
                      _updateProduitDisponible(order.item, -1);
                    });
                  }
                      : null,
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Prêt'),
                  onPressed: order.status == OrderStatus.inPreparation
                      ? () {
                    setState(() {
                      // Mettre à jour l'état de la commande
                      _updateOrderStatus(order, OrderStatus.ready);
                    });
                  }
                      : null,
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Commentaire'),
                  onPressed: () {
                    // Ouvrir une boîte de dialogue pour ajouter un commentaire
                    _showCommentDialog(context, order);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showProduitsDisponiblesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informations sur les produits disponibles'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var produit in produitsDisponibles.entries)
                Text('${produit.key}: ${produit.value} disponibles'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProduitDisponible(String produit, int quantity) {
    setState(() {
      produitsDisponibles[produit] = (produitsDisponibles[produit] ?? 0) + quantity;
    });
  }

  void _updateOrderStatus(Order order, OrderStatus newStatus) {
    order.status = newStatus;
  }

  void _showCommentDialog(BuildContext context, Order order) {
    String comment = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un commentaire'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Commentaire'),
            onChanged: (value) {
              comment = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ajouter'),
              onPressed: () {
                setState(() {
                  order.comments.add(comment);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCommentDialog(BuildContext context, Order order, String comment) {
    String editedComment = comment;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier le commentaire'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Commentaire'),
            onChanged:(value) {
              editedComment = value;
            },
            controller: TextEditingController(text: comment),
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Enregistrer'),
              onPressed: () {
                setState(() {
                  order.comments[order.comments.indexOf(comment)] = editedComment;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

enum OrderStatus {
  inProgress,
  inPreparation,
  ready,
}

class Order {
  String item;
  OrderStatus status;
  List<String> comments;
  int quantity;

  Order(this.item, this.status, this.quantity) : comments = [];

  String statusToString() {
    switch (status) {
      case OrderStatus.inProgress:
        return 'En attente';
      case OrderStatus.inPreparation:
        return 'En préparation';
      case OrderStatus.ready:
        return 'Prêt';
      default:
        return '';
    }
  }
}
