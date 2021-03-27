import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bro/views/main.dart';
import 'package:bro/models/course.dart';

"Hjalti, mekk sidene plis"


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

  Widget _bottomNavigationBar(int _selectedIndex) => BottomNavigationBar(
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: 'Hjem', backgroundColor: Colors.teal,),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.book), label: 'Artikler', backgroundColor: Colors.teal,),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidCheckSquare), label: 'Kurs', backgroundColor: Colors.teal,),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cog), label: 'Instillinger', backgroundColor: Colors.teal,),],
    currentIndex: _selectedIndex,
    onTap: (int index) => setState(() => _selectedIndex = index),
    selectedItemColor: Colors.white;


  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
      ),

    );
  }
}
