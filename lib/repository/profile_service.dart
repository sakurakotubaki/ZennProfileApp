// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final profileProvider = Provider<ProfileService>((ref) => ProfileService());

class ProfileService {
  // Firestoreのクラスをインスタンス化する
  final db = FirebaseFirestore.instance;
  // FirebaseAuthのクラスをインスタンス化する
  final auth = FirebaseAuth.instance;
  // FirebaseStorageのクラスをインスタンス化する
  final storageRef = FirebaseStorage.instance;

  Future<void> fileUpload(BuildContext context) async {
    // imagePickerで画像を選択する
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile == null) {
      return;
    }
    File file = File(pickerFile.path);
    try {
      // imagesフォルダを指定してuidと画像を保存.
      final uid = auth.currentUser?.uid ?? '';
      final uploadName = "image.png";
      final snapshot = await storageRef.ref().child("images/$uid/$uploadName");
      // 画像をStorageにuploadする処理.
      final task = await snapshot.putFile(file);
      final imageUrl = await snapshot.storage
          .ref()
          .child("images/$uid/$uploadName")
          .getDownloadURL();
      // uploadに成功するとlogが表示される.
      print(imageUrl);
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('画像のアップロードに失敗しました!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        },
      );
    }
  }

  // FireStoreに画像のURLを保存するメソッド.
  Future<void> sendImage(String name, BuildContext context) async {
    try {
      // imagesフォルダを指定して画像のURLを取得.
      final uid = auth.currentUser?.uid ?? '';
      final uploadName = "image.png";
      final imageRef = storageRef.ref().child("images/$uid/$uploadName");
      // URLをFireStoreに保存する.
      String imageUrl = await imageRef.getDownloadURL();
      // Map方を使う.
      Map<String, dynamic> data = {
        "name": name,
        "image": imageUrl,
      };
      // FireStoreにデータを追加する.
      final user = auth.currentUser;
      final _reference = db.collection('profile').doc(uid);
      // 先ほどのMap型のdata変数を使用する.
      _reference.set(data);
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('画像のアップロードに失敗しました!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        },
      );
    }
  }

  // プロフィール情報を更新するメソッド.
  Future<void> editImage(String name, BuildContext context) async {
    try {
      // imagesフォルダを指定して画像のURLを取得.
      final uid = auth.currentUser?.uid ?? '';
      final uploadName = "image.png";
      final imageRef = storageRef.ref().child("images/$uid/$uploadName");
      // URLをFireStoreに保存する.
      String imageUrl = await imageRef.getDownloadURL();
      // Map方を使う.
      Map<String, dynamic> data = {
        "name": name,
        "image": imageUrl,
      };
      // FireStoreにデータを追加する.
      final user = auth.currentUser;
      final _reference = db.collection('profile').doc(uid);
      // 先ほどのMap型のdata変数を使用する.
      _reference.update(data);
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('画像のアップロードに失敗しました!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        },
      );
    }
  }

  // プロフィール情報を削除するメソッド.
  Future<void> deleteImage(BuildContext context) async {
    // imagesフォルダを指定して画像のURLを取得.
      final uid = auth.currentUser?.uid ?? '';
      final uploadName = "image.png";
      final imageRef = storageRef.ref().child("images/$uid/$uploadName");
      // Storageの画像を削除する.
      final imageUrl = await imageRef.delete();

      // FireStoreのデータを削除する.
      final user = auth.currentUser;
      db.collection('profile').doc(uid).delete();
  }
}
