import 'package:flutter/material.dart';
import 'package:yummyfoodapp/screens/loginScreen.dart';
import 'package:yummyfoodapp/screens/signUpScreen.dart';

import '../utils/helper.dart';
import 'AuthentificationScreen.dart';
import 'SignUpScreenad.dart';
class LandingScreen extends StatelessWidget {
  static const routeName = "/landingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/real/back.png"),
              fit: BoxFit.cover,
            ),
          ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              Helper.getAssetName("logo.png", "real"),

            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      "Découvrez les meilleurs plats de plus de 1 000 restaurants et une livraison rapide à votre porte",
                      textAlign: TextAlign.center,
                      selectionColor:Colors.black,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AuthentificationPage.routeName);
                      },
                      child: Text("Connexion"),

                    ),
                  ),
                //  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          StadiumBorder(
                            side:
                                BorderSide(color: Colors.green, width: 1.5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: Text("Créer un Compte"),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          StadiumBorder(
                            side:
                            BorderSide(color: Colors.lightBlue, width: 1.5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreenad.routeName);
                      },
                      child: Text("Administration"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
