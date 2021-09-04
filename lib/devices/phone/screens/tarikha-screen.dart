import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:zikroulah/devices/phone/widgets/card-artiste-widget-phone.dart';
import 'package:zikroulah/devices/phone/widgets/card-menu-buttom-widget.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/artiste-model.dart';
import 'package:zikroulah/models/tarikha-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class TarikhaScreen extends StatefulWidget {
  final TarikhaModel titleTarikha;

  const TarikhaScreen({Key? key, required this.titleTarikha}) : super(key: key);
  @override
  _TarikhaScreenState createState() => _TarikhaScreenState();
}

class _TarikhaScreenState extends State<TarikhaScreen> {
  late Size size;
  late ConstantByDii cons;
  late int type = 0;

  late List<ArtisteModel> listeArti = [];

  getArtiste() async {
    await FirebaseStorage.instance
        .refFromURL('gs://laye-2946e.appspot.com')
        .child(widget.titleTarikha.name.toLowerCase())
        .child('chanteur')
        .listAll()
        .then((result) {
      result.prefixes.forEach((element) async {
        setState(() {
          listeArti.add(ArtisteModel(ref: element, type: 0));
        });
      });
    });
  }

  getUrlTof(Reference el) async {
    var liste = await el.listAll();

    for (var item in liste.items) {
      if (item.name.contains('.png')) {
        item.getDownloadURL().then((value) => print(value));
        return item.getDownloadURL().then((value) => value);
      }
    }

    return '';
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
    getArtiste();
  }

  @override
  Widget build(BuildContext context) {
    StatusBar.color(cons.blanc());

    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        // title: Text(widget.titleTarikha.name),
        elevation: .0,
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
                  '${widget.titleTarikha.name}',
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
              top: size.height * .05,
              child: Container(
                height: size.height * .8,
                width: size.width,
                // color: cons.noir(),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      height: size.height * .05,
                      width: size.width * .95,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * .03,
                          ),
                          Icon(
                            Icons.mic_sharp,
                            color: cons.vert(),
                          ),
                          Spacer(),
                          Text(
                            'Artistes, Titres , Playlist ...',
                            style: TextStyle(
                                color: cons.noir(),
                                fontSize: 16,
                                fontWeight: FontWeight.w200),
                          ),
                          Spacer(),
                          Icon(
                            Icons.search_outlined,
                            size: 24,
                            color: cons.noir(),
                          ),
                          SizedBox(
                            width: size.width * .07,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          // color: cons.vert(),
                          border: Border.all(color: cons.vert(), width: .8),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Spacer(),
                    Container(
                      height: size.height * .05,
                      width: size.width,
                      // color: cons.vert(),
                      child: Row(
                        children: [
                          // Spacer(),
                          // Text(
                          //   'Biographie',
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       // decoration: TextDecoration.underline,
                          //       fontWeight: FontWeight.bold,
                          //       color: cons.noir()),
                          // ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                type = 0;
                                listeArti = [];
                              });
                              await FirebaseStorage.instance
                                  .refFromURL('gs://laye-2946e.appspot.com')
                                  .child(widget.titleTarikha.name.toLowerCase())
                                  .child('chanteur')
                                  .listAll()
                                  .then((result) {
                                result.prefixes.forEach((element) async {
                                  setState(() {
                                    listeArti.add(
                                        ArtisteModel(ref: element, type: 0));
                                  });
                                });
                              });
                            },
                            child: Text(
                              widget.titleTarikha.name.toLowerCase() == 'coran'
                                  ? ' Tajwîd'
                                  : 'Chanteurs',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: type == 0
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: type == 0 ? cons.vert() : cons.noir()),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                type = 1;
                                listeArti = [];
                              });
                              await FirebaseStorage.instance
                                  .refFromURL('gs://laye-2946e.appspot.com')
                                  .child(widget.titleTarikha.name.toLowerCase())
                                  .child('conferencier')
                                  .listAll()
                                  .then((result) {
                                result.prefixes.forEach((element) async {
                                  setState(() {
                                    listeArti.add(
                                        ArtisteModel(ref: element, type: 1));
                                  });
                                });
                              });
                            },
                            child: Text(
                              widget.titleTarikha.name.toLowerCase() == 'coran'
                                  ? 'Tafsīr'
                                  : 'Conférences',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: type == 1
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: type == 1 ? cons.vert() : cons.noir()),
                            ),
                          ),
                          // Spacer(),
                          // Text(
                          //   'Ouvrages',
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       // decoration: TextDecoration.underline,
                          //       fontWeight: FontWeight.bold,
                          //       color: cons.noir()),
                          // ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: size.height * .63,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          crossAxisCount: 3,
                          // childAspectRatio: 1.2,
                          physics: BouncingScrollPhysics(),
                          children: getListe(),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )),
          CardMenuButtomWidget()
        ],
      ),
    );
  }

  getListe() {
    List<Widget> liste = [];
    print("type =>  $type");
    for (var item
        in listeArti.where((element) => element.type == type).toList()) {
      liste.add(
        CardArtisteWidgetPhone(
          artiste: item,
          type: type,
        ),
      );
    }
    return liste;
  }
}
