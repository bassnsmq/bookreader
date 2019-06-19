
import 'package:bookreader/component/screen.dart';
import 'package:bookreader/model/novel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'bookshelf_header.dart';
//单体书

class BookshelfItemView extends StatelessWidget {
  final Novel novel;
  BookshelfItemView(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    return GestureDetector(
      onTap: () {
        //跳转到详细页面
        //AppNavigator.pushNovelDetail(context, novel);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              //书的封面
              child: NovelCoverImage(
                novel.imgUrl,
                width: width,
                height: width / 0.75,
              ),
              decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 5)]),
            ),
            SizedBox(height: 10),
            Text(novel.name, style: TextStyle(fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}