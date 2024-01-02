import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/firestore.dart';

class AsciiArtModel {
  final DocumentReference artDocument;
  final Map<String, dynamic> data;
  Map<String, dynamic> userData;
  final DocumentReference<Map<String, dynamic>> user;

  AsciiArtModel(
      {required this.user,
      this.userData = const {},
      required this.artDocument,
      required this.data});
  bool isGotData = false;

  bool get isLike {
    return userData["like"] ?? false;
  }

  bool get isDisLike {
    return userData["disLike"] ?? false;
  }

  int get likes => data["likes"];
  int get disLikes => data["disLikes"];

  String get art => data["art"];

  Future<WriteBatch> likeThis(Function refresh,
      [bool batchOnly = false]) async {
    await getData();
    WriteBatch batch = isDisLike
        ? await disLikeThis(refresh, true)
        : FireStore.instance.batch();

    int n = isLike ? -1 : 1;
    batch.set(user, {"like": !isLike}, SetOptions(merge: true));
    batch.update(artDocument, {"likes": FieldValue.increment(n)});
    data["likes"] += n;
    userData["like"] = !isLike;
    refresh();

    if (!batchOnly) {
      await batch.commit();
    }
    return batch;
  }

  Future<WriteBatch> disLikeThis(Function refresh,
      [bool batchOnly = false]) async {
    await getData();
    WriteBatch batch =
        isLike ? await likeThis(refresh, true) : FireStore.instance.batch();

    int n = isDisLike ? -1 : 1;
    batch.set(user, {"disLike": !isDisLike}, SetOptions(merge: true));
    batch.update(artDocument, {"disLikes": FieldValue.increment(n)});
    data["disLikes"] += n;
    userData["disLike"] = !isDisLike;
    refresh();
    if (!batchOnly) {
      await batch.commit();
    }
    return batch;
  }

  Future getData() async {
    if (isGotData) return;
    log("gett");
    userData = (await user.get()).data() ?? {};
    isGotData = true;
  }
}
