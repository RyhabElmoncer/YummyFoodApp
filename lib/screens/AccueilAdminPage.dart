import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/User.dart';
import 'CommandesAdminPage.dart';
import 'DashboardCommandesPage.dart';
import 'MenuAdminPage.dart';

class AccueilAdminPage extends StatefulWidget {
  static const routeName = "/AccueilAdminPage";

  @override
  _AccueilAdminPageState createState() => _AccueilAdminPageState();
}

class _AccueilAdminPageState extends State<AccueilAdminPage> with TickerProviderStateMixin {
  List<String> _utilisateurs = [];
  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users from Firestore on initialization
  }

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      List<String> users = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String username = data['email'] as String;
        users.add(username);
      });

      setState(() {
        _utilisateurs = users;
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> addUser(String email, String password, String role) async {
    try {
      User newUser = User(email: email, password: password, role: role);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .set(newUser.toMap());

      setState(() {
        _utilisateurs.add(email);
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).delete();

      setState(() {
        _utilisateurs.remove(email);
      });
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<void> updateUser(String email, String newEmail, String newPassword, String newRole) async {
    try {
      User updatedUser = User(email: newEmail, password: newPassword, role: newRole);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .update(updatedUser.toMap());

      setState(() {
        int index = _utilisateurs.indexOf(email);
        _utilisateurs[index] = newEmail;
      });
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // Accueil
        break;
      case 1:
      // Menu
        break;
      case 2:
      // Commandes
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/connexion', ModalRoute.withName('/connexion'));
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // TODO: Handle analytics button press
            },
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              // TODO: Handle people button press
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: Handle shopping cart button press

            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Chercher utilisateurs ...',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  fetchUsers();
                } else {
                  _utilisateurs = _utilisateurs
                      .where((utilisateur) =>
                      utilisateur.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
        ),
      ),
      body: Container(

        child: Column(
          children: [
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardCommandesPage(),
                      )
                    );
                  },
                  child: Container(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _utilisateurs.length,
                itemBuilder: (context, index) {
                  final utilisateur = _utilisateurs[index];

                  return ListTile(
                    title: Text(utilisateur ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteUser(utilisateur);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String newEmail = utilisateur;
                                String newPassword = '';
                                String newRole = '';

                                return AlertDialog(
                                  title: Text('Modifier un utilisateur'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                          ),
                                          onChanged: (value) {
                                            newEmail = value;
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Mot de passe',
                                          ),
                                          onChanged: (value) {
                                            newPassword = value;
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Rôle',
                                          ),
                                          onChanged: (value) {
                                            newRole = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Annuler'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Mettre à jour'),
                                      onPressed: () {
                                        updateUser(
                                          utilisateur,
                                          newEmail,
                                          newPassword,
                                          newRole,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String newEmail = '';
                    String newPassword = '';
                    String newRole = '';

                    return AlertDialog(
                      title: Text('Ajouter un utilisateur'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                              onChanged: (value) {
                                newEmail = value;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                              ),
                              onChanged: (value) {
                                newPassword = value;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Rôle',
                              ),
                              onChanged: (value) {
                                newRole = value;
                              },
                            ),
                          ],
                        ),
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
                            addUser(newEmail, newPassword, newRole);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Ajouter un utilisateur'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Commandes',
          ),
        ],
    currentIndex: 0,
    onTap: (int index) {
    switch (index) {
    case 0:
    // Do nothing, already on the home page
    break;
    case 1:
    // Navigate to the menu page
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MenuAdminPage()),
    );
    break;
    case 2:
    // Navigate to the orders page
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CommandesAdminPage()),
    );
    break;
    default:
    break;
    }}
      ),
    );
  }
}
