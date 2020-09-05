import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sx_app/constants.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/model/message/message.dart';
import 'package:sx_app/model/message/protocol.dart';
import 'package:sx_app/utils/common_util.dart';
import 'package:sx_app/view_model/discuss_group_list_model.dart';

class SocketModel with ChangeNotifier {
  Socket socket;

  DiscussGroupListModel _discussGroupListModel;

  bool _connected = false;

  bool get connected => _connected;

  DiscussGroupListModel get discussGroupListModel => _discussGroupListModel;

  void _dataHandler(Uint8List bytes) {
    Message message = Protocol.receiveMessage(ByteData.sublistView(bytes));
    _handlerMessage(message);
  }

  void _handlerMessage(Message message) {
    switch (message.cmd) {
      case MSG_AUTH_STATUS:
        debugPrint('认证结果: ${message.body.status}');
        break;
      case MSG_SYNC_GROUP_BEGIN:
        debugPrint('开始同步消息 groupId: ${message.body.groupId}');
        debugPrint('开始同步消息 syncKey: ${message.body.syncKey}');
        break;
      case MSG_SYNC_GROUP_END:
        debugPrint('开始同步消息 groupId: ${message.body.groupId}');
        debugPrint('开始同步消息 syncKey: ${message.body.syncKey}');
        break;
      default:
        debugPrint('无效的消息');
    }
  }

  void _doneHandler() {
    debugPrint('socket closed...');
    _connected = false;
    socket.destroy();
  }

  void _errorHandler(error, StackTrace trace) {
    print(error);
  }

  void update(DiscussGroupListModel discussGroupListModel) {
    _discussGroupListModel = discussGroupListModel;
  }

  connect() async {
    if (!_connected) {
      socket = await Socket.connect('192.168.0.199', 23000);

      socket.listen(
        _dataHandler,
        onDone: _doneHandler,
        onError: _errorHandler,
      );
      _connected = true;
      notifyListeners();
    }
  }

  void auth() async {
    String deviceId = await CommonUtil.getDeviceId();
    int platformId = CommonUtil.getPlatformId();
    String token = _discussGroupListModel.mengerModel.menger.chatToken;
    AuthenticationToken authenticationToken = AuthenticationToken(
      token: token,
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

  syncMessage() {
    List<DiscussGroup> discussGroups = _discussGroupListModel.list;
    if (discussGroups.isNotEmpty) {
      for (DiscussGroup discussGroup in discussGroups) {
        GroupSyncKey syncKey = GroupSyncKey();
        syncKey.groupId = discussGroup.id;
        syncKey.syncKey = 0;
        Message message = Message(
          cmd: MSG_SYNC_GROUP,
          version: DEFAULT_VERSION,
          body: syncKey,
        );
        _sendMessage(message);
      }
    }
  }

  void _sendMessage(Message message) {
    ByteData bytes = Protocol.writeMessage(message);
    socket.add(
        Uint8List.view(bytes.buffer, bytes.offsetInBytes, bytes.lengthInBytes));
  }
}
