import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/repository/sign_in_service.dart';
import 'package:profile_app/ui/auth/sign_up_page.dart';
import 'package:profile_app/ui/controller_provider.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailProvider);
    final passwordController = ref.watch(passwordProvider);
    // ログインのロジックを持っているプロバイダーを呼び出す
    final signIn = ref.read(signInProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //戻るボタンを消す.
        title: const Text('ログインページ'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
              ),
              ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    signIn.signIn(
                        context, emailController.text, passwordController.text);
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
                  },
                  child: const Text('新規登録'))
            ],
          ),
        ),
      ),
    );
  }
}
