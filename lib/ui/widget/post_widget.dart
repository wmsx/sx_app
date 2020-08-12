import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sx_app/model/post.dart';
import 'package:sx_app/model/post_item.dart';
import 'package:sx_app/ui/widget/video_widget.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget(
    this.post, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width / 16 * 10,
                    ),
                    child: Swiper(
                      outer: true,
                      loop: false,
                      pagination: new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.all(4.0),
                        builder: MyDotSwiperPaginationBuilder(
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              '${post.viewCount} 次观看',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              TimelineUtil.format(post.createAt,
                                  locale: 'zh_normal',
                                  dayFormat: DayFormat.Common),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          activeSize: 8.0,
                          size: 5.0,
                          activeColor: Color(0xff0b070c),
                          color: Color(0xffcecdcf),
                        ),
                      ),
                      itemCount: post.items.length,
                      itemBuilder: (context, index) {
                        PostItem item = post.items[index];
                        if (item.type == 1) {
                          return Image.network(
                            item.url,
                            fit: BoxFit.cover,
                          );
                        }
                        return VideoWidget(
                          url: item.url,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          post.menger.avatar,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyDotSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Widget left;

  final Widget right;

  final Key key;

  const MyDotSwiperPaginationBuilder(this.left, this.right,
      {this.activeColor,
      this.color,
      this.key,
      this.size: 10.0,
      this.activeSize: 10.0,
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }
    Color activeColor = this.activeColor;
    Color color = this.color;

    if (activeColor == null || color == null) {
      ThemeData themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(Container(
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
        child: ClipOval(
          child: Container(
            color: active ? activeColor : color,
            width: active ? activeSize : size,
            height: active ? activeSize : size,
          ),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,
          Column(
            key: key,
            mainAxisSize: MainAxisSize.min,
            children: list,
          ),
          right,
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,
          Row(
            key: key,
            mainAxisSize: MainAxisSize.min,
            children: list,
          ),
          right,
        ],
      );
    }
  }
}
