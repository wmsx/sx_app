import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:sx_app/constants.dart';
import 'package:sx_app/utils/convert_util.dart';

Map<int, IMessage Function()> messageCreators = {
  MSG_AUTH_TOKEN: () => AuthenticationToken(),
  MSG_AUTH_STATUS: () => AuthenticationStatus(),
};

Map<int, IMessage Function()> vmessageCreators = {
  MSG_AUTH_TOKEN: () => AuthenticationToken(),
};

abstract class IMessage {
  Uint8List toData();
  bool fromData(Uint8List bytes);
}

abstract class IVersionMessage {
  Uint8List toData(int version);
  bool fromData(int version, Uint8List bytes);
}

class Message implements IMessage {
  int cmd;
  int seq;
  int version;
  int flag;
  dynamic body;
  Uint8List byteBody;

  Message(
      {this.cmd,
      this.seq = 0,
      this.version = DEFAULT_VERSION,
      this.flag = 0,
      this.body});

  @override
  bool fromData(Uint8List bytes) {
    IMessage Function() func = messageCreators[cmd];
    IMessage msg = func();
    msg.fromData(bytes);
    body = msg;
    return bytes.lengthInBytes > 0;
  }

  @override
  Uint8List toData() {
    if (byteBody != null) {
      return byteBody;
    } else if (body != null) {
      if (body is IMessage) {
        return body.toData();
      }
      if (body is IVersionMessage) {
        return body.toData(version);
      }
      return null;
    } else {
      return null;
    }
  }
}

class AuthenticationToken implements IMessage {
  String token;
  int platformId;
  String deviceId;

  AuthenticationToken({this.token, this.platformId, this.deviceId});

  Uint8List toData() {
    WriteBuffer writeBuffer = WriteBuffer();
    writeBuffer.putUint8(platformId);
    writeBuffer.putUint8(token.length);
    writeBuffer.putUint8List(ConvertUtils.stringToBytesUtf8(token));
    writeBuffer.putUint8(deviceId.length);
    writeBuffer.putUint8List(ConvertUtils.stringToBytesUtf8(deviceId));
    ByteData bytes = writeBuffer.done();

    return Uint8List.view(
        bytes.buffer, bytes.offsetInBytes, bytes.lengthInBytes);
  }

  @override
  bool fromData(Uint8List bytes) {
    ReadBuffer readBuffer = ReadBuffer(ByteData.sublistView(bytes));
    platformId = readBuffer.getUint8();
    int tokenLength = readBuffer.getUint8();
    Uint8List tokenBytes = readBuffer.getUint8List(tokenLength);
    token = ConvertUtils.bytesToUtf8String(tokenBytes);
    int deviceIdLength = readBuffer.getUint8();
    Uint8List deviceIdBytes = readBuffer.getUint8List(deviceIdLength);
    deviceId = ConvertUtils.bytesToUtf8String(deviceIdBytes);
    return true;
  }
}

class AuthenticationStatus implements IMessage {
  int status;

  @override
  bool fromData(Uint8List bytes) {
    if (bytes.lengthInBytes < 4) {
      return false;
    }
    ReadBuffer readBuffer = ReadBuffer(ByteData.sublistView(bytes));
    status = readBuffer.getInt32(endian: Endian.big);
    return true;
  }

  @override
  Uint8List toData() {
    WriteBuffer writeBuffer = WriteBuffer();
    writeBuffer.putInt32(status);
    ByteData bytes = writeBuffer.done();

    return Uint8List.view(
        bytes.buffer, bytes.offsetInBytes, bytes.lengthInBytes);
  }
}
