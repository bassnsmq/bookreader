import 'dart:io';
import 'package:path/path.dart';

selectIcon(bool type, FileSystemEntity file) {
  try {
    String iconImg;
    if (type) {
      String str = extension(file.path);
      switch (str) {
        case '.ppt':
        case '.pptx':
          iconImg = 'images/ppt.png';
          break;
        case '.doc':
        case '.docx':
          iconImg = 'images/word.png';
          break;
        case '.xls':
        case '.xlsx':
          iconImg = 'images/excel.png';
          break;
        case '.jpg':
        case '.jpeg':
        case '.png':
          iconImg = 'images/image.png';
          break;
        case '.txt':
          iconImg = 'images/txt.png';
          break;
        case '.mp3':
          iconImg = 'images/mp3.png';
          break;
        case '.mp4':
          iconImg = 'images/video.png';
          break;
        case '.rar':
        case '.zip':
          iconImg = 'images/zip.png';
          break;
        case '.psd':
          iconImg = 'images/psd.png';
          break;
        default:
          iconImg = 'images/file.png';
          break;
      }
    } else {
      iconImg = 'images/folder.png';
    }
    return iconImg;
  } catch (e) {
    print(e);
    return 'images/unknown.png';
  }
}