import 'package:encrypt/encrypt.dart';

String encryptData(String data) {
  final key = Key.fromBase64('BwwfHxgKDwcXAxkWDwEHDBseIREPIA4QDxYOEBIDIRY=');
  final iv = IV.fromBase64('FxIOBAcEEhISHgICCRYhEA==');
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypted = encrypter.encrypt(data, iv: iv);

  return encrypted.base64;
}

String decryptData(String data) {
  final key = Key.fromBase64('BwwfHxgKDwcXAxkWDwEHDBseIREPIA4QDxYOEBIDIRY=');
  final iv = IV.fromBase64('FxIOBAcEEhISHgICCRYhEA==');
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final decrypted = encrypter.decrypt64(data, iv: iv);
  return decrypted;
}
