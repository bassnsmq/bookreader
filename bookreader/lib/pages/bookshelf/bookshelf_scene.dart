import 'package:flutter/material.dart';
/*
 * 书架页面 
 */
class BookshelfScene extends StatefulWidget {
  BookshelfScene({Key key}) : super(key: key);

  _BookshelfSceneState createState() => _BookshelfSceneState();
}

class _BookshelfSceneState extends State<BookshelfScene> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() { 
    super.initState();
  }

  //初始化数据
  Future<void> fetchData() async{

  }

  //构建书架
  Widget buildFavoriteView() {


    return Wrap(
      children: <Widget>[
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("书旗小说"),
      ),
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: () {
              print("下拉刷新");
            },
            child: ListView(
              controller: scrollController,
              children: <Widget>[

              ],
            ),
          ),
        ],
      ),
    );
  }
}
