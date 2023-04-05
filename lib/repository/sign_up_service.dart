import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/ui/pages/mypage.dart';

final signUpProvider = Provider<SignUpService>((ref) => SignUpService());

class SignUpService {
  // ユーザーの新規作成をするメソッド
  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        // pushAndRemoveUntilは前のページへ戻れないようにするコード.
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MyPage()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('メールアドレスのフォーマットが正しくありません'),
          ),
        );
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('現在指定したメールアドレスは使用できません'),
          ),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('指定したメールアドレスは登録されていません'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('パスワードが間違っています'),
          ),
        );
      }
    }
  }
}
