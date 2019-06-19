import 'package:bookreader/component/screen.dart';
import 'package:bookreader/model/novel.dart';
import 'package:flutter/material.dart';

import 'bookshelf_header.dart';
import 'bookshelf_item_view.dart';

/*
 * 书架页面 
 */
class BookshelfScene extends StatefulWidget {
  BookshelfScene({Key key}) : super(key: key);

  _BookshelfSceneState createState() => _BookshelfSceneState();
}

class _BookshelfSceneState extends State<BookshelfScene> {
  List<Novel> favoriteNovels = [];
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

  @override
  void initState() {
    for (var i = 0; i < 10; i++) {
      Novel novel = Novel();
      novel.imgUrl = "images/150.jpg";
      novel.introduction = "测试";
      novel.name = "霸王之气";
      novel.price = 0;
      favoriteNovels.add(novel);
    }
    //监听器
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
    super.initState();
  }

  //初始化数据
  Future<void> fetchData() async {}

  //产生动作 签到搜索
  Widget buildActions(Color iconColor) {
    return Row(children: <Widget>[
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('images/actionbar_checkin.png', color: iconColor),
      ),
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('images/actionbar_search.png', color: iconColor),
      ),
      SizedBox(width: 15)
    ]);
  }

// 构建导航栏
  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: buildActions(SQColor.white),
          ),
        ),

        //带有透明度的widget
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            color: SQColor.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 103),
                Expanded(
                  child: Text(
                    '书架',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildActions(SQColor.darkGray),
              ],
            ),
          ),
        )
      ],
    );
  }

  //构建书架
  Widget buildFavoriteView() {
    if (favoriteNovels.length <= 1) {
      return Container();
    }
    var novels = favoriteNovels.sublist(1);
    List<Widget> children = [];
    novels.forEach((novel) {
      children.add(BookshelfItemView(novel));
    });
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    //增加一个add的图
    children.add(GestureDetector(
      onTap: () {
        //eventBus.emit(EventToggleTabBarIndex, 1);
      },
      child: Container(
        color: SQColor.paper,
        width: width,
        height: width / 0.75,
        child: Image.asset('images/bookshelf_add.png'),
      ),
    ));

    //用的是wrap
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Wrap(
        spacing: 23,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: () {
              print("下拉刷新");
            },
            child: ListView(
              controller: scrollController,
              children: <Widget>[
                favoriteNovels.length > 0
                    ? BookshelfHeader(favoriteNovels[0])
                    : Container(),
                buildFavoriteView(),
              ],
            ),
          ),
          buildNavigationBar(),
        ],
      ),
    );
  }
}
