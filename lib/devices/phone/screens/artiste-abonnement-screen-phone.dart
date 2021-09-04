import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:statusbar/statusbar.dart';
import 'package:zikroulah/devices/phone/widgets/card-artiste-abonnement-widget-phone.dart';
import 'package:zikroulah/devices/phone/widgets/card-song-widget-phone.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/artiste-model.dart';
import 'package:zikroulah/models/song-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class ArtisteAbonnementScreenPhone extends StatefulWidget {
  @override
  _ArtisteAbonnementScreenPhoneState createState() =>
      _ArtisteAbonnementScreenPhoneState();
}

class _ArtisteAbonnementScreenPhoneState
    extends State<ArtisteAbonnementScreenPhone> {
  late Size size;
  late ConstantByDii cons;
  late String name;

  late ArtisteModel artiste;

  late List<SongModel> listeSong = [];

  getListeSong() async {
    await FirebaseStorage.instance
        .refFromURL('gs://laye-2946e.appspot.com')
        .child(appState.tarikha.name.toLowerCase())
        .child(appState.artiste.type == 0 ? 'chanteur' : 'conference')
        .child(appState.artiste.ref.name)
        .listAll()
        .then((result) {
      result.items.forEach((element) async {
        String url = '';

        if (!element.name.contains('.png')) {
          await element.getDownloadURL().then((value) => url = value);
          setState(() {
            listeSong.add(SongModel(
                name: element.name.split('.mp3')[0], urlFichier: url));
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
      artiste = appState.artiste;
    });
    setState(() {
      name = cons.getName(appState.artiste.ref.name.split(('-')));
    });
    getListeSong();
  }

  @override
  Widget build(BuildContext context) {
    StatusBar.color(cons.blanc());

    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        elevation: 0,
        // title: Text(widget.artiste.name),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: cons.blanc(),
          ),
          Positioned(
              child: Container(
            height: size.height * .05,
            width: size.width,
            color: cons.blanc(),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.height * .03,
                    height: size.height * .03,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height * .05),
                        color: cons.vert()),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16,
                        color: cons.blanc(),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '$name',
                  style: TextStyle(
                      color: cons.vert(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert_outlined,
                  color: cons.vert(),
                  size: 28,
                ),
                SizedBox(
                  width: size.width * .05,
                ),
              ],
            ),
          )),
          Positioned(
              child: Container(
            height: size.height * .25,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/design background1-01.png'),
                    fit: BoxFit.fill)),
          )),
          Positioned(
              top: size.height * .25,
              child: Container(
                height: size.height * .7,
                width: size.width,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: getListSong(),
                ),
              )),
          Positioned(
              top: size.height * .05,
              child: Container(
                height: size.height * .25,
                width: size.width,
                child: CardArtisteAbonnementWigdetPhone(
                  artiste: artiste,
                ),
                // color: cons.vert(),
              )),
          Positioned(
              bottom: size.height * .04,
              left: size.width * .1,
              child: Container(
                height: size.height * .07,
                width: size.width * .8,
                child: Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        var id = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('data')
                            .doc(name)
                            .snapshots()
                            .first
                            .then((value) {
                          int d = value.get('like');
                          d = d + 1;
                          FirebaseFirestore.instance.collection('data')
                            ..doc(name).update({'like': d});
                        });
                      },
                      child: Icon(
                        Icons.thumb_up_alt_rounded,
                        color: cons.blanc(),
                        size: 30,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        var id = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('data')
                            .doc(name)
                            .snapshots()
                            .first
                            .then((value) {
                          int d = value.get('favorie');
                          d = d + 1;
                          FirebaseFirestore.instance.collection('data')
                            ..doc(name).update({'favorie': d});
                        });
                      },
                      child: Icon(
                        Icons.favorite,
                        color: cons.blanc(),
                        size: 30,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.add_rounded,
                      color: cons.blanc(),
                      size: 30,
                    ),
                    Spacer(),
                  ],
                ),
                decoration: BoxDecoration(
                    color: cons.vert(),
                    borderRadius: BorderRadius.circular(30)),
              ))
        ],
      ),
    );
  }

  getListSong() {
    List<Widget> liste = [];
    for (var item in listeSong) {
      liste.add(
        Container(
          height: size.height * .12,
          width: size.width,
          child: CardSongWidgetPhone(
            song: item,
            type: 0,
          ),
        ),
      );
    }
    return liste;
  }
}
