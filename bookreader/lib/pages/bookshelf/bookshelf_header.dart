import 'package:bookreader/component/screen.dart';
import 'package:bookreader/model/novel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'bookshelf_cloud_widget.dart';

//书架头
class BookshelfHeader extends StatefulWidget with PreferredSizeWidget{
  final Novel novel;

  BookshelfHeader(this.novel);

  @override
  _BookshelfHeaderState createState() => _BookshelfHeaderState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(250);
}

class _BookshelfHeaderState extends State<BookshelfHeader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    var bgHeight = width / 0.9;
    var height = Screen.topSafeHeight + 250;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: height - bgHeight,
            child: Image.asset(
              'images/bookshelf_bg.png',
              fit: BoxFit.cover,
              width: width,
              height: bgHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: BookshelfCloudWidget(
              animation: animation,
              width: width,
            ),
          ),
          buildContent(context),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    Novel novel = this.widget.novel;

    var width = Screen.width;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 54 + Screen.topSafeHeight, 10, 0),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          //跳转到详细页面
          //AppNavigator.pushNovelDetail(context, novel);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              //
              child: NovelCoverImage(novel.imgUrl, width: 120, height: 160),
              decoration: BoxDecoration(boxShadow: Styles.borderShadow),
            ),
            //间隔
            SizedBox(width: 20),
            //自适应
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  Text(novel.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Text('读至0.2%     继续阅读 ',
                          style: TextStyle(fontSize: 14, color: SQColor.paper)),
                      Image.asset('images/bookshelf_continue_read.png'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//盒子样式
class Styles {
  static List<BoxShadow> get borderShadow {
    return [BoxShadow(color: Color(0x22000000), blurRadius: 8)];
  }
}

//颜色
class SQColor {
  static Color primary = Color(0xFF23B38E);
  static Color secondary = Color(0xFF51DEC6);
  static Color red = Color(0xFFFF2B45);
  static Color orange = Color(0xFFF67264);
  static Color white = Color(0xFFFFFFFF);
  static Color paper = Color(0xFFF5F5F5);
  static Color lightGray = Color(0xFFEEEEEE);
  static Color darkGray = Color(0xFF333333);
  static Color gray = Color(0xFF888888);
  static Color blue = Color(0xFF3688FF);
  static Color golden = Color(0xff8B7961);
}

//书本封面样式
class NovelCoverImage extends StatelessWidget {
  //路径
  final String imgUrl;
  final double width;
  final double height;
  NovelCoverImage(this.imgUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imgUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
      decoration: BoxDecoration(border: Border.all(color: SQColor.paper)),
    );
  }
}
