import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> _cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: _cartItems.isEmpty
          ? Center(
        child: Text('Your cart is empty.'),
      )
          : ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                _cartItems[index]['image'],
                fit: BoxFit.cover,
                width: 50.0,
                height: 50.0,
              ),
              title: Text(_cartItems[index]['name']),
              subtitle: Text('Price: \$${_cartItems[index]['price']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _cartItems.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : BottomAppBar(
        child: Container(
          margin: EdgeInsets.all(8.0),
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${_getTotalPrice()}'),
              ElevatedButton(
                child: Text('Checkout'),
                onPressed: () {
                  // Navigate to payment page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getTotalPrice() {
    double totalPrice = 0.0;
    for (Map<String, dynamic> item in _cartItems) {
      totalPrice += item['price'];
    }
    return totalPrice;
  }
}