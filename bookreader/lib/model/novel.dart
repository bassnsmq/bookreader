/**
 * 书本model
 */
 
 import 'package:flutter/material.dart';
 class Novel{
  //id
  String id;
  //书名
  String name;
  //图片名
  String imgUrl;
  //第一章
  String firstChapter;
  //作者
  String author;
  //金钱
  double price;
  //评分
  double score;
  //类型
  String type;
  //介绍
  String introduction;
  //章节数
  int chapterCount;
  //推荐阅读
  int recommendCount;
  //评论数
  int commentCount;
  //
  int firstArticleId;

  //
  List<String> roles;
  //状态
  String status;
  //字数
  double wordCount;
  //标签
  List<String> tags;
  //是否为限时免费
  bool isLimitedFree;

 }