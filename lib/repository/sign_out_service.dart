import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/ui/auth/sign_in_page.dart';

final signOutProvider = Provider<SignOutService>((ref) => SignOutService());

class SignOutService {
  // ログアウトするメソッド
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      // pushAndRemoveUntilは前のページへ戻れないようにするコード.
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInPage()),
          (route) => false);
    }
  }
}
