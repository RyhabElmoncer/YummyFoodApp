import 'package:flutter/material.dart';


class CommandePage extends StatefulWidget {
  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  // Les prix unitaires de chaque article
  double CakePrice = 20;
  double PizzaPrice = 40;
  double SpaghettiPrice = 60;

  // Les quantités de chaque article
  int quantityCake = 0;
  int quantityPizza = 0;
  int quantitySpaghetti = 0;

  // Le pourcentage de remise
  int remise = 0;

  // Fonction pour augmenter la quantité d'un article
  void increaseQuantity(String article) {
    setState(() {
      switch (article) {
        case "Chocolate Cake":
          quantityCake++;
          break;
        case "Pizza":
          quantityPizza++;
          break;
        case "Spaghetti":
          quantitySpaghetti++;
          break;
      }
    });
  }

  // Fonction pour diminuer la quantité d'un article
  void decreaseQuantity(String article) {
    setState(() {
      switch (article) {
        case "Chocolate Cake":
          if (quantityCake > 0) {
            quantityCake--;
          }
          break;
        case "Pizza":
          if (quantityPizza > 0) {
            quantityPizza--;
          }
          break;
        case "Spaghetti":
          if (quantitySpaghetti > 0) {
            quantitySpaghetti--;
          }
          break;
      }
    });
  }

  // Fonction pour calculer le prix total
  double calculateTotal() {
    double total =
        (quantityCake * CakePrice) + (quantityPizza * PizzaPrice) + (quantitySpaghetti * SpaghettiPrice);
    double tva = total * 0.2;
    double remiseAmount = total * (remise / 100);
    return total + tva - remiseAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passer une commande"),
       // leading: IconButton(
       //   icon: Icon(FlutterIcons.arrow_back),
         // onPressed: () => Navigator.of(context).pop(),
       // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildArticle("Chocolate Cake", CakePrice, quantityCake, "Chocolate Cake"),
                _buildArticle("Pizza", PizzaPrice, quantityPizza, "Pizza"),
                _buildArticle("Spaghetti", SpaghettiPrice, quantitySpaghetti, "Spaghetti"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRemise(),
                _buildTotal(),
                _buildTVA(),
                _buildFinalPrice(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Passer la commande"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour afficher un article avec son prix et sa quantité
  Widget _buildArticle(String name, double price, int quantity, String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text("$price dt"),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => decreaseQuantity(id),
            ),
            Text("$quantity"),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => increaseQuantity(id),
            ),
          ],
        ),
        Text("${price * quantity} dt"),
      ],
    );
  }

  // Widget pour entrer une remise en pourcentage
  Widget _buildRemise() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Remise (%)"),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                remise = int.parse(value);
              });
            },
            decoration: InputDecoration(
              hintText: "0",
              suffixText: "%",
            ),
          ),
        ),
      ],
    );
  }

  // Widget pour afficher le prix total
  Widget _buildTotal() {
    double total =
        (quantityCake * CakePrice) + (quantityPizza * PizzaPrice) + (quantitySpaghetti * SpaghettiPrice);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total"),
        Text("$total dt"),
      ],
    );
  }

  // Widget pour afficher la TVA
  Widget _buildTVA() {
    double total =
        (quantityCake * CakePrice) + (quantityPizza * PizzaPrice) + (quantitySpaghetti * SpaghettiPrice);
    double tva = total * 0.2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("TVA (20%)"),
        Text("$tva dt"),
      ],
    );
  }
  // Widget pour afficher le prix final
  Widget _buildFinalPrice() {
    double total =
        (quantityCake * CakePrice) + (quantityPizza * PizzaPrice) + (quantitySpaghetti * SpaghettiPrice);
    double tva= total * 0.2;
    double remiseAmount = total * (remise / 100);
    double finalPrice = total + tva - remiseAmount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Prix final"),
        Text("$finalPrice dt"),
      ],
    );
  }
}