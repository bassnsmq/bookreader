import 'package:flutter/material.dart';
  
/*
 * header
 */
class BookshelfHeader extends StatefulWidget {
  BookshelfHeader({Key key}) : super(key: key);

  _BookshelfHeaderState createState() => _BookshelfHeaderState();
}

class _BookshelfHeaderState extends State<BookshelfHeader> {

  //初始化
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async{

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(""),
    );
  }

  Widget buildFavoriteView() {

    return Wrap(
      children: <Widget>[

      ],
    );
  }
}
