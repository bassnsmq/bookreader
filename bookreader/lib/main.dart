import 'package:bookreader/pages/bookshelf/bookshelf_scene.dart';
import 'package:bookreader/pages/index/IndexPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '书旗小说',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookshelfScene(),
    );
  }
}
