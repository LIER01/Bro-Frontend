import 'package:bro/views/flutter-demo/demoscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bro/views/main.dart';
import 'package:bro/models/course.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions =[
    //har prøvd å sette inn Home() osv, men appen laster ikke når jeg gjør det.
    Text(
      'Index 0: Hjem',
    ),
    Text(
      'Index 1: Artikler',
    ),
    MyHomePage(),
    Text(
      'Index 3: Instillinger',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //Attempting to make the change of widget to an ontapped event since commented out body solution renders navbar in conflict with non-_widgetoption page
    _widgetOptions[_selectedIndex];
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //body:  _widgetOptions[_selectedIndex],
      //bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Hjem',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Artikler',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCheckSquare),
            label: 'Kurs',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cog),
            label: 'Instillinger',
            backgroundColor: Colors.teal,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.tealAccent,
        onTap: _onItemTapped,
      //),
    );
  }
}

/*
class BottomNavigationBar extends StatefulWidget {
  @override
  _BottomNavigationBarState createState() =>
      _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  final List<Widget> pages = <Widget>[
    Home(),
    Text('Article page'),
    Text('Course'),
    Text('Options'),
  ];


  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: 'Hjem', backgroundColor: Colors.teal,),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.book), label: 'Artikler', backgroundColor: Colors.teal,),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidCheckSquare), label: 'Kurs', backgroundColor: Colors.teal,),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cog), label: 'Instillinger', backgroundColor: Colors.teal,),],
      currentIndex: _selectedIndex,
      onTap: (int index) => setState(() => _selectedIndex = index),
      selectedItemColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: _widgetOptions[_selectedIndex],
      ),

    );
  }
}
*/