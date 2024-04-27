import 'dart:ui';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _hasChanges = false;
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with some default values
    _firstNameController.text = 'Sabe';
    _lastNameController.text = '';
    _phoneController.text = '+216250369870';
    _addressController.text = 'Tunis,sfax';
    _emailController.text = 'ali@gmail.com';
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    hintText: 'Entrez votre prénom',
                  ),
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Nom ',
                    hintText: 'Entrez votre nom ',
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Téléphone',
                    hintText: 'Entrez votre numéro de téléphone',
                  ),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Entrez votre adresse',
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasChanges = true;
                });
                Navigator.of(context).pop();
              },
              child: Text('Sauvegarder '),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerDialog() {
    // Add image picker dialog here
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mise à jour du profil réussie'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Votre profil',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: _showImagePickerDialog,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      'https://example.com/avatar.jpg'), // Replace with your image URL
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '${_firstNameController.text} ${_lastNameController.text}',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Téléphone: ${_phoneController.text}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Address: ${_addressController.text}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Email: ${_emailController.text}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _showEditDialog,
                    child: Text('Editer le profil'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_hasChanges) {
                        // Add functionality to save changes to profile
                        setState(() {
                          _hasChanges = false;
                          _showSuccessMessage = true;
                        });
                        _showSuccessSnackbar();
                      } else {
                        // Add functionality to do something else (e.g. go back)
                      }
                    },
                    child: Text('Sauvegarder les modifications'),
                  ),
                ],
              ),
              _showSuccessMessage
                  ? Text(
                'Profil modfier avec suceés !',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}