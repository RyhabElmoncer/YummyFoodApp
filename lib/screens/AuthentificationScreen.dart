import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummyfoodapp/screens/signUpScreen.dart';

import 'introScreen.dart';

class AuthentificationPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  static const routeName = '/AuthentificationPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(' Authentificationtion Admin')),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_login,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Utilisateur",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                //controller: txt_password,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: "Mot de passe",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)
                  ),
                  onPressed: () {
                    _onAuthentifier(context);
                  },
                  child: Text('Connexion', style: TextStyle(fontSize: 22))),
            ),
            TextButton(
              child: Text("Nouvel utilisateur ",
                  style: TextStyle(fontSize: 22)),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignUpScreen.routeName);
            },),
            Spacer(
              flex: 2,
            ),
            Text("ou Connectez-vous avec"),
            Spacer(),
            SignInButton(
              Buttons.Google,
              text: "S'inscrire avec Google",
              onPressed: () {},
            ),
            Spacer(),
            SignInButton(
              Buttons.Facebook,
              text: "S'inscrire avec Facebook",
              onPressed: () {},
            ),
          ],
        )
    );
  }


  Future<void> _onAuthentifier(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (!txt_login.text.isEmpty && !txt_password.text.isEmpty  )  {
      prefs.setString("login", txt_login.text );
      prefs.setString("password", txt_password.text);
      prefs.setBool("connecte", true);
      Navigator.of(context)
          .pushReplacementNamed(IntroScreen.routeName);
    }
    else {
      const snackBar = SnackBar(
          content: Text('verifier votre addresse  et mot de pass')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
