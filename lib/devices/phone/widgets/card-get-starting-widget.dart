import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardGetStartingWidget extends StatefulWidget {
  @override
  _CardGetStartingWidgetState createState() => _CardGetStartingWidgetState();
}

class _CardGetStartingWidgetState extends State<CardGetStartingWidget> {
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
                  height: constraints.maxHeight * .7,
                  width: constraints.maxWidth * 1.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/design-getting1-01-ConvertImage.png'),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                top: constraints.maxHeight * .05,
                child: Container(
                  height: constraints.maxHeight * .1,
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        'Bienvenue',
                        style: TextStyle(
                            color: cons.blanc(),
                            fontSize: constraints.maxHeight * .03),
                      ),
                      Text(
                        'Sur votre toute nouvelle application',
                        style: TextStyle(
                            color: cons.blanc(),
                            fontSize: constraints.maxHeight * .02),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
            Positioned(
                top: constraints.maxHeight * .15,
                child: Container(
                  height: constraints.maxHeight * .3,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/logo zikroula-blanc.png'))),
                )),
            Positioned(
                top: constraints.maxHeight * .33,
                child: Container(
                  height: constraints.maxHeight * .1,
                  width: constraints.maxWidth,
                  child: Center(
                    child: Text(
                      'Zikroula',
                      style: TextStyle(
                          fontSize: constraints.maxHeight * .04,
                          color: cons.blanc(),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Positioned(
                bottom: constraints.maxHeight * .2,
                left: constraints.maxWidth * .15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/get-starting-02');
                  },
                  child: Container(
                    height: constraints.maxHeight * .07,
                    width: constraints.maxWidth * .7,
                    child: Center(
                      child: Text(
                        'Continuez',
                        style: TextStyle(
                            fontSize: constraints.maxHeight * .03,
                            fontWeight: FontWeight.bold,
                            color: cons.blanc()),
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          cons.vert(),
                          cons.vert().withOpacity(.8),
                        ]),
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * .1)),
                  ),
                )),
            Positioned(
                bottom: constraints.maxHeight * .07,
                // left: constraints.maxWidth * .05,
                child: GestureDetector(
                  // onTap: () {},
                  child: Container(
                    // height: constraints.maxHeight * .07,
                    width: constraints.maxWidth,
                    child: Center(
                      child: Text(
                        'Zikroula est la toute premiere application \n dédiée aux chants religieux de toutes\n les communautés musulmanes',
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
