import 'package:password_generator/utils/to_encrypt.dart';

class PasswordModel {
  final String password;
  final String name;
  final String uid;
  final String tagsUid;

  PasswordModel({
    required this.password,
    required this.name,
    required this.uid,
    required this.tagsUid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'name': name,
      'uid': uid,
      'tagsUid': tagsUid,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    String? pass;
    try {
      pass = EncryptionAndDecryption().decryptAES(map['password'] as String);
    } catch (_) {}
    return PasswordModel(
      password: pass ?? "",
      name: map['name'] as String,
      uid: map['uid'] as String,
      tagsUid: map['tagsUid'] as String,
    );
  }
}
