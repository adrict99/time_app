import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Productivity extends StatefulWidget {
  static const String id = 'productivity_screen';

  @override
  _ProductivityState createState() => _ProductivityState();
}

class _ProductivityState extends State<Productivity> {

  final cache = AudioCache();
   var player = AudioPlayer();
  bool isPlaying = false;

  double percentage = 0;
  static int mins = 25;
  int secs = mins * 60;

  Timer timer;

  startTimer() {
    mins = 25;
    int Time = mins * 60;
    double secondPercentage = (Time/100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(Time > 0) {
          Time--;
          if(Time % 60 == 0) {
            mins--;
          } if (Time % secondPercentage == 0) {
            if(percentage <1){
              percentage += 0.01;
            } else {
              percentage = 1;
            }
          }
        } else {
          percentage = 0;
          mins = 25;
          timer.cancel();
        }
      });
    });
  }

  stopTimer() {
    setState(() {
      percentage = 0;
      mins = 0;
      timer.cancel();
    });
  }

  startBreak() {
    mins = 5;
    int Time = mins * 60;
    double secondPercentage = (Time/100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(Time > 0) {
          Time--;
          if(Time % 60 == 0) {
            mins--;
          } if (Time % secondPercentage == 0) {
            if(percentage <1){
              percentage += 0.01;
            } else {
              percentage = 1;
            }
          }
        } else {
          mins = 5;
          percentage = 0;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 80.0, top: 30.0, right: 25.0, bottom: 30.0),
              margin: EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('Productividad',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        child: Icon(
                          Icons.show_chart,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                        backgroundColor: Colors.white,
                        radius: 30.0,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('¡Hora de centrarse!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CircularPercentIndicator(
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: percentage,
                      animation: true,
                      animateFromLastPercent: true,
                      radius: 200.0,
                      lineWidth: 18.0,
                      progressColor: Colors.amber,
                      center: Text(
                        "$mins",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 70.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                   Container(
                      width: double.infinity,
                      height: 160.0,
                      decoration: BoxDecoration(
                        //color: Colors.grey,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  elevation: 5.0,
                                  color: Colors.amber,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 9.0,
                                      ),
                                      Text(
                                        "Empezar",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: startTimer,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 5.0,
                                  color: Colors.amber,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.stop,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 9.0,
                                      ),
                                      Text(
                                        "Parar",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: stopTimer,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 5.0,
                                  color: Colors.amber,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.free_breakfast,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 9.0,
                                      ),
                                      Text(
                                        "Descanso",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: startBreak,
                                ),
                              ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.music_note,
                ),
                radius: 29,
              ),
               SizedBox(
                 width: 10.0,
               ),
               FloatingActionButton(
                backgroundColor: Colors.amber,
                child: Icon(Icons.play_arrow, color: Color(0xFF494949)),
                  onPressed: () async {
                    player = await cache.loop('audio.mp3');
                  }
              ),
               FloatingActionButton(
                backgroundColor: Colors.amber,
                child: Icon(Icons.stop, color: Color(0xFF494949)),
                onPressed: () {
                  player.stop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
