import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/chat/chat_page.dart';

import 'discover/discover_page.dart';
import 'friends/friends_page.dart';
import 'mine/mine_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<Widget> _pages = [ChatPage(), FriendsPage(), DiscoverPage(),MinePage()];

  int  _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:_pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,  //当前选中的是哪个 item，就是底部 4 个 item的切换选中的值，可以通过点击的方法切换改值
        //BottomNavigationBar 的点击事件
        onTap: (index) {
          print("index = $index");
          setState(() {
            _currentIndex = index;
          });
        },
        fixedColor: Colors.green,  //  填充的颜色，item 的填充颜色
        //type：BottomNavigationBarItem的模式，BottomNavigationBarType是枚举，有fixed和shifting两种模式设置。
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: '微信'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: '通讯录'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: '发现'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '我'),
        ],
      ),
    );
  }

}