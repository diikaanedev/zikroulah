import 'package:firebase_storage/firebase_storage.dart';
import 'package:zikroulah/models/song-model.dart';

class ArtisteModel {
  late Reference ref;
  late int type;
  ArtisteModel({required this.ref, required this.type});
}
