import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:zikroulah/devices/phone/widgets/card-artiste-widget-phone.dart';
import 'package:zikroulah/devices/phone/widgets/card-song-widget-phone.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/artiste-model.dart';
import 'package:zikroulah/models/song-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class ArtisteScreen extends StatefulWidget {
  final ArtisteModel artiste;
  final int typeArtiste;

  const ArtisteScreen(
      {Key? key, required this.artiste, required this.typeArtiste})
      : super(key: key);
  @override
  _ArtisteScreenState createState() => _ArtisteScreenState();
}

class _ArtisteScreenState extends State<ArtisteScreen> {
  late ConstantByDii cons;
  late Size size;
  late String name;
  late List<ArtisteModel> listeArti = [];

  late List<SongModel> listeSong = [];

  getListeArti() async {
    String c = widget.typeArtiste == 0 ? 'chanteur' : 'conferencier';
    await FirebaseStorage.instance
        .refFromURL('gs://laye-2946e.appspot.com')
        .child(appState.tarikha.name.toLowerCase())
        .child(c)
        .listAll()
        .then((result) {
      result.prefixes.forEach((element) async {
        setState(() {
          listeArti.add(ArtisteModel(ref: element, type: 0));
        });
      });
    });
  }

  getListeSong() async {
    String c = widget.typeArtiste == 0 ? 'chanteur' : 'conferencier';

    await FirebaseStorage.instance
        .refFromURL('gs://laye-2946e.appspot.com')
        .child(appState.tarikha.name.toLowerCase())
        .child(c)
        .child(widget.artiste.ref.name)
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
    });

    setState(() {
      name = cons.getName(widget.artiste.ref.name.split(('-')));
    });
    getListeArti();
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
                  name,
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
              top: size.height * .07,
              child: Container(
                height: size.height * .7,
                width: size.width,
                // color: cons.vert(),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: getListSong(),
                ),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height * .19,
                width: size.width,
                // color: cons.vert(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        // color: cons.vert(),
                        child: Center(
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.expand_less_outlined,
                              color: cons.blanc(),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: cons.vert()),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: size.height * .15,
                      width: size.width,
                      // color: cons.vert(),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: getListe(),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getListSong() {
    List<Widget> liste = [];
    for (var item in listeSong) {
      print(item.urlFichier);
      liste.add(
        Container(
          height: size.height * .12,
          width: size.width,
          child: CardSongWidgetPhone(
            song: item,
            type: widget.typeArtiste,
          ),
        ),
      );
    }
    return liste;
  }

  getListe() {
    List<Widget> liste = [];
    for (var item in listeArti.toList()) {
      liste.add(
        Container(
          width: size.width * .3,
          height: size.height * .3,
          child: CardArtisteWidgetPhone(
            artiste: item,
            type: widget.typeArtiste,
          ),
        ),
      );
    }
    return liste;
  }
}
