import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bro/views/main.dart';
import 'package:bro/models/course.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Text(
    'Index 1: Hjem',
    ),
    Text(
      'Index 2: Artikler',
    ),
    Text(
      'Index 3: Kurs',
    ),
    Text(
      'Index 4: Instillinger',
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        onTap: _onItemTapped,
      ),
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
  final List<Widget> _widgetOptions = <Widget>[
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