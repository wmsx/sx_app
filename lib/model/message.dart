class Message {
  int type;
  String content;
  bool isMe;
  int time;

  Message.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    isMe = json['isMe'];
    time = json['time'];
  }

  String toString() {
    return 'type: $type, content: $content, isMe: $isMe, time: $time';
  }
}
