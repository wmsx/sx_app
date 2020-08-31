import 'package:sx_app/model/category.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/model/message.dart';
import 'package:sx_app/model/post.dart';

class MockSXRepository {
  static Future<List<Category>> fetchCategories() async {
    List<Category> categories = List();
    categories
      ..add(Category.fromJson({'id': 1, 'name': "编程与开发"}))
      ..add(Category.fromJson({'id': 2, 'name': "英语"}))
      ..add(Category.fromJson({'id': 3, 'name': "日语"}))
      ..add(Category.fromJson({'id': 4, 'name': "音乐"}))
      ..add(Category.fromJson({'id': 5, 'name': "绘画"}));

    return Future.value(categories);
  }

  static Future<List<Message>> fetchMessages() async {
    List<Message> messages = List();
    messages
      ..add(Message.fromJson(
          {'type': 0, 'content': "你好", 'isMe': false, 'time': 1598846749000}))
      ..add(Message.fromJson(
          {'type': 0, 'content': '请您是谁?', 'isMe': false, 'time': 1598846749000}))
      ..add(Message.fromJson({
        'type': 1,
        'content':
            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        'isMe': false,
        'time': 1598846749000
      }))
      ..add(Message.fromJson(
          {'type': 0, 'content': '你好，我是你爸爸', 'isMe': true, 'time': 1598846749000}));

    return Future.value(messages);
  }

  static Future<List<DiscussGroup>> fetchDiscussGroup() async {
    List<DiscussGroup> discussGroups = List();
    discussGroups
      ..add(DiscussGroup.fromJson({
        'id': 1,
        'postId': 1,
        'cover':
            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        'title': '如何实现延时队列',
        'lastestMsg': '怎么说?',
        'time': 1598846749000,
        'unread': 10,
      }))
      ..add(DiscussGroup.fromJson({
        'id': 1,
        'postId': 1,
        'cover':
            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        'title': 'RocketMQ如何存储消息',
        'lastestMsg': '怎么说?',
        'time': 1598846749000,
        'unread': 10,
      }))
      ..add(DiscussGroup.fromJson({
        'id': 1,
        'postId': 1,
        'cover':
            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        'title': 'flutter布局详解',
        'lastestMsg': '怎么说?',
        'time': 1598846749000,
        'unread': 10,
      }))
      ..add(DiscussGroup.fromJson({
        'id': 1,
        'postId': 1,
        'cover':
            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        'title': 'Golang GMP调度',
        'lastestMsg': '怎么说?',
        'time': 1598846749000,
        'unread': 10,
      }))
      ..add(DiscussGroup.fromJson({
        'id': 1,
        'postId': 1,
        'cover':
            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        'title': 'IM系统如何存储数据',
        'lastestMsg': '怎么说?',
        'time': 1598846749000,
        'unread': 10,
      }));

    return Future.value(discussGroups);
  }

  static Future<List<Post>> fetchPosts(int categoryId, int lastId) async {
    List<Post> posts = List();
    posts
      ..add(Post.fromJson({
        'id': 1,
        'type': 0,
        'title': '如何实现延时队列?',
        'CreateAt': 1597239548000,
        'viewCount': 1004,
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar':
              'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        },
        'items': [
          {
            'type': 1,
            'url':
                "https://cdn.pixabay.com/photo/2020/07/22/08/39/waterfall-5428467_1280.jpg",
          },
          {
            'type': 2,
            'url':
                "https://vt1.doubanio.com/202008121109/d00182f0b98a6d5fab9d6f01243735da/view/movie/M/302630808.mp4",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 2,
        'type': 0,
        'title': 'RocketMQ如何存储消息',
        'CreateAt': 1597239548000,
        'viewCount': 1003,
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar':
              'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        },
        'items': [
          {
            'type': 1,
            'url':
                "https://cdn.pixabay.com/photo/2015/05/28/05/03/portrait-787522_1280.jpg",
          },
          {
            'type': 2,
            'url':
                "https://vt1.doubanio.com/202008102324/5f0302468cd03d34f3792bcca96f0f5b/view/movie/M/302640231.mp4",
          }
        ]
      }))
      ..add(Post.fromJson({
        'id': 3,
        'type': 0,
        'title': 'Golang GMP调度',
        'CreateAt': 1597239548000,
        'viewCount': 1002,
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar':
              'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        },
        'items': [
          {
            'type': 1,
            'url':
                "https://cdn.pixabay.com/photo/2016/11/29/03/36/beautiful-1867093_1280.jpg",
          },
          {
            'type': 2,
            'url':
                "https://vt1.doubanio.com/202008102100/5c4d5358411eeebcf03cf72a97c13a1f/view/movie/M/302620737.mp4",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 4,
        'type': 0,
        'title': 'IM系统如何存储数据',
        'CreateAt': 1597239548000,
        'viewCount': 1001,
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar':
              'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        },
        'items': [
          {
            'type': 1,
            'url':
                "https://cdn.pixabay.com/photo/2016/03/23/04/01/beautiful-1274056_1280.jpg",
          },
          {
            'type': 2,
            'url':
                "https://vt1.doubanio.com/202008101550/c7dda71f79f92c5d6b41ebcda2ba106f/view/movie/M/302570596.mp4",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 5,
        'type': 0,
        'title': 'flutter布局详解',
        'CreateAt': 1597239548000,
        'viewCount': 1000,
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar':
              'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        },
        'items': [
          {
            'type': 1,
            'url':
                "https://cdn.pixabay.com/photo/2018/04/03/20/26/woman-3287956_1280.jpg",
          },
          {
            'type': 2,
            'url':
                "https://vt1.doubanio.com/202008071207/261f046e77ce899d4ca6dafc7134df62/view/movie/M/302640453.mp4",
          },
        ]
      }));
    return Future.value(posts);
  }
}
