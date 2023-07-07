import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_generator/models/tags.dart';

class TagApi {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth userInfo = FirebaseAuth.instance;

  static Stream<List<TagsModel>> getTags() {
    final results =
        firestore.collection("tags").doc(userInfo.currentUser!.uid).collection("tags").snapshots();

    return results.map((event) => event.docs.map((e) => TagsModel.fromMap(e.data())).toList());
  }

  static Future<void> createTag(String name, String emoji) async {
    final docRef =
        firestore.collection("tags").doc(userInfo.currentUser!.uid).collection("tags").doc();

    final uid = docRef.id;

    await docRef.set({"emoji": emoji, "name": name, "uid": uid});
  }

  static Future<void> deleteTag(String uid) async {
    await firestore
        .collection("tags")
        .doc(userInfo.currentUser!.uid)
        .collection("tags")
        .doc(uid.toString())
        .delete();
  }

  static Future<void> editTag(String uid, String name, String emoji) async {
    final docRef =
        firestore.collection("tags").doc(userInfo.currentUser!.uid).collection("tags").doc(uid);

    await docRef.set({"emoji": emoji, "name": name, "uid": uid});
  }

  static Future<bool> hasPasswords(String tagsUid) async {
    final docRef = await firestore
        .collection("password")
        .doc(userInfo.currentUser!.uid)
        .collection("password")
        .where("tagsUid", isEqualTo: tagsUid)
        .get();

    return docRef.docs.isNotEmpty;
  }
}
