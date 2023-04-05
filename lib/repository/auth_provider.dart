// ログイン状態を維持するProvider.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// プロバイダを使用して、FirebaseAuth インスタンスにアクセスします。
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  // 以下のプロバイダからFirebaseAuthを取得します。
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  // Stream<User?> を返すメソッドを呼び出す。
  return firebaseAuth.authStateChanges();
});
