import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bookreader/util/constants.dart';

class ReadPage extends StatefulWidget{
  @override
  _ReadPageState createState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return _ReadPageState();
  }
}
class _ReadPageState extends State<ReadPage>{
  final _scrollController = ScrollController();

  double _letterSpacing = 2.0;
  double _lineHeight = 2.0;
  double _titleFontSize = 2.0;
  double _contentFontSize = 18.0;
  bool _isShowMenu = false;
  int _contentHeight = 0;
  bool _isDayMode = true;
  int _curPosition = 0;
  double _progress = 0.0;
  bool _isAdd = false;
  String _content = "";
  bool _isMark = false;

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]);
    super.dispose();
  }
  Widget _contentView() {
    return Container(
      child: Text(
        _content,
        style: TextStyle(
          color: _isDayMode
              ? AppColors.DayModeTextColor
              : AppColors.NightModeTextColor,
          height: _lineHeight,
          fontSize: _contentFontSize,
          letterSpacing: _letterSpacing,
        ),
      ),
    );
  }
  Widget _titleView() {
    return Text(
      "测试",
      style: TextStyle(
        color: _isDayMode
            ? AppColors.DayModeTextColor
            : AppColors.NightModeTextColor,
        fontSize: _titleFontSize,
        letterSpacing: 2,
      ),
    );
  }

  Widget iconTitle(
      BuildContext context, IconData iconData, String title, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Scaffold.of(context).openDrawer();
//            Navigator.push(context,
//                MaterialPageRoute(builder: (BuildContext context) {
//              return CatalogPage(
//                widget.bookId,
//                callBack: (Chapter chapter) => onChange(chapter),
//              );
//            }));
            break;
          case 1:
            setState(() {
              _isDayMode = !_isDayMode;
            });
            break;
          case 2:
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 10),
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: _isDayMode
                  ? AppColors.DayModeIconTitleButtonColor
                  : AppColors.NightModeIconTitleButtonColor,
            ),
            Text(
              title,
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _bottomMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: _isDayMode
          ? AppColors.DayModeMenuBgColor
          : AppColors.NightModeMenuBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  //_loadPre();
                },
                child: Text(
                  "上一章",
                  style: TextStyle(
                    color: _isDayMode
                        ? AppColors.DayModeIconTitleButtonColor
                        : AppColors.NightModeIconTitleButtonColor,
                  ),
                ),
              ),
              Container(
                height: 2,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    //未拖动的颜色
                    inactiveTrackColor: _isDayMode
                        ? AppColors.DayModeInactiveTrackColor
                        : AppColors.NightModeInactiveTrackColor,
                    //已拖动的颜色
                    activeTrackColor: _isDayMode
                        ? AppColors.DayModeActiveTrackColor
                        : AppColors.NightModeActiveTrackColor,
                    //滑块颜色
                    thumbColor: _isDayMode
                        ? AppColors.DayModeActiveTrackColor
                        : AppColors.NightModeActiveTrackColor,
                  ),
                  child: Slider(
                    value: _progress,
                    onChanged: (value) {
                      setState(() {
//                        print(value);
//                        _progress = value;
//                        _curPosion = (value * _chapters.length).floor();
//                        _getChapterData();
                      });
                    },
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                 // _loadNext();
                },
                child: Text(
                  "下一章",
                  style: TextStyle(
                    color: _isDayMode
                        ? AppColors.DayModeIconTitleButtonColor
                        : AppColors.NightModeIconTitleButtonColor,
                  ),
                ),
              )
            ],
          ),
          Builder(
            builder: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                iconTitle(context, Icons.menu, "目录", 0),
                iconTitle(
                    context, Icons.tonality, _isDayMode ? "夜间" : "日间", 1),
                iconTitle(context, Icons.text_format, "设置", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget reader() {
    return Container(
      color: _isDayMode ? AppColors.DayModeBgColor : AppColors.NightModeBgColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: kToolbarHeight,
              ),
              child: _content == "卷"
                  ? Center(
                child: _titleView(),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _titleView(),
                  _contentView(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //_loadPre();
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //_loadNext();
                  },
                ),
              )
            ],
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    //_updateBookMark();
                    _isShowMenu = ! _isShowMenu;
                    _isShowMenu
                        ? SystemChrome.setEnabledSystemUIOverlays(
                        [SystemUiOverlay.top, SystemUiOverlay.bottom])
                        : SystemChrome.setEnabledSystemUIOverlays([]);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          reader(),
          _isShowMenu
              ? Positioned(
            child: _bottomMenu(),
            bottom: 0,
          )
              : Container(),

        ],
      ),
    );
  }
}
