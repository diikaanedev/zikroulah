import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/artiste-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardArtisteAbonnementWigdetPhone extends StatefulWidget {
  final ArtisteModel artiste;

  const CardArtisteAbonnementWigdetPhone({Key? key, required this.artiste})
      : super(key: key);
  @override
  _CardArtisteAbonnementWigdetPhoneState createState() =>
      _CardArtisteAbonnementWigdetPhoneState();
}

class _CardArtisteAbonnementWigdetPhoneState
    extends State<CardArtisteAbonnementWigdetPhone> {
  late ConstantByDii cons;
  late String urlTof = '';
  late Stream<DocumentSnapshot> likes;
  late String name;
  bool isAbon = false;
  late int like = 0;
  late int favorie = 0;
  late int abone = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
    setState(() {
      name = cons.getName(appState.artiste.ref.name.split(('-')));
      likes =
          FirebaseFirestore.instance.collection('data').doc(name).snapshots();
    });

    FirebaseFirestore.instance.collection('data').doc(name).get().then((value) {
      List d = value.get('abonnement') as List;
      setState(() {
        isAbon = d.contains(FirebaseAuth.instance.currentUser!.uid);
      });
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
  Widget build(BuildContext context) => StreamBuilder<DocumentSnapshot>(
      stream: likes,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        likes.first.then((value) {
          var d = value.get('abonnement') as List;
          setState(() {
            like = value.get('like');
            favorie = value.get('favorie');
            abone = d.length;
          });
        });
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return LayoutBuilder(
            builder: (context, constraints) => Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    ),
                    Positioned(
                        child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * .4,
                      decoration: BoxDecoration(
                          image: urlTof == ''
                              ? DecorationImage(
                                  image: AssetImage('assets/images/logo.png'))
                              : DecorationImage(
                                  image: NetworkImage(urlTof),
                                  fit: BoxFit.contain)),
                    )),
                    Positioned(
                        left: constraints.maxWidth * .3,
                        child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth * .4,
                          // color: cons.vert(),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                width: constraints.maxWidth * .4,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * .05,
                                    ),
                                    Text(
                                      '$abone Abonnées',
                                      style: TextStyle(
                                          decorationColor: cons.vert(),
                                          fontSize: constraints.maxHeight * .1,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * .05,
                              ),
                              Container(
                                width: constraints.maxWidth * .5,
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      '${snapshot.data!.get('like')}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * .005,
                                    ),
                                    Icon(
                                      Icons.thumb_up_alt_rounded,
                                      color: cons.vert(),
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * .01,
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: cons.vert(),
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * .005,
                                    ),
                                    Text(
                                      '$favorie',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            var id = FirebaseAuth.instance.currentUser!.uid;
                            await FirebaseFirestore.instance
                                .collection('data')
                                .doc(name)
                                .snapshots()
                                .first
                                .then((value) {
                              List d = value.get('abonnement') as List;
                              bool verif = false;
                              for (var item in d) {
                                if (id == item) {
                                  verif = true;
                                }
                              }
                              if (!verif) {
                                d.add(id);
                              } else {
                                d.remove(id);
                              }
                              setState(() {
                                isAbon = !isAbon;
                              });
                              FirebaseFirestore.instance
                                  .collection('data')
                                  .doc(name)
                                  .update({'abonnement': d});
                            });
                          },
                          child: Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth * .35,
                            // color: cons.noir(),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: cons.vert(),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  isAbon
                                      ? '  Se désabonner  '
                                      : '  S\'abonner  '.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 14, color: cons.blanc()),
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ));
      });
}
