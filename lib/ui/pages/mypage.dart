import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/repository/profile_service.dart';
import 'package:profile_app/repository/sign_out_service.dart';
import 'package:profile_app/ui/pages/profile_page.dart';
import 'package:profile_app/ui/pages/upload_page.dart';

class MyPage extends ConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログアウトするロジックを持っているプロバイダーを呼び出す
    final signOut = ref.watch(signOutProvider);
    // プロフィールを削除するロジックを呼び出す
    final profile = ref.watch(profileProvider);

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadPage()));
                },
                child: const Text('プロフィールを作成')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: const Text('プロフィールページ')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  profile.deleteImage(context);
                },
                child: const Text('プロフィール情報を削除する'))
          ],
        ),
      ),
    );
  }
}
