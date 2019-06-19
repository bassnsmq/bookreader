import 'package:bookreader/pages/importlocal/system_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class FileSystem extends StatefulWidget {
  FileSystem({Key key}) : super(key: key);

  _FileSystemState createState() => _FileSystemState();
}

class _FileSystemState extends State<FileSystem>
    with SingleTickerProviderStateMixin {
  String sDCardDir;
  TabController tabController;

  //获得根路径
  Future<void> getSDCardDir() async {
    sDCardDir = (await getExternalStorageDirectory()).path;
  }

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    getSDCardDir();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.backup),
          onPressed: () {},
        ),
        title: Center(
          child: Text("本地导入"),
        ),
        actions: <Widget>[Text("按时间排序")],
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(
              child: Text("智能扫描"),
            ),
            Tab(
              child: Text("系统目录"),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Text("1"),
          SystemCatalog(
            sDCardDir: sDCardDir,
          )
        ],
      ),
    );
  }
}
