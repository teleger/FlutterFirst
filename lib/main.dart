import 'package:flutter/material.dart';

import 'package:flutter_app/customfirst.dart';
import 'package:flutter_app/contact.dart';

void main() => runApp(MyApp());

//Flutter中有一切皆widget的概念，widget分为StatelessWidget（无状态widget）和StatefulWidget（有状态widget）

class MyApp extends StatelessWidget {//注释 处说明MyApp继承了 StatelessWidget，这会使应用本身也成为一个widget
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { //build方法用来描述如何用其他较低级别的widget来显示自身
    return MaterialApp(  //MaterialApp包含了App实现Material Design所需要的一些widget
      title: 'Flutter Demo',  //title为  在任务管理窗口中所显示的应用名字
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),//home 为应用默认显示的界面widget
      routes: <String,WidgetBuilder>{
        '/Second': (_) =>  SecondPage(),
        '/First':(_) =>  FirstPage(),
        '/home':(_) =>  MyHomePage(),
      },
//      initialRoute: 'home',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentindex = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _downmentCouter(){
    setState(() {
      _counter--;//对按钮 上面的数字 减 1

      print('你 点击了 按钮, 并且');
      var ccs = new CustomClass();
      var out = ccs("放","手","去","做");//传进去四个参数 ,然后打印
      print('$out');

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final Widget mainshow = Center( //body为Scaffold的主要内容，通俗来讲就是屏幕的大部分  body包含了一个Center widget
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
          MaterialButton(color: Colors.green,child: new Text('点我'),onPressed: () {
            // ...
            _downmentCouter();
          },),
          MaterialButton(color: Colors.red,child: new Text('测试 跳转页面'),onPressed: () {
            //...能否在这里实现跳转？
            Navigator.push(context, MaterialPageRoute(
              builder:
                  (context)=> FirstPage(),
              maintainState: false,),);
          },),
        ],
      ),
    );

    final pages = [mainshow,
    ContactPage(),
    SecondPage()];

    return Scaffold(      // Scaffold是Material Design布局结构的基本实现，Scaffold内部包含了appBar和body
      appBar: AppBar(    //appBar为应用程序栏，它在Scaffold的顶部
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: pages[_currentindex],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('通讯录'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              title: Text('设置'),
            ),
          ],
          selectedItemColor: Colors.amber,
          currentIndex: _currentindex,
          onTap: (int index){
            if (index != _currentindex) {
              setState(() {
                _currentindex = index;
                print(_currentindex);
              });
            }
          },
        ),
      drawer: _drawer,//定义一个抽屉 ,下方 实现了一个
    );

  }

  @override
  void initState() {
    super.initState();
    _currentindex = 0;
  }

  get _drawer => Drawer(
    child: ListView(padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(child: Text('XYZ')),
          accountName: Text('teleger'),
          accountEmail: Text('teleger.gmail.com'),
      ),
      ListTile(leading: Icon(Icons.local_post_office),
        title: Text('邮件'),),
      ListTile(leading: Icon(Icons.settings),
        title: Text('设置'),),
        ListTile(leading: Icon(Icons.local_play),
          title: Text('播放'),),
        ListTile(leading: Icon(Icons.bluetooth),
          title: Text('蓝牙'),),
        ListTile(leading: Icon(Icons.library_music),
          title: Text('音乐'),),
    ],
    ),
  );

}
