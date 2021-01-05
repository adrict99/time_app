import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calendar extends StatefulWidget {
  static const String id = 'calendar_screen';

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
      setState(() {
        _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events") ?? "{}" )));
      });
  }

  Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map) {
    Map<String,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              //locale: es_ES,
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                todayColor: Colors.amber,
                selectedColor: Colors.grey,
                todayStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (day, events, holidays) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) =>
                    Container(
                      margin: EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Text(date.day.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                todayDayBuilder: (context, date, events) =>
                  Container(
                    margin: EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Text(date.day.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
              title: Text(event),
            )),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.delete,
                    color: Color(0xFF494949),
                  ),
                  onPressed: (){
                    setState(() {
                      if(_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay] = [];
                      }
                      prefs.setString("events", json.encode(encodeMap(_events)));
                      _eventController.clear();
                    });
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFffbf00),
                  child: Icon(Icons.add,
                    color: Color(0xFF494949),
                  ),
                  onPressed: _showAddDialog,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Añadir evento',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        content: TextField(
          decoration: InputDecoration(
            hintText: '¿Algo nuevo?',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          controller: _eventController,
        ),
        actions: [
           FlatButton(
              color: Colors.amber,
              child: Text('Guardar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              onPressed: (){
                setState(() {
                  if(_eventController.text.isEmpty) return;
                  if(_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay].add(_eventController.text);
                  } else {
                    _events[_controller.selectedDay] = [_eventController.text];
                  }
                  prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });
              },
            ),
        ],
      ),
    );
  }
}
