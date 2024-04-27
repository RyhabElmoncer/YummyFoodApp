import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../screens/loginScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AuthentificationScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _registerUser() async {
    try {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String mobile = _mobileController.text.trim();
      final String address = _addressController.text.trim();
      final String password = _passwordController.text;

      if (_formKey.currentState!.validate()) {
        // Créer l'utilisateur dans Firebase Authentication
        final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Obtenir l'ID utilisateur nouvellement créé
        final String userId = userCredential.user!.uid;

        // Enregistrer les informations supplémentaires de l'utilisateur dans Firestore
        await _firestore.collection('users').doc(userId).set({
          'name': name,
          'email': email,
          'mobile': mobile,
          'address': address,
          'role': 'client', // Ajoutez le rôle 'client' ici
        });

        // Rediriger vers l'écran d'authentification
        Navigator.of(context)
            .pushReplacementNamed(AuthentificationPage.routeName);
      }
    } catch (e) {
      // Gérer les erreurs d'inscription
      print('Erreur lors de l\'inscription : $e');
      // Afficher un message d'erreur à l'utilisateur
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erreur'),
          content: Text(
              'Une erreur s\'est produite lors de l\'inscription. Veuillez réessayer.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: SafeArea(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "  S'inscrire",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Ajoutez vos coordonnées pour vous inscrire",  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                    ),
                    Spacer(),
                    CustomTextInput(
                        hintText: "Nom", controller: _nameController,  ),
                    Spacer(),
                    CustomTextInput(
                        hintText: "E-mail", controller: _emailController),
                    Spacer(),
                    CustomTextInput(
                        hintText: "Mobile", controller: _mobileController),
                    Spacer(),
                    CustomTextInput(
                        hintText: "Adresse", controller: _addressController),
                    Spacer(),
                    CustomTextInput(
                        hintText: "Mot de passe",
                        controller: _passwordController,
                        isPassword: true),
                    Spacer(),
                    CustomTextInput(
                        hintText: "Confirmez le mot de passe",
                        controller: _confirmPasswordController,
                        isPassword: true),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _registerUser,
                        child: Text("S'inscrire"),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vous avez déjà un compte?"),
                          Text(
                            "Connexion",
                            style: TextStyle(
                              color: AppColor.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
