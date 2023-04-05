import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/ui/pages/edit_page.dart';
import 'package:profile_app/ui/pages/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue config = ref.watch(getProvider);
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditPage()));
                },
                icon: const Icon(Icons.edit))
          ],
          centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
          title: const Text(
            'プロフィールページ',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: config.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (config) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50, //丸のサイズを調整.
                    backgroundColor: Colors.grey, // 画像が非表示の時の色を設定.
                    backgroundImage:
                        NetworkImage(config["image"]), // imageドキュメントを取得.
                  ),
                  const SizedBox(width: 20),
                  Text(config['name']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
