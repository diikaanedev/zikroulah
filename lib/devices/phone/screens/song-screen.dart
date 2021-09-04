import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:zikroulah/devices/phone/widgets/card-abonnement-widget-phone.dart';
import 'package:zikroulah/devices/phone/widgets/card-song-widget-phone.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/song-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class SongScreen extends StatefulWidget {
  final SongModel songModel;
  final int type;

  const SongScreen({Key? key, required this.songModel, required this.type})
      : super(key: key);
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late Size size;
  late ConstantByDii cons;
  late AssetsAudioPlayer audioPlayer;
  double widthVert = 0;
  bool isPlay = true;
  // List<Wigdet> playList = [];
  late String urlTof = '';
  late String name;

  late List<SongModel> listeSong = [];

  getListeSong() async {
    String c = widget.type == 0 ? 'chanteur' : 'conferencier';

    await FirebaseStorage.instance
        .refFromURL('gs://laye-2946e.appspot.com')
        .child(appState.tarikha.name.toLowerCase())
        .child(c)
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
      audioPlayer = AssetsAudioPlayer();
      // audioPlayer.open(Audio.network(widget.songModel.urlFichier));
    });
    setState(() {
      name = cons.getName(appState.artiste.ref.name.split(('-')));
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

    getListeSong();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBar.color(cons.blanc());

    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        backgroundColor: cons.blanc(),
        elevation: 0.0,
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
                height: size.height * .4,
                width: size.width,
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      height: size.height * .05,
                      // color: cons.gris(),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * .07,
                          ),
                          Icon(
                            Icons.shuffle_outlined,
                            color: cons.vert(),
                            size: 24,
                          ),
                          Spacer(),
                          Icon(
                            Icons.repeat_rounded,
                            color: cons.vert(),
                            size: 24,
                          ),
                          SizedBox(
                            width: size.width * .07,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: cons.blanc(),
                  image: urlTof == ''
                      ? DecorationImage(
                          image: AssetImage('assets/images/logo.png'))
                      : DecorationImage(
                          image: NetworkImage(urlTof), fit: BoxFit.contain),
                ),
              )),
          Positioned(
              top: size.height * .44,
              child: Container(
                height: size.height * .17,
                width: size.width,
                child: Column(
                  children: [
                    Container(
                      height: size.height * .05,
                      width: size.width * .6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/onde-zikroula-bon.gif'),
                              fit: BoxFit.contain)),
                    ),
                    // Spacer(),
                    Container(
                      height: size.height * .12,
                      width: size.width,
                      child: LayoutBuilder(
                        builder: (context, constraints) => Stack(
                          children: [
                            Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                            ),
                            Positioned(
                                child: Container(
                              height: constraints.maxHeight * .4,
                              width: constraints.maxWidth,
                              // color: cons.gris(),
                              child: Center(
                                  child: Text(
                                'Titre : ${widget.songModel.name}',
                                style:
                                    TextStyle(fontSize: 24, color: cons.vert()),
                              )),
                            )),
                            Positioned(
                                top: constraints.maxHeight * .4,
                                left: constraints.maxWidth * .05,
                                child: Container(
                                  height: constraints.maxHeight * .1,
                                  width: constraints.maxWidth * .9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: cons.gris(),
                                  ),
                                )),
                            Positioned(
                                top: constraints.maxHeight * .4,
                                left: constraints.maxWidth * .05,
                                child: Container(
                                  height: constraints.maxHeight * .1,
                                  width: widthVert,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: cons.vert(),
                                  ),
                                )),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  height: constraints.maxHeight * .5,
                                  width: constraints.maxWidth,
                                  // color: cons.noir(),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxWidth * .07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              constraints.maxWidth * .07),
                                          color: cons.vert(),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            audioPlayer.stop();
                                            Navigator.pop(context);
                                            appState.setState(() {
                                              appState.song = listeSong[
                                                  listeSong.indexOf(
                                                          widget.songModel) -
                                                      1];
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SongScreen(
                                                          songModel:
                                                              appState.song,
                                                          type: widget.type),
                                                ));
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.skip_previous_rounded,
                                              color: cons.blanc(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .05,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPlay = !isPlay;
                                          });
                                        },
                                        child: Container(
                                          width: constraints.maxWidth * .1,
                                          height: constraints.maxWidth * .1,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                constraints.maxWidth * .1),
                                            color: cons.vert(),
                                          ),
                                          child: AudioWidget.network(
                                            url: widget.songModel.urlFichier,
                                            play: isPlay,
                                            loopMode: LoopMode.none,
                                            initialPosition:
                                                Duration(seconds: 0),
                                            onPositionChanged:
                                                (current, total) {
                                              setState(() {
                                                widthVert = current.inSeconds *
                                                    (constraints.maxWidth *
                                                        .9) /
                                                    total.inSeconds;
                                              });
                                            },
                                            onFinished: () {
                                              audioPlayer.stop();
                                              Navigator.pop(context);
                                              appState.setState(() {
                                                appState.song = listeSong[
                                                    listeSong.indexOf(
                                                            widget.songModel) +
                                                        1];
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SongScreen(
                                                            songModel:
                                                                appState.song,
                                                            type: widget.type),
                                                  ));
                                            },
                                            child: Center(
                                              child: Icon(
                                                isPlay
                                                    ? Icons.pause_outlined
                                                    : Icons.play_arrow_outlined,
                                                color: cons.blanc(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * .05,
                                      ),
                                      Container(
                                        width: constraints.maxWidth * .07,
                                        height: constraints.maxWidth * .07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              constraints.maxWidth * .07),
                                          color: cons.vert(),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            audioPlayer.stop();
                                            Navigator.pop(context);
                                            appState.setState(() {
                                              appState.song = listeSong[
                                                  listeSong.indexOf(
                                                          widget.songModel) +
                                                      1];
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SongScreen(
                                                          songModel:
                                                              appState.song,
                                                          type: widget.type),
                                                ));
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.skip_next_rounded,
                                              color: cons.blanc(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      // color: cons.noir(),
                    )
                  ],
                ),
                // color: cons.noir(),
              )),
          Positioned(
              top: size.height * .611,
              child: Container(
                height: size.height * .1,
                width: size.width,
                child: CardAbonnementWidgetPhone(),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height * .25,
                width: size.width,
                decoration: BoxDecoration(color: cons.blanc(), boxShadow: [
                  BoxShadow(
                      blurRadius: .6, color: cons.gris(), offset: Offset(0, -1))
                ]),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: getListe(),
                ),
              )),
          Positioned(
              bottom: size.height * .23,
              left: size.width * .5 - 15,
              child: Container(
                height: 30,
                width: 30,
                child: Center(
                  child: Icon(
                    Icons.expand_less_outlined,
                    color: cons.blanc(),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: cons.vert()),
              ))
        ],
      ),
    );
  }

  getListe() {
    List<Widget> listes = [];

    for (var item in listeSong) {
      listes.add(Container(
        height: size.height * .07,
        width: size.width,
        child: CardSongWidgetPhone(
          song: item,
          type: widget.type,
        ),
      ));
    }
    return listes;
  }
}
