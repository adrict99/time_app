import 'package:flutter/material.dart';

import 'package:time_app/components/screens_comp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_app/welcome/welcome.dart';

import 'package:time_app/screens/timeline.dart';
import 'package:time_app/screens/calendar.dart';
import 'package:time_app/screens/lists.dart';
import 'package:time_app/screens/notes.dart';
import 'package:time_app/screens/productivity.dart';

class HomePage extends StatefulWidget {
  
  static const String id = 'homepage_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  static const SecondaryColor = Color(0xFF494949);
  static const PrimaryColor = Color(0xFFffbf00);
  static const ThirdColor = Color(0xFFdedede);
  
  List<Widget> _widgetOptions = <Widget>[
    Timeline(),
    Calendar(),
    Lists(),
    Notes(),
    Productivity(),
  ];
  
  final _auth = FirebaseAuth.instance;

  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          ExitButton(
                  () {
                _auth.signOut();
                Navigator.pushNamed(context, Welcome.id);
              }
          ),
        ],
        title: appBarTitle(),
        backgroundColor: PrimaryColor,
      ),
      backgroundColor: ThirdColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            backgroundColor: SecondaryColor,
            title: Text('Timeline'),
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            backgroundColor: SecondaryColor,
            title: Text('Calendario'),
            activeIcon: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.grey,
            ),
            backgroundColor: SecondaryColor,
            title: Text('Listas'),
            activeIcon: Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note,
              color: Colors.grey,
            ),
            backgroundColor: SecondaryColor,
            title: Text('Notas'),
            activeIcon: Icon(
              Icons.note,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timeline,
              color: Colors.grey,
            ),
            backgroundColor: SecondaryColor,
            title: Text('Productividad'),
            activeIcon: Icon(
              Icons.timeline,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
