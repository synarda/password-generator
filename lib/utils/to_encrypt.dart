import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:get/get.dart';
import 'package:password_generator/controllers/auth_controller.dart';

class EncryptionAndDecryption {
  static final EncryptionAndDecryption _singleton = EncryptionAndDecryption._internal();

  factory EncryptionAndDecryption() {
    return _singleton;
  }

  EncryptionAndDecryption._internal();

  encrypt.Key? key;
  encrypt.Encrypter? encrypter;

  final iv = encrypt.IV.fromLength(16);

  void refreshKey(String hash) {
    final uid = Get.find<AuthController>().user.value?.uid;
    if (uid == null) return;
    key = encrypt.Key.fromUtf8(hash);
    encrypter = encrypt.Encrypter(encrypt.AES(key!));
  }

  String? encryptAES(txt) {
    final encrpted = encrypter?.encrypt(txt, iv: iv);
    return encrpted?.base64;
  }

  String? decryptAES(txt) {
    final decrypted = encrypter?.decrypt(encrypt.Encrypted.fromBase64(txt), iv: iv);
    return decrypted;
  }
}
