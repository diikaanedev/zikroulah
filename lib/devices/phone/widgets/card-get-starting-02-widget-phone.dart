import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zikroulah/devices/phone/widgets/card-categorie-get-starting.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardGetStarting02Widget extends StatefulWidget {
  @override
  _CardGetStarting02WidgetState createState() =>
      _CardGetStarting02WidgetState();
}

class _CardGetStarting02WidgetState extends State<CardGetStarting02Widget> {
  late ConstantByDii cons;
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
      auth = FirebaseAuth.instance;
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(color: cons.blanc())),
            Positioned(
                top: -10,
                left: -10,
                child: Container(
                  height: constraints.maxHeight * .3,
                  width: constraints.maxWidth * 1.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/get-starting-02.png'),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                // top: constraints.maxHeight * .05,
                child: Container(
              height: constraints.maxHeight * .1,
              width: constraints.maxWidth,
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    'Clicker sur une icone pour acceder au menu',
                    style: TextStyle(
                        color: cons.blanc(),
                        fontSize: constraints.maxHeight * .02),
                  ),
                  Spacer(),
                ],
              ),
            )),
            Positioned(
                top: constraints.maxHeight * .27,
                child: Container(
                  height: constraints.maxHeight * .5,
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      Container(
                        height: constraints.maxHeight * .15,
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .3,
                              height: constraints.maxHeight * .15,
                              child: CardCategorieGetStartingWidgetPhone(
                                  tarikhaModel: appState.listeTarikha[0]),
                            ),
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .3,
                              height: constraints.maxHeight * .15,
                              child: CardCategorieGetStartingWidgetPhone(
                                  tarikhaModel: appState.listeTarikha[1]),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .0,
                      ),
                      Container(
                        height: constraints.maxHeight * .15,
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .3,
                              height: constraints.maxHeight * .15,
                              child: CardCategorieGetStartingWidgetPhone(
                                  tarikhaModel: appState.listeTarikha[2]),
                            ),
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .3,
                              height: constraints.maxHeight * .15,
                              child: CardCategorieGetStartingWidgetPhone(
                                  tarikhaModel: appState.listeTarikha[3]),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .0,
                      ),
                      Container(
                        height: constraints.maxHeight * .15,
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .3,
                              height: constraints.maxHeight * .15,
                              child: CardCategorieGetStartingWidgetPhone(
                                  tarikhaModel: appState.listeTarikha[4]),
                            ),
                            Spacer(),
                            Container(
                              width: constraints.maxWidth * .3,
                              height: constraints.maxHeight * .15,
                              child: CardCategorieGetStartingWidgetPhone(
                                  tarikhaModel: appState.listeTarikha[5]),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
            Positioned(
                bottom: constraints.maxHeight * .07,
                left: constraints.maxWidth * .15,
                child: GestureDetector(
                  onTap: () async {
                    await auth.signInAnonymously();

                    Navigator.popAndPushNamed(context, '/');
                  },
                  child: Container(
                    height: constraints.maxHeight * .07,
                    width: constraints.maxWidth * .7,
                    child: Center(
                      child: Text(
                        'Commencez',
                        style: TextStyle(
                            fontSize: constraints.maxHeight * .03,
                            fontWeight: FontWeight.bold,
                            color: cons.blanc()),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: cons.vert(),
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * .1)),
                  ),
                )),
            Positioned(
                bottom: constraints.maxHeight * .17,
                // left: constraints.maxWidth * .05,
                child: GestureDetector(
                  // onTap: () {},
                  child: Container(
                    // height: constraints.maxHeight * .07,
                    width: constraints.maxWidth,
                    child: Center(
                      child: Text(
                        'Découvrez une application entierement \n repensée enfin de vous proposer une meilleure \n expérience d\'utilisation et une utilisation simple ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: constraints.maxHeight * .02,
                            fontWeight: FontWeight.w300,
                            color: cons.noir()),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      );
}
