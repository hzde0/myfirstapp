import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ChildPage.dart';

class MineCell extends StatelessWidget {
  final String? title;//标题
  final String? subTitle;//子标题
  final String? imageName;//图标
  final String? subImageName;//子图标

  const MineCell({this.title, this.subTitle, this.imageName, this.subImageName});

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
        height: 54,
        child: Row(
          //主轴方向设置
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //left
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(imageName!),
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(title!),
                ],
              ),
            ),
            //right
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  subTitle != null ? Text(subTitle!) : const Text(''),
                  subImageName != null
                      ? Image(
                    image: AssetImage(subImageName!),
                    width: 12,
                  )
                      : Container(),
                  //箭头
                  const Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 14,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}