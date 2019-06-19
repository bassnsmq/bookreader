import 'package:bookreader/component/screen.dart';
import 'package:bookreader/pages/importlocal/selection_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

//系统全部目录
class SystemCatalog extends StatefulWidget {
  SystemCatalog({@required this.sDCardDir});
  String sDCardDir;
  _SystemCatalogState createState() => _SystemCatalogState();
}

class _SystemCatalogState extends State<SystemCatalog> {
  List<FileSystemEntity> files = [];
  MethodChannel _channel = MethodChannel('openFileChannel');
  Directory parentDir;
  ScrollController controller = ScrollController();
  int count = 0; // 记录当前文件夹中以 . 开头的文件和文件夹
  String sDCardDir;
  List<double> position = [];

  @override
  void initState() {
    super.initState();
    sDCardDir = widget.sDCardDir;
    print(sDCardDir);
    parentDir = Directory(sDCardDir);
    initDirectory(sDCardDir);
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            width: Screen.width,
            height: 50,
            child: Text(parentDir.path),
          ),
        ),
        Positioned(
          top: 50,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: controller,
              itemCount: files.length != 0 ? files.length : 1,
              itemBuilder: (BuildContext context, int index) {
                if (files.length != 0)
                  return buildListViewItem(files[index]);
                else
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2 -
                            MediaQuery.of(context).padding.top -
                            56.0),
                    child: Center(
                      child: Text('The folder is empty'),
                    ),
                  );
              }),
        )
      ],
    );
  }

  // 计算文件夹内 文件、文件夹的数量，以 . 开头的除外
  removePointBegin(Directory path) {
    var dir = Directory(path.path).listSync();
    int num = dir.length;

    for (int i = 0; i < dir.length; i++) {
      if (dir[i]
              .path
              .substring(dir[i].parent.path.length + 1)
              .substring(0, 1) ==
          '.') num--;
    }
    return num;
  }

  //构建listviewitem
  buildListViewItem(FileSystemEntity file) {
    var isFile = FileSystemEntity.isFileSync(file.path);

    // 去除以 . 开头的文件和文件夹
    if (file.path.substring(file.parent.path.length + 1).substring(0, 1) ==
        '.') {
      count++;
      if (count != files.length) {
        return Container();
      } else {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 2 -
                  MediaQuery.of(context).padding.top -
                  56.0),
          child: Center(
            child: Text('The folder is empty'),
          ),
        );
      }
    }

    int length = 0;
    if (!isFile) length = removePointBegin(file);

    return InkWell(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(selectIcon(isFile, file)),
            title: Row(
              children: <Widget>[
                Expanded(
                    child:
                        Text(file.path.substring(file.parent.path.length + 1))),
                isFile
                    ? Container()
                    : Text(
                        '$length项',
                        style: TextStyle(color: Colors.grey),
                      )
              ],
            ),
            subtitle: isFile
                ? Text(
                    '${getFileLastModifiedTime(file)}  ${getFileSize(file)}',
                    style: TextStyle(fontSize: 12.0),
                  )
                : null,
            trailing: isFile ? null : Icon(Icons.chevron_right),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Divider(
              height: 1.0,
            ),
          )
        ],
      ),
      onTap: () {
        if (!isFile) {
          position.insert(position.length, controller.offset);
          initDirectory(file.path);
          jumpToPosition(true);
        } else
          openFile(file.path);
      },
    );
  }

  //跳转到指定的位置
  void jumpToPosition(bool isEnter) {
    if (isEnter)
      controller.jumpTo(0.0);
    else {
      controller.jumpTo(position[position.length - 1]);
      position.removeLast();
    }
  }

  getFileSize(FileSystemEntity file) {
    int fileSize = File(file.resolveSymbolicLinksSync()).lengthSync();
    if (fileSize < 1024) {
      // b
      return '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      // kb
      return '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      // mb
      return '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    }
  }

  getFileLastModifiedTime(FileSystemEntity file) {
    DateTime dateTime =
        File(file.resolveSymbolicLinksSync()).lastModifiedSync();

    String time =
        '${dateTime.year}-${dateTime.month < 10 ? 0 : ''}${dateTime.month}-${dateTime.day < 10 ? 0 : ''}${dateTime.day} ${dateTime.hour < 10 ? 0 : ''}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ''}${dateTime.minute}';
    return time;
  }

  openFile(String path) {
    final Map<String, dynamic> args = <String, dynamic>{'path': path};
    _channel.invokeMethod('openFile', args);
  }
}
