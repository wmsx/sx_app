import 'dart:convert';
import 'dart:typed_data';

class ConvertUtils {
  static Uint8List stringToBytesUtf8(String str) {
    return utf8.encode(str);
  }

  static String bytesToUtf8String(Uint8List bytes) {
    return utf8.decode(bytes);
  }
}
