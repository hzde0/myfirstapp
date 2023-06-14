import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ChildPage.dart';
import '../common.dart';

class ChatCell extends StatelessWidget {
  final String? imageName;//图标
  final String? name; //姓名
  final String? text; //内容
  final String? title;
  const ChatCell({this.imageName, this.name, this.text,this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                ChildPage(title: '$title')));
      },
      child: Container(
        color: Colors.white,
        height: 70,
        child: Row(
            children:[
              Container(
                width: 10,
              ),
              //图标
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(imageName!),
                        fit:BoxFit.cover
                    )
                ),
              ),
              //name/ text
              Container(
                width: 10,
              ),
              Container(
                width: screenWidth(context)-80,
                padding: const EdgeInsets.only(left: 10,top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    //昵称
                    Container(
                      height: 30,
                      child:  Text(name!,style: TextStyle(fontSize: 28,color: Colors.black),),
                    ),
                    //微信号
                    Container(
                      height: 30,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(text!,style: TextStyle(fontSize: 17,color: Colors.grey),)
                        ],
                      ) ,),
                  ],
                ),

              )
            ]
        ),
      ),
    );
  }
}