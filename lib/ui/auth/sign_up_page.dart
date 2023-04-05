import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/repository/sign_up_service.dart';
import 'package:profile_app/ui/controller_provider.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingControllerのプロバイダーを呼び出す
    final emailController = ref.watch(emailProvider);
    final passwordController = ref.watch(passwordProvider);
    // 新規登録のロジックを持っているプロバイダーを呼び出す
    final signUp = ref.read(signUpProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
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
                  child: const Text('新規登録'),
                  onPressed: () async {
                    signUp.signUp(
                        context, emailController.text, passwordController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
