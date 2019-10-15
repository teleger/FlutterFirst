import 'package:flutter/material.dart';

class CustomClass{//在类中实现call 函数,可以直接使用类 进行调用
  call(String s1,String s2,String s3,String s4) => '$s1 $s2 $s3 $s4';
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第一页"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("跳转到第二页"),
          onPressed: () {
            if(Navigator.canPop(context)){// canPop只有在栈中只有一个元素的时候返回 false, 其它都是 true.
              print('FirstPage -----------can pop');
            }else{
              print('FirstPage -----------can not pop');
            }
            _navigateToSecondPage(context);
          },
        ),
      ),
    );
  }

  _navigateToSecondPage(BuildContext context) async {
    dynamic customArgumnets = await Navigator.pushNamed(context, '/Second',
        arguments: CustomArgumnets('Android进阶之光2')//将 Android进阶之光2 传入下一个界面
        );
    if(null != customArgumnets){//不判断是否为 空,将有错误
      if(null != customArgumnets.content){
        print(customArgumnets.content);
      }
    }else{
      print('customAtguments is null');
    }
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomArgumnets customArgumnets = ModalRoute.of(context).settings.arguments;
    var data = '';
    if(customArgumnets != null){
      data = customArgumnets.content;
    }else{
      data = '  ';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("第二页"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('第一页的数据为：'),
            Text(data),
            RaisedButton(
              onPressed: () {
                while(Navigator.canPop(context))
                {
                  Navigator.pop(context,CustomArgumnets('Android进阶解密123456'));//方法用于关闭当前页面，返回上一个页面，并将当前的Route对象从Navigator管理的Route 堆中移除
                }
              },
              child: Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }


}

class CustomArgumnets {
  String content;
  CustomArgumnets(this.content);
}