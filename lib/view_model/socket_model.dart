import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sx_app/constants.dart';
import 'package:sx_app/model/message/message.dart';
import 'package:sx_app/model/message/protocol.dart';
import 'package:sx_app/utils/common_util.dart';

class SocketModel with ChangeNotifier {
  Socket socket;

  init() async {
    socket = await Socket.connect('192.168.0.107', 23000);

    String deviceId = await CommonUtil.getDeviceId();
    int platformId = CommonUtil.getPlatformId();
    AuthenticationToken authenticationToken = AuthenticationToken(
      token: 'ViaBB4hkGXG1z5Q16qWB7sPr',
      platformId: platformId,
      deviceId: deviceId,
    );

    socket.listen((Uint8List bytes) {
      Message message = Protocol.receiveMessage(ByteData.sublistView(bytes));
      if (message.cmd == MSG_AUTH_STATUS) {
        debugPrint('${message.body.status}');
      }
    });

    Message message = Message(
      cmd: MSG_AUTH_TOKEN,
      version: DEFAULT_VERSION,
      body: authenticationToken,
    );
    _sendMessage(message);
  }

  void _sendMessage(Message message) {
    ByteData bytes = Protocol.writeMessage(message);
    socket.add(
        Uint8List.view(bytes.buffer, bytes.offsetInBytes, bytes.lengthInBytes));
  }
}
