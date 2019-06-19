import 'package:bookreader/component/screen.dart';
import 'package:bookreader/pages/importlocal/selection_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

//构建智能搜索 只搜索带有.txt的文件
class SmartSearch extends StatefulWidget {
  SmartSearch({@required this.sDCardDir});
  String sDCardDir;
  _SmartSearchState createState() => _SmartSearchState();
}

class _SmartSearchState extends State<SmartSearch> {
  String sDCardDir;
  List<FileSystemEntity> files = [];
  MethodChannel _channel = MethodChannel('openFileChannel');
  Directory parentDir;
  ScrollController controller = ScrollController();
  int count = 0; // 记录当前文件夹中以 . 开头的文件和文件夹
  List<double> position = [];

  //初始化
  @override
  void initState() {
    sDCardDir = this.widget.sDCardDir;
    parentDir = Directory(sDCardDir);
    initDirectory(sDCardDir);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder();
  }

  //初始化目录
  Future<void> initDirectory(String path) async {
    try {
      setState(() {
        var directory = Directory(path);
        count = 0;
        parentDir = directory;
        files.clear();
        files = directory.listSync();
      });
    } catch (e) {
      print(e);
      print("Directory does not exist！");
    }
  }
}