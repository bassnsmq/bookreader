import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.people),
          onPressed: () => {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.people),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: null,
          ),
        ],
        bottom: _AppBarBottom(),
      ),
      body: IndexBody(),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {
  BottomBar({Key key}) : super(key: key);

  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("xxx"),
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("xxxx"),
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("xxxxx"),
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            icon: Icon(Icons.satellite),
            title: Text("xxxxxx"),
            backgroundColor: Theme.of(context).primaryColor)
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

class IndexBody extends StatefulWidget {
  IndexBody({Key key}) : super(key: key);

  _IndexBodyState createState() => _IndexBodyState();
}

class _IndexBodyState extends State<IndexBody> {
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  const BookItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 120,
      color: Colors.red,
      child: Stack(),
    );
  }
}

class _AppBarBottom extends StatefulWidget with PreferredSizeWidget {
  _AppBarBottom({Key key}) : super(key: key);

  __AppBarBottomState createState() => __AppBarBottomState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(200);
}

class __AppBarBottomState extends State<_AppBarBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 160,
            child: Stack(
              children: <Widget>[
                Positioned(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset("images/150.jpg"),
                )
              ],
            ),
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.white,
          ),
          Container(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("我的群员是大佬"), Text("读至0% 继续阅读")],
            ),
            width: MediaQuery.of(context).size.width / 2 + 10,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
