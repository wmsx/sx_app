import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:sx_app/model/message.dart';

class ChatBubble extends StatefulWidget {
  final Message message;

  const ChatBubble({Key key, this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatBubbleState();
  }
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    Message message = widget.message;
    final align =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = message.isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: chatBubbleColor(message.isMe),
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(message.type == 0 ? 5 : 0),
                child: message.type == 0
                    ? Text(
                        message.content,
                        style: TextStyle(
                          color: message.isMe
                              ? Colors.white
                              : Theme.of(context).textTheme.title.color,
                        ),
                      )
                    : Image.network(
                        "${message.content}",
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
        Padding(
          padding: message.isMe
              ? EdgeInsets.only(
                  right: 10,
                  bottom: 10.0,
                )
              : EdgeInsets.only(
                  left: 10,
                  bottom: 10.0,
                ),
          child: Text(
            TimelineUtil.format(message.time,
                locale: 'zh', dayFormat: DayFormat.Simple),
            style: TextStyle(
              color: Theme.of(context).textTheme.title.color,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  Color chatBubbleColor(bool isMe) {
    if (isMe) {
      return Theme.of(context).accentColor;
    } else {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.grey[800];
      } else {
        return Colors.grey[200];
      }
    }
  }
}
