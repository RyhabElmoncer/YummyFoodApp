import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:yummyfoodapp/screens/OrderList.dart';
import 'package:yummyfoodapp/screens/forgetPwScreen.dart';

import '../const/colors.dart';
import '../screens/signUpScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import 'HomeScreenad.dart';
import 'homeScreen.dart';
import 'introScreen.dart';

class SignUpScreenad extends StatelessWidget {
  static const routeName = "/SignUpScreenad";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Connexion",
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text('Ajoutez vos coordonnées pour vous connecter'),
                Spacer(),
                CustomTextInput(
                  hintText: "Votre e-mail",
                ),
                Spacer(
                  flex: 1,
                ),
                CustomTextInput(
                  hintText: "mot de passe",
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreenad.routeName);
                    },
                    child: Text("Connexion"),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
