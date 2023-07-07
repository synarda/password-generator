import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_generator/models/password.dart';

class PasswordApi {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth userInfo = FirebaseAuth.instance;
//get
  static Stream<List<PasswordModel>> getPasswords() {
    final results = firestore.collection("password").doc(userInfo.currentUser!.uid).collection("password").snapshots();
    return results.map((event) => event.docs.map((e) => PasswordModel.fromMap(e.data())).toList());
  }

//create
  static Future<String?> createPasswords(String name, String password, String tagsUid) async {
    final docRef = firestore.collection("password").doc(userInfo.currentUser!.uid).collection("password").doc();
    final uid = docRef.id;
    try {
      await docRef.set({"password": password, "name": name, "tagsUid": tagsUid, "uid": uid});
    } catch (_) {
      return null;
    }
    return uid;
  }

//delete
  static Future<void> deletePassword(String uid) async {
    await firestore.collection("password").doc(userInfo.currentUser!.uid).collection("password").doc(uid.toString()).delete();
  }
}
