import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_app/repository/profile_service.dart';
import 'package:profile_app/ui/controller_provider.dart';

class UploadPage extends ConsumerWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameProvider);
    // 画像のアップロードの処理を呼び出すプロバイダー
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィールを作成'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                profile.fileUpload(context);
              },
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400],
                    ),
                  ),
                  const Positioned(
                    right: 10,
                    bottom: 10,
                    child: CircleAvatar(
                        maxRadius: 30.0,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'ユーザー名を入力'),
            ),
            ElevatedButton(
                onPressed: () {
                  profile.sendImage(nameController.text, context);
                },
                child: const Text('ユーザーを登録')),
          ],
        ),
      ),
    );
  }
}
