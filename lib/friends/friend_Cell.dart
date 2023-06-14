

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class _FriendCell extends StatelessWidget {
  final String? imageUrl;//图片 URL
  final String? name;//昵称
  final String? groupTitle;//组头标题
  final String? imageAssets;//本地图片地址


  const _FriendCell({this.imageUrl,this.name,this.groupTitle,this.imageAssets});
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        //组头
        Container(
          alignment:Alignment.centerLeft,//靠左边居中
          padding: const EdgeInsets.only(left: 10),//距离左10 个间距
          height: groupTitle!=null?30:0,
          color: GlobalThemeColor,
          child: groupTitle!=null?Text(
            groupTitle!,
            style: const TextStyle(color: Colors.grey),
          ) :null,
        ),
        //昵称和图片
        Container(
          color: Colors.white,
          child: Row(
              children:[
                Container(
                    margin: const EdgeInsets.all(10),
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        image: DecorationImage(
                          image:getImage(),
                        )
                    )
                ),//图片
                // ignore: avoid_unnecessary_containers
                Container(
                    width: screenWidth(context)-54,
                    child: Column(
                      children: [
                        Container(
                          alignment:Alignment.centerLeft,
                          height: 53.5,
                          child:Text(
                            name!,
                            style: const TextStyle(fontSize: 18,color: Colors.black),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          color: GlobalThemeColor,
                        ),//下划线
                      ],
                    )

                ),//昵称

              ]
          ),
        ),
      ],
    );
  }

  ImageProvider  getImage(){
    if(imageUrl == null){
      return AssetImage(imageAssets!);
    }
    return NetworkImage(imageUrl!);
  }

}