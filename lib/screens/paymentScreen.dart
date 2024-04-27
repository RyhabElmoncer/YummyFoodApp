import 'package:flutter/material.dart';
import 'package:yummyfoodapp/const/colors.dart';
import 'package:yummyfoodapp/utils/helper.dart';
import 'package:yummyfoodapp/widgets/customNavBar.dart';
import 'package:yummyfoodapp/widgets/customTextInput.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = "/paymentScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Détails de paiement",
                          style: Helper.getTheme(context).headline5,
                        ),
                      ),
                      Image.asset(
                        Helper.getAssetName(
                          "cart.png",
                          "virtual",
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "Mode de paiement",
                        style: Helper.getTheme(context).headline3,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: AppColor.placeholder,
                    thickness: 1.5,
                    height: 30,
                  ),
                ),
                Container(
                  height: 170,
                  width: Helper.getScreenWidth(context),
                  decoration: BoxDecoration(
                    color: AppColor.placeholderBg,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.placeholder.withOpacity(0.5),
                        offset: Offset(0, 20),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Espèces/Carte ",
                              style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.check,
                              color: AppColor.orange,
                            )
                          ],
                        ),
                        Divider(
                          color: AppColor.placeholder,
                          thickness: 1,
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Image.asset(
                                Helper.getAssetName("visa.png", "real"),
                              ),
                            ),
                            Text("**** ****"),
                            Text("5827410"),
                            OutlinedButton(
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      color: AppColor.orange,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    StadiumBorder(),
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                      AppColor.orange)),
                              onPressed: () {},
                              child: Text("Supprimer la carte"),
                            )
                          ],
                        ),
                        Divider(
                          color: AppColor.placeholder,
                          thickness: 1,
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Autres méthodes",
                              style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            isScrollControlled: true,
                            isDismissible: false,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: Helper.getScreenHeight(context) * 0.7,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Ajouter une carte de crédit/débit",
                                            style: Helper.getTheme(context)
                                                .headline3,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Divider(
                                        color: AppColor.placeholder
                                            .withOpacity(0.5),
                                        thickness: 1.5,
                                        height: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: CustomTextInput(
                                          hintText: "Numéro de carte"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Expiry"),
                                          SizedBox(
                                            height: 50,
                                            width: 100,
                                            child: CustomTextInput(
                                              hintText: "MM",
                                              padding: const EdgeInsets.only(
                                                  left: 35),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 100,
                                            child: CustomTextInput(
                                              hintText: "YY",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: CustomTextInput(
                                          hintText: "Code de sécurité"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: CustomTextInput(
                                          hintText: "Prénom"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: CustomTextInput(
                                          hintText: "Nom"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Vous pouvez retirer cette carte"),
                                          Switch(
                                            value: false,
                                            onChanged: (_) {},
                                            thumbColor:
                                                MaterialStateProperty.all(
                                              AppColor.secondary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                ),
                                                SizedBox(width: 40),
                                                Text("Ajouter une carte"),
                                                SizedBox(width: 40),
                                              ],
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text("Ajouter une autre carte de crédit/débit"),
                        ],
                      )),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(),
          ),
        ],
      ),
    );
  }
}
