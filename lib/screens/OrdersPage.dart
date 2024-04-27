import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<String> _orders = [];

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  void _getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _orders = prefs.getStringList('orders') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_orders[index]),
          );
        },
      ),
    );
  }
}