import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ascii_art_model.dart';
import '../presentation/dialogs/oops_dialog.dart';
import '../shared/auth.dart';
import '../shared/firestore.dart';

class HomePageProvider with ChangeNotifier {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchBarController = TextEditingController();

  List<AsciiArtModel> asciiModels = [];

  QuerySnapshot<Map<String, dynamic>>? response;

  Map<String, dynamic> lastDoc = {};

  bool done = false;
  bool note = false;
  bool isloading = false;

  onChange() {
    done = false;
    lastDoc = {};
    response = null;
    notifyListeners();
  }

  setText(String text) {
    searchBarController.text = text;
    onChange();
    notifyListeners();
  }

  void unfocus() => focusNode.unfocus();
  void openDrawer() => key.currentState?.openDrawer();

  Future search(BuildContext context, [bool fromButton = false]) async {
    if (isloading || done || (lastDoc.isNotEmpty && fromButton)) return;
    isloading = true;
    unfocus();
    if (lastDoc.isEmpty) {
      asciiModels = [];
    }

    notifyListeners();
    await _search(searchBarController.text);
    // try {

    // } catch (e) {
    //   log(e.toString());
    //   OopsDialog.show(context, e.toString());
    // }
    note = true;

    isloading = false;
    notifyListeners();
  }

  Future disLike(String id) async {
    await asciiModels
        .firstWhere((e) => e.artDocument.id == id)
        .disLikeThis(notifyListeners);
    notifyListeners();
  }

  Future like(String id) async {
    await asciiModels
        .firstWhere((e) => e.artDocument.id == id)
        .likeThis(notifyListeners);
    notifyListeners();
  }

  static ChangeNotifierProvider<HomePageProvider> create() {
    return ChangeNotifierProvider(create: (context) => HomePageProvider());
  }

  _search(String query) async {
    bool t = response == null;

    response ??= await FireStore.instance
        .collection('ascii-arts')
        .where("keywords", arrayContainsAny: query.split(' '))
        .get();

    // add the defult last document witch is null
    if (t) {
      for (var d in response!.docs) {
        lastDoc[d.id] = null;
      }
    }

    int i = 0;

    for (var document in response!.docs) {
      late var q = document.reference
          .collection("arts")
          .orderBy("likes", descending: true)
          .limit(12 - i);

      if (lastDoc[document.id] != null) {
        q = q.startAfterDocument(lastDoc[document.id]);
      }

      final QuerySnapshot<Map<String, dynamic>> data = await q.get();

      for (var a in data.docs) {
        i++;
        lastDoc[document.id] = a;

        asciiModels.add(
          AsciiArtModel(
            artDocument: a.reference,
            data: a.data(),
            user: a.reference.collection("users").doc(Auth.uid),
          ),
        );
      }

      if (document.id == response!.docs.last.id) {
        if (i < 12) {
          done = true;
        }
      }

      if (i >= 12) {
        i = 0;
        break;
      }
    }

    // sort item by like to make all given collection as one
    // asciiModels.sort((a, b) => b.likes.compareTo(a.likes));

    notifyListeners();
  }
}
