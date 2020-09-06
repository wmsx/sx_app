import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:sx_app/model/message/message.dart';

class _ProtocolHeader {
  int len;
  int seq;
  int cmd;
  int version;
  int flag;

  _ProtocolHeader(this.len, this.seq, this.cmd, this.version, this.flag);
}

class Protocol {
  static Message receiveMessage(ByteData bytes) {
    ReadBuffer reader = ReadBuffer(bytes);
    _ProtocolHeader header = _readerHeader(reader);
    if (header.len < 0) {
      debugPrint('invaild len: ${header.len}');
      return null;
    }

    Uint8List body = reader.getUint8List(header.len);
    Message message = Message(
      cmd: header.cmd,
      seq: header.seq,
      version: header.version,
      flag: header.flag,
    );
    message.fromData(body);
    return message;
  }

  static ByteData writeMessage(Message message) {
    WriteBuffer buffer = WriteBuffer();
    Uint8List bodyBytes = message.toData();
    _ProtocolHeader header = _ProtocolHeader(bodyBytes.lengthInBytes,
        message.seq, message.cmd, message.version, message.flag);
    _writeHeader(header, buffer);
    buffer.putUint8List(bodyBytes);
    return buffer.done();
  }

  static void _writeHeader(_ProtocolHeader header, WriteBuffer buffer) {
    buffer.putInt32(header.len, endian: Endian.big);
    buffer.putInt32(header.seq, endian: Endian.big);
    buffer.putUint8(header.cmd);
    buffer.putUint8(header.version);
    buffer.putUint8(header.flag);
    buffer.putUint8(0);
  }

  static _ProtocolHeader _readerHeader(ReadBuffer reader) {
    int len = reader.getInt32(endian: Endian.big);
    int seq = reader.getInt32(endian: Endian.big);
    int cmd = reader.getUint8();
    int version = reader.getUint8();
    int flag = reader.getUint8();
    reader.getUint8();
    return _ProtocolHeader(len, seq, cmd, version, flag);
  }
}
