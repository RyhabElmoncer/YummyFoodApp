import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'ProfilPage.dart';

class AcceuilClientPage extends StatefulWidget {
  @override
  _AcceuilClientPageState createState() => _AcceuilClientPageState();
}

class _AcceuilClientPageState extends State<AcceuilClientPage> {
  int _itemsInCart = 0;

  List<Map<String, dynamic>> _menuItems = [
    {
      'name': 'Pizza Margherita',
      'description': 'Tomato sauce, mozzarella, and basil',
      'price': 10.99,
      'image': 'assets/images/pizza_margherita.jpg',
    },
    {
      'name': 'Spaghetti Carbonara',
      'description': 'Spaghetti with bacon, eggs, and parmesan cheese',
      'price': 12.99,
      'image': 'assets/images/spaghetti_carbonara.jpg',
    },
    {
      'name': 'Chicken Alfredo',
      'description': 'Fettuccine with chicken and creamy alfredo sauce',
      'price': 14.99,
      'image': 'assets/images/chicken_alfredo.jpg',
    },
    {
      'name': 'Caesar Salad',
      'description': 'Romaine lettuce, croutons, parmesan cheese, and Caesar dressing',
      'price': 8.99,
      'image': 'assets/images/caesar_salad.jpg',
    },
    {
      'name': 'Tiramisu',
      'description': 'Coffee-flavored Italian dessert',
      'price': 6.99,
      'image': 'assets/images/tiramisu.jpg',
    },
    {
      'name': 'Chocolate Cake',
      'description': 'Rich chocolate cake with chocolate frosting',
      'price': 7.99,
      'image': 'assets/images/chocolate_cake.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [
                      Image.asset(
                        _menuItems[index]['image'],
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        title: Text(_menuItems[index]['name']),
                        subtitle: Text(_menuItems[index]['description']),
                        trailing: ElevatedButton.icon(
                          icon: Icon(Icons.add_shopping_cart),
                          label: Text('Add'),
                          onPressed: () {
                            setState(() {
                              _itemsInCart++;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
      ),
    );
  }
}