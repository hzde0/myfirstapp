import 'package:flutter/material.dart';
import 'package:myfirstapp/chat/ChatCell.dart';

import '../common.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: const Text(
            '微信',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
                color: const Color.fromRGBO(1, 1, 1, 0.5),
                offset: const Offset(0, 60),
                child: Image.asset(
                  'images/圆加.png',
                  width: 25,
                ),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<String>>[
                    PopupMenuItem(
                        child: _popupMenuItem("images/发起群聊.png", "发起群聊")),
                    PopupMenuItem(
                        child: _popupMenuItem("images/添加朋友.png", "添加好友")),
                    PopupMenuItem(
                        child: _popupMenuItem("images/扫一扫1.png", "扫一扫")),
                    PopupMenuItem(
                        child: _popupMenuItem("images/收付款.png", "收付款")),
                  ];
                }),
          )
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body:Container(
        color: GlobalThemeColor,
        child: MediaQuery.removePadding(
          removeTop: true,//去掉导航栏的间隙
          context: context,
          child: ListView(
            children: [
              //头部
              //列表 cell
              Column(
                  children: [
                    const SizedBox(height: 10,),
                    const ChatCell(
                      imageName: 'images/3.png',
                      name: '张三',
                      text: '一二三四五，上山打老虎',
                    ),

                    Row(
                      children: <Widget>[
                        //左右
                        Container(width: 50, height: 0.5, color: Colors.white),
                        //Container(height: 0.5, color: Colors.grey)
                      ],
                    ),


                    const ChatCell(
                      imageName: 'images/2.png',
                      name: '李四',
                      text: '老虎没打到，吾问无为谓',
                    ),
                    //cell 底部分割线

                    Row(
                      children: <Widget>[
                        //左右
                        Container(width: 50, height: 0.5, color: Colors.white),
                        //Container(height: 0.5, color: Colors.grey)
                      ],
                    ),

                    const ChatCell(
                      imageName: 'images/1.png',
                      name: '王五',
                      text: '即便偶不变，符号看向先',
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ),

                    const ChatCell(
                      imageName: 'images/4.png',
                      name: '王二狗',
                      text: '多发高发三个人嘎斯豆腐干v二人三个',
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 50, height: 0.5, color: Colors.white),
                        Container(height: 0.5, color: Colors.grey)
                      ],
                    ),


                  ])
            ],
          ),
        ),
      ),
    );
  }
  Widget _popupMenuItem(String imgAss, String title) {
    return Row(
      children: [
        Image(
          image: AssetImage(imgAss),
          width: 25,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    );
  }
}
