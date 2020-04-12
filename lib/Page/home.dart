import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static var _widgetOptions = <Widget>[
    // Text(
    //   'Index 0: 홈',
    //   style: optionStyle,
    // ),
    
    Text(
      'Index 1: 업적',
      style: optionStyle,
    ),
    Text(
      'Index 0: 소셜',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: RaisedButton(
        child: Text('wtf'),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          
        }
      ),
    ),
      // Center(
      //   child: _widgetOptions[_selectedIndex],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
              title: Text('홈'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('업적'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('소셜'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
