import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ascii_art_model.dart';
import '../shared/auth.dart';

class TopArtsProvider with ChangeNotifier {
  bool isLoading = true;
  bool done = false;
  List<AsciiArtModel> models = [];

  Future disLike(String id) async {
    await models
        .firstWhere((e) => e.artDocument.id == id)
        .disLikeThis(notifyListeners);
    notifyListeners();
  }

  Future like(String id) async {
    await models
        .firstWhere((e) => e.artDocument.id == id)
        .likeThis(notifyListeners);
    notifyListeners();
  }

  Future getTopArts() async {
    log("getting ...");
    if (done) return;
    final data = await FirebaseFirestore.instance
        .collectionGroup("arts")
        .limit(15)
      
        .orderBy("likes", descending: true)
        .get();
    for (var a in data.docs) {
      models.add(
        AsciiArtModel(
          artDocument: a.reference,
          data: a.data(),
          user: a.reference.collection("users").doc(Auth.uid),
        ),
      );
      done = true;
      isLoading = false;
      notifyListeners();
      log("new");
      // print(model.art);
    }
    log(data.docs.length.toString());
    isLoading = false;
    notifyListeners();
  }

  static ChangeNotifierProvider<TopArtsProvider> create() {
    return ChangeNotifierProvider(create: (context) => TopArtsProvider());
  }
}
