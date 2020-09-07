import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sx_app/constants.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/model/message.dart';
import 'package:sx_app/model/message/message.dart';
import 'package:sx_app/model/message/protocol.dart';
import 'package:sx_app/utils/common_util.dart';
import 'package:sx_app/view_model/discuss_group_list_model.dart';

class SocketModel with ChangeNotifier {
  Socket socket;

  Map<int, Msg> discussMsg = Map();

  DiscussGroupListModel _discussGroupListModel;

  bool _connected = false;

  int get self => _discussGroupListModel.mengerModel.menger.id;

  bool get connected => _connected;

  DiscussGroupListModel get discussGroupListModel => _discussGroupListModel;

  void sendMessage(String text, int groupId) {
    IMMessage imMessage = IMMessage(
      sender: self,
      receiver: groupId,
      content: text,
    );
    Message message = Message(
      cmd: MSG_GROUP_IM,
      version: DEFAULT_VERSION,
      body: imMessage,
    );

    _sendMessage(message);
  }

  void _dataHandler(Uint8List bytes) {
    List<Message> messages =
        Protocol.receiveMessages(ByteData.sublistView(bytes));
    _handlerMessage(messages);
  }

  void _handlerMessage(List<Message> messages) {
    for (Message message in messages) {
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
        case MSG_METADATA:
          debugPrint('Metadata syncKey: ${message.body.syncKey}');
          debugPrint('Metadata prevSyncKey: ${message.body.prevSyncKey}');
          break;
        case MSG_ACK:
          debugPrint('Ack: ${message.body.seq}');
          break;
        default:
          debugPrint('无效的消息');
      }
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
    debugPrint('try to connect....');
    if (!_connected) {
      // socket = await Socket.connect('192.168.0.199', 23000);
      socket = await Socket.connect('192.168.0.107', 23000);

      socket.listen(
        _dataHandler,
        onDone: _doneHandler,
        onError: _errorHandler,
      );
      _connected = true;
      debugPrint('connected....');
      _auth();
      notifyListeners();
    }
  }

  void _auth() async {
    String deviceId = await CommonUtil.getDeviceId();
    int platformId = CommonUtil.getPlatformId();
    String token = _discussGroupListModel.mengerModel.menger.chatToken;
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
