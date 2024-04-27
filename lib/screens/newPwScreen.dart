import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import './introScreen.dart';

class NewPwScreen extends StatelessWidget {
  static const routeName = "/newPw";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("nouveau mot de passe", style: Helper.getTheme(context).headline6),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Veuillez entrer votre e-mail pour recevoir un lien pour créer un nouveau mot de passe par e-mail",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextInput(hintText: "nouveau mot de passe"),
                SizedBox(
                  height: 20,
                ),
                CustomTextInput(
                  hintText: "Confirmez le mot de passe",
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(IntroScreen.routeName);
                    },
                    child: Text("Suivant"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
