import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zikroulah/devices/phone/screens/artiste-screen-phone.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/artiste-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardArtisteWidgetPhone extends StatefulWidget {
  final ArtisteModel artiste;
  final int type;

  const CardArtisteWidgetPhone(
      {Key? key, required this.artiste, required this.type})
      : super(key: key);

  @override
  _CardArtisteWidgetPhoneState createState() => _CardArtisteWidgetPhoneState();
}

class _CardArtisteWidgetPhoneState extends State<CardArtisteWidgetPhone> {
  late ConstantByDii cons;
  late String urlTof = '';
  late String name;
  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
    setState(() {
      name = cons.getName(widget.artiste.ref.name.split('-'));
    });
    FirebaseFirestore.instance.collection('data').doc(name).get().then((doc) {
      if (doc.exists) {
      } else {
        doc.reference.set({"like": 0, "favorie": 0, "abonnement": 0});
      }
    });
    widget.artiste.ref.listAll().then((result) {
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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () {
            print("widget.type => ${widget.type}");
            appState.setState(() {
              appState.artiste = widget.artiste;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtisteScreen(
                      artiste: widget.artiste, typeArtiste: widget.type),
                ));
          },
          child: Stack(
            children: [
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                color: cons.blanc(),
              ),
              Positioned(
                  // top: constraints.maxHeight * .03,
                  left: constraints.maxWidth * .15,
                  child: Container(
                    height: constraints.maxHeight * .85,
                    width: constraints.maxWidth * .7,
                    decoration: BoxDecoration(
                        // color: cons.vert(),
                        image: urlTof == ''
                            ? DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.contain)
                            : DecorationImage(
                                image: NetworkImage(urlTof),
                                fit: BoxFit.contain)),
                  )),
              Positioned(
                  top: constraints.maxHeight * .72,
                  // left: constraints.maxWidth * .01,
                  child: Container(
                    height: constraints.maxHeight * .15,
                    width: constraints.maxWidth,
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
}
