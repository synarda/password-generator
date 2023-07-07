import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_generator/controllers/drawer_controller.dart';
import 'package:password_generator/controllers/enddrawer_controller.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/utils/helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../utils/alerts.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(_auth.userChanges());

    ever(user, (tempUser) async {
      if (tempUser == null) {
        try {
          Get.find<DrawerControllers>().clear();
        } catch (_) {}

        try {
          Get.find<EndDrawerController>().clear();
        } catch (_) {}
        return;
      }

      try {
        Get.find<DrawerControllers>().fetch();
      } catch (_) {}

      try {
        Get.find<EndDrawerController>().fetch();
      } catch (_) {}
    });

    super.onInit();
  }

  Future<void> signIn(
    String platform, {
    String? email,
    String? password,
    String? name,
  }) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);

    try {
      switch (platform) {
        case "google":
          await signInWithGoogle();
          break;
        case "apple":
          await signInWithApple();
          break;
        case "emailSignIn":
          await signInWithEmail(email!, password!);
          break;
        case "emailSignUp":
          await signUpWithEmail(email!, password!, name!);
          break;
        default:
          Alerts.showAlert("Success", "Not_Implement_yet".tr, 1500);
          break;
      }
      EasyLoading.dismiss();
    } catch (_) {}
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Alerts.showAlert("Success", "Send_Email".tr, 1500);
      return true;
    } on FirebaseAuthException catch (err) {
      Alerts.showAlert("error", err.code.tr, 1500);
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (err) {
      if (err.code == "unknown") {
        Alerts.showAlert("error", "please_insert_password".tr, 1500);
      } else {
        Alerts.showAlert("error", err.code.tr, 1500);
      }
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signUpWithEmail(String email, String password, String name) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredentials.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (err) {
      Alerts.showAlert("error", err.code.tr, 1500);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (err) {
      Alerts.showAlert("Success", err.code.tr, 1500);
      rethrow;
    } catch (_) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = Helper.sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await _auth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch (err) {
      Alerts.showAlert("error".tr, err.code.tr, 3000);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);

    try {
      await GoogleSignIn().disconnect();
    } catch (_) {}

    await _auth.signOut();
    Get.back();
    Get.delete<Homecontroller>();
    EasyLoading.dismiss();
  }
}
