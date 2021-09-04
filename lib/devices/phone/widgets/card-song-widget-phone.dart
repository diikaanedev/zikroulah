import 'package:flutter/material.dart';
import 'package:zikroulah/devices/phone/screens/song-screen.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/song-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardSongWidgetPhone extends StatefulWidget {
  final SongModel song;
  final int type;

  const CardSongWidgetPhone({Key? key, required this.song, required this.type})
      : super(key: key);
  @override
  _CardSongWidgetPhoneState createState() => _CardSongWidgetPhoneState();
}

class _CardSongWidgetPhoneState extends State<CardSongWidgetPhone> {
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
          appState.setState(() {
            appState.song = widget.song;
          });
          Navigator.popAndPushNamed(context, '/');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SongScreen(songModel: widget.song, type: widget.type),
              ));
        },
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
              ),
              Positioned(
                  left: constraints.maxWidth * .05,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * .22,
                    decoration: BoxDecoration(
                        image: urlTof == ''
                            ? DecorationImage(
                                image: AssetImage('assets/images/logo.png'))
                            : DecorationImage(
                                image: NetworkImage(urlTof),
                                fit: BoxFit.contain)),
                  )),
              Positioned(
                  left: constraints.maxWidth * .27,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * .4,
                    // color: cons.vert(),
                    child: Column(
                      children: [
                        Spacer(),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                        Container(
                          width: constraints.maxWidth,
                          child: Text(
                            '${widget.song.name}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: constraints.maxWidth * .04,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: constraints.maxWidth,
                          child: Text(
                            '3:30',
                            style: TextStyle(
                                fontSize: constraints.maxWidth * .02,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                      ],
                    ),
                  )),
              Positioned(
                  left: constraints.maxWidth * .7,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * .1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/onde-zikroula-bon.gif'))),
                  )),
              Positioned(
                  right: constraints.maxWidth * .05,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * .05,
                    child: Center(
                      child: Icon(
                        Icons.more_vert_outlined,
                        color: cons.vert(),
                        size: 28,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
}
