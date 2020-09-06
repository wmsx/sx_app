import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/model/message.dart';
import 'package:sx_app/service/mock_sx_repository.dart';
import 'package:sx_app/ui/widget/chat_bubble.dart';
import 'package:sx_app/view_model/socket_model.dart';

class ConversationPage extends StatefulWidget {
  final DiscussGroup discussGroup;

  const ConversationPage({Key key, this.discussGroup}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  List<Msg> messages = List();
  bool hasText = false;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DiscussGroup discussGroup = widget.discussGroup;

    MockSXRepository().fetchMessages().then((value) {
      messages = value;
      setState(() {});
    });

    return Consumer<SocketModel>(
      builder: (context, socketModel, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 3,
            titleSpacing: 0,
            title: InkWell(
              child: Text('${discussGroup.name}'),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatBubble(message: messages[index]);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomAppBar(
                    elevation: 10,
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 100,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {},
                          ),
                          Flexible(
                            child: TextField(
                              controller: controller,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(context).textTheme.title.color,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "请输入...",
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color:
                                      Theme.of(context).textTheme.title.color,
                                ),
                              ),
                              onSubmitted: (text) {
                                debugPrint('onSubmitted');
                              },
                              onChanged: (text) {
                                setState(() {
                                  hasText = text.length > 0 ? true : false;
                                });
                              },
                              maxLines: null,
                            ),
                          ),
                          IconButton(
                            icon: hasText
                                ? Icon(
                                    Icons.send,
                                    color: Theme.of(context).accentColor,
                                  )
                                : Icon(
                                    Icons.add,
                                    color: Theme.of(context).accentColor,
                                  ),
                            onPressed: () {
                              if (hasText) {
                                _handleSubmitted(controller.text, socketModel,
                                    discussGroup.id);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleSubmitted(String text, SocketModel socketModel, int groupId) {
    if (text.length > 0) {
      debugPrint('发送${text}');
      socketModel.sendMessage(text, groupId);
    }
  }
}
