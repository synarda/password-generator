import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Question {
  final int index;
  final String text;

  Question({
    required this.index,
    required this.text,
  });
}

class QuestionsApi {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth userInfo = FirebaseAuth.instance;

  static Future<void> createQuestion(int index, String text) async {
    final docRef = firestore.collection("questions").doc(userInfo.currentUser!.uid);
    await docRef.set({"index": index, "text": text});
  }

  static Future<Question> getQuestion() async {
    final result = await firestore.collection("questions").doc(userInfo.currentUser!.uid).get();
    return Question(index: result.data()?["index"] ?? -1, text: result.data()?["text"] ?? "");
  }
}
