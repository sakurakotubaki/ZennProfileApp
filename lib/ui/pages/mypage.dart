import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/repository/sign_out_service.dart';

class MyPage extends ConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログアウトするロジックを持っているプロバイダーを呼び出す
    final signOut = ref.watch(signOutProvider);
    return Scaffold(
        appBar: AppBar(
      actions: [
        IconButton(
            onPressed: () async {
              signOut.signOut(context);
            },
            icon: const Icon(Icons.logout))
      ],
      title: const Text('MyPage'),
    ));
  }
}
