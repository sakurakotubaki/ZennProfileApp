import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/firebase_options.dart';
import 'package:profile_app/repository/auth_provider.dart';
import 'package:profile_app/ui/auth/sign_in_page.dart';
import 'package:profile_app/ui/pages/mypage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // テーマを使ってAppBar全体にスタイルを適用する.
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.grey,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// StreamProviderを使用してログイン判定するクラス.
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StreamProvider を監視し、AsyncValue<User?> を取得する。
    final authStateAsync = ref.watch(authStateChangesProvider);
    // パターンマッチングを使用して、状態をUIにマッピングする
    return authStateAsync.when(
      data: (user) => user != null ? const MyPage() : const SignInPage(),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
