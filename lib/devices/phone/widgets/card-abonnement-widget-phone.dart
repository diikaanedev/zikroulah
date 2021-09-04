import 'package:flutter/material.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardAbonnementWidgetPhone extends StatefulWidget {
  @override
  _CardAbonnementWidgetPhoneState createState() =>
      _CardAbonnementWidgetPhoneState();
}

class _CardAbonnementWidgetPhoneState extends State<CardAbonnementWidgetPhone> {
  late ConstantByDii cons;
  late String urlTof = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
    appState.artiste.ref.listAll().then((result) {
      result.items.forEach((element) {
        if (element.name.contains('.png')) {
          element.getDownloadURL().then((value) {
            setState(() {
              urlTof = value;
            });
          });
        }
      });
      if (urlTof == '') {
        setState(() {
          urlTof = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.popAndPushNamed(context, '/artiste-abonnement');
        },
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: cons.vert()))),
              ),
              Positioned(
                  child: Container(
                height: constraints.maxHeight,
                width: constraints.maxHeight,
                decoration: BoxDecoration(
                    image: urlTof == ''
                        ? DecorationImage(
                            image: AssetImage('assets/images/logo.png'))
                        : DecorationImage(
                            image: NetworkImage(urlTof), fit: BoxFit.contain)),
              )),
              Positioned(
                  right: constraints.maxWidth * .4,
                  child: Container(
                    height: constraints.maxHeight,
                    // width: constraints.maxWidth * .3,
                    child: Center(
                      child: Text(
                        '0 Abonnées',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Positioned(
                  right: constraints.maxWidth * .1,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * .23,
                    // color: cons.vert(),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: cons.vert(),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          '  S\'abonner  '.toUpperCase(),
                          style: TextStyle(fontSize: 14, color: cons.blanc()),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
}
