// メールアドレスのテキストを保存するProvider.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

// パスワードのテキストを保存するProvider.
final passwordProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

// 名前のテキストを保存するProvider.
final nameProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});
