import 'package:flutter/material.dart';

class AccueilClientPage extends StatefulWidget {
  static const routeName = "/AccueilClientPage ";
  @override
  _AccueilClientPageState createState() => _AccueilClientPageState();
}

class _AccueilClientPageState extends State<AccueilClientPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allPlats = [
    {
      'name': 'Pizza ',
      'description': 'Tomato sauce, mozzarella',
      'price': 15,
      'image': 'assets/images/pizza.jpg',
    },
    {
      'name': 'Sushi',
      'description': '',
      'price': 30,
      'image': 'assets/images/souchi.jpeg',
    },
    {
      'name': 'Spaghetti ',
      'description': 'Spaghetti with bacon, eggs, and parmesan cheese',
      'price': 30,
      'image':'assets/images/spagueti.jpeg',
    },
    {
      'name': 'petit déjeuner',
      'description': '',
      'price': 20,
      'image': 'assets/images/ptj.jpg',
    }, {
      'name': 'Soupe',
      'description': '',
      'price': 10,
      'image': 'assets/images/soupe.jpeg',
    },
    {
      'name': 'Jus de fraises ',
      'description':'',
      'price': 8,
      'image': 'assets/images/jus.jpeg',
    },
    {
      'name': 'Tiramisu',
      'description': ' dessert',
      'price': 22,
      'image': 'assets/images/cacke.jpeg',
    },
    {
      'name': 'Chocolate ',
      'description': ' chocolate cake ',
      'price':10,
      'image': 'assets/images/chocolat.jpeg',
    },
  ];

  List<Map<String, dynamic>> _searchResults = [];

  int _cartCount = 0;

  @override
  void initState() {
    super.initState();
    _searchResults = List.from(_allPlats);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchResults = _allPlats
          .where((plat) =>
      plat['name']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()) ||
          plat['price']
              .toString()
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _addToCart() {
    setState(() {
      _cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les plats'),
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              Navigator.pushNamed(context,'/connexion' );
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/MyOrderScreen');
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    _cartCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un plat',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _searchResults.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                final plat = _searchResults[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/details_plat', arguments: plat);
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.asset(
                            plat['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plat['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\dt${plat['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _addToCart();
                          },
                          child: Text('Ajouter au panier'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.restaurant_menu),
              onPressed: () {
                Navigator.pushNamed(context, '/client_home');
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profileScreen');
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () {
                Navigator.pushNamed(context, '/commandes');
              },
            ),
          ],
        ),
      ),
    );
  }
}