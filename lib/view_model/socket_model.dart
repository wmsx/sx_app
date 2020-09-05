import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sx_app/constants.dart';
import 'package:sx_app/model/message/message.dart';
import 'package:sx_app/model/message/protocol.dart';
import 'package:sx_app/utils/common_util.dart';

class SocketModel with ChangeNotifier {
  Socket socket;

  bool _connected = false;

  bool get connected => _connected;

  void _dataHandler(Uint8List bytes) {
    Message message = Protocol.receiveMessage(ByteData.sublistView(bytes));
    if (message.cmd == MSG_AUTH_STATUS) {
      debugPrint('${message.body.status}');
    }
    _connected = true;
  }

  void _doneHandler() {
    debugPrint('socket closed...');
    socket.destroy();
  }

  void _errorHandler(error, StackTrace trace) {
    print(error);
  }

  connect() async {
    if (!_connected) {
      socket = await Socket.connect('192.168.0.199', 23000);

      socket.listen(
        _dataHandler,
        onDone: _doneHandler,
        onError: _errorHandler,
      );

      String deviceId = await CommonUtil.getDeviceId();
      int platformId = CommonUtil.getPlatformId();
      AuthenticationToken authenticationToken = AuthenticationToken(
        token: 'ViaBB4hkGXG1z5Q16qWB7sPr',
        platformId: platformId,
        deviceId: deviceId,
      );

      Message message = Message(
        cmd: MSG_AUTH_TOKEN,
        version: DEFAULT_VERSION,
        body: authenticationToken,
      );
      _sendMessage(message);
    }
  }

  syncMessage() {}

  void _sendMessage(Message message) {
    ByteData bytes = Protocol.writeMessage(message);
    socket.add(
        Uint8List.view(bytes.buffer, bytes.offsetInBytes, bytes.lengthInBytes));
  }
}
